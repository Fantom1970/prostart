#!/usr/bin/env python3
"""
Simulação contínua de estados operacionais — ProStart
Modelo: cada equipamento está SEMPRE em algum estado (cadeia contígua,
fim de um evento = início do próximo). O último evento de cada unidade
fica aberto (sta_end IS NULL), estendendo o estado até o presente.
Timestamps em UTC, granularidade de minutos redondos.
Uso: python3 simulate_status.py [dias_para_trás]
"""
import random, subprocess, sys, datetime as dt

SEED     = 42          # determinístico: mesma seed = mesma série
ENT_ID   = 1
DAYS_BACK = int(sys.argv[1]) if len(sys.argv) > 1 else 7
UNITS = [600, 610, 620, 700, 710, 720, 801, 802, 803, 901, 902, 903,
         911, 912, 913, 921, 922, 923, 931, 932, 933, 941, 942, 943,
         6000, 6100, 7000]

random.seed(SEED)

# duração (mín, máx) em minutos por sta_id
DUR = {0: (20, 180),  1: (15, 45),   2: (10, 30),  3: (5, 20),
       4: (10, 25),   5: (5, 15),    6: (60, 240), 7: (10, 30),
       8: (5, 15),    9: (15, 40),  10: (15, 40), 11: (30, 90),
       12: (30, 120)}

TRANSITIONS = {
    0:  [0]*6 + [3, 12],        # repouso; ocasionalmente reserva/manutenção
    3:  [2, 5, 0],              # Reservado -> Formulando/Pronto/repouso
    5:  [2, 1],                 # Pronto -> Formulando/CIP
    2:  [6, 4],                 # Formulando -> Produção/Esterilização
    4:  [6, 5],                 # Esterilização -> Produção/Pronto
    6:  [6]*4 + [7, 11, 10],    # Produção longa; às vezes recircula
    7:  [8, 1],                 # Enxágue -> Liberação/CIP
    8:  [0, 3],                 # Liberação -> repouso/reserva
    1:  [0, 5],                 # CIP -> repouso/Pronto
    9:  [9, 6, 1],              # Recirc. Pasteurizador
    10: [10, 11, 6],            # Recirc. com Tanque
    11: [11, 6, 7],             # Produção c/ Recirculação
    12: [0, 5],                 # Manutenção -> repouso/Pronto
}

def next_state(cur):
    return random.choice(TRANSITIONS.get(cur, [0]))

def simulate_unit(start, now):
    events, t, cur = [], start, 0
    while True:
        lo, hi = DUR[cur]
        end = t + dt.timedelta(minutes=random.randint(lo, hi))
        if end >= now:
            events.append((t, None, cur))   # aberto até o presente
            break
        events.append((t, end, cur))
        t, cur = end, next_state(cur)
    return events

now   = dt.datetime.utcnow().replace(second=0, microsecond=0)
start = now - dt.timedelta(days=DAYS_BACK)

rows = []
for un in UNITS:
    for b, e, s in simulate_unit(start, now):
        rows.append((ENT_ID, un, s, b, e))

lines = ["TRUNCATE TABLE status RESTART IDENTITY;", "BEGIN;"]
buf = []
for ent, un, s, b, e in rows:
    bgn = b.strftime("%Y-%m-%d %H:%M:00")
    end = "NULL" if e is None else f"'{e.strftime('%Y-%m-%d %H:%M:00')}'"
    buf.append(f"({ent},{un},{s},'{bgn}',{end})")
    if len(buf) == 500:
        lines.append("INSERT INTO status (ent_id, un_id, sta_id, sta_bgn, sta_end) VALUES "
                     + ",".join(buf) + ";")
        buf = []
if buf:
    lines.append("INSERT INTO status (ent_id, un_id, sta_id, sta_bgn, sta_end) VALUES "
                 + ",".join(buf) + ";")
lines.append("COMMIT;")

sql = "\n".join(lines) + "\n"
subprocess.run(
    ["docker", "exec", "-i", "prostart-db", "psql", "-U", "prostart", "-d", "prostart",
     "-v", "ON_ERROR_STOP=1"],
    input=sql.encode(), check=True)

print(f"OK: {len(rows)} eventos | janela {start} -> {now} UTC | "
      f"último evento aberto em cada uma das {len(UNITS)} unidades.")
