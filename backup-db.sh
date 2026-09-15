#!/bin/bash
# Dump diário do banco ProStart
set -euo pipefail
cd ~/prostart-dev

source .env 2>/dev/null || true
BACKUP_DIR="backups"
mkdir -p "$BACKUP_DIR"
ARQ="$BACKUP_DIR/prostart-$(date '+%Y%m%d').sql.gz"

docker exec prostart-db pg_dump -U prostart -d prostart | gzip > "$ARQ"

# mantém só os últimos 14 dias
ls -t "$BACKUP_DIR"/prostart-*.sql.gz | tail -n +15 | xargs -r rm

echo "✅ Backup criado: $ARQ ($(du -h $ARQ | cut -f1))"
