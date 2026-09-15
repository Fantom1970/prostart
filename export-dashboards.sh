#!/bin/bash
# export-dashboards.sh — Exporta todos os dashboards do Grafana para arquivos de provisioning
# Fluxo de trabalho: editar na UI -> ./export-dashboards.sh -> ./sync.sh
# Credenciais vêm do .env (nunca hardcoded — este arquivo vai ao GitHub)

set -e

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$BASE_DIR/.env"

GRAFANA_URL="http://localhost:3000"
AUTH="${GRAFANA_ADMIN_USER}:${GRAFANA_ADMIN_PASSWORD}"
DEST_DIR="$BASE_DIR/grafana/dashboards"

mkdir -p "$DEST_DIR"

GRAFANA_AUTH="$AUTH" DEST_DIR="$DEST_DIR" GRAFANA_URL="$GRAFANA_URL" python3 << 'PYEOF'
import base64, json, os, re, unicodedata, urllib.request

auth = os.environ["GRAFANA_AUTH"]
dest = os.environ["DEST_DIR"]
url = os.environ["GRAFANA_URL"]
headers = {"Authorization": "Basic " + base64.b64encode(auth.encode()).decode()}

def api(path):
    req = urllib.request.Request(url + path, headers=headers)
    with urllib.request.urlopen(req) as r:
        return json.load(r)

dashboards = api("/api/search?type=dash-db")
if not dashboards:
    print("Nenhum dashboard encontrado no Grafana.")
    raise SystemExit(0)

for d in dashboards:
    dash = api(f"/api/dashboards/uid/{d['uid']}")["dashboard"]
    dash.pop("id", None)  # o provisioning resolve pelo uid; o id do banco nao vai no arquivo
    title = dash.get("title", d["uid"]).lower()
    slug = re.sub(r"[^a-z0-9]+", "-", unicodedata.normalize("NFD", title)).strip("-") or d["uid"]
    path = os.path.join(dest, slug + ".json")
    with open(path, "w", encoding="utf-8") as f:
        json.dump(dash, f, indent=2, ensure_ascii=False)
    print(f"Exportado: {path}")

print(f"\nTotal: {len(dashboards)} dashboard(s) exportado(s) para {dest}")
PYEOF
