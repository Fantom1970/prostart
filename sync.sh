#!/bin/bash
# Sync ProStart: exporta dashboards, valida e sobe para o GitHub
set -euo pipefail
cd ~/prostart-dev

GRAFANA_AUTH="admin:ProStart@Dev2026"
API="http://localhost:3000/api/dashboards/uid"
DASH="grafana/dashboards"
ERRO=0

declare -A dashboards=(
  ["PE02C6D58FFD076CD"]="status-line-1"
  ["adjfzxv"]="status-line-2"
  ["adc58hk"]="status-line-3"
  ["ad29mzk"]="production-overview"
  ["adwqwrr"]="steps"
)

mkdir -p "$DASH"

for uid in "${!dashboards[@]}"; do
  RESP=$(curl -sf -u "$GRAFANA_AUTH" "$API/$uid" || { echo "ERRO: Grafana inacessível"; ERRO=1; break; })
  echo "$RESP" | python3 -c "
import sys, json
d = json.load(sys.stdin)['dashboard']
d.pop('id', None)
print(json.dumps(d, indent=2))
" > "$DASH/${dashboards[$uid]}.json"
  python3 -m json.tool "$DASH/${dashboards[$uid]}.json" > /dev/null \
    || { echo "ERRO: ${dashboards[$uid]}.json inválido — abortando"; ERRO=1; }
done

[ $ERRO -eq 1 ] && { echo "Sync interrompido: nada foi commitado."; exit 1; }

git add -A
if git diff --cached --quiet; then
  echo "Nada novo para commitar."
else
  git commit -m "Sync automático: $(date '+%d/%m %H:%M')"
  git push && echo "✅ GitHub atualizado em $(date '+%H:%M')"
fi
