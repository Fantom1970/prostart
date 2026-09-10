#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="./backups/$DATE"
mkdir -p "$BACKUP_DIR"

echo ">>> Backup PostgreSQL..."
docker exec prostart-db pg_dump -U prostart -d prostart \
    | gzip > "$BACKUP_DIR/postgres.sql.gz"

echo ">>> Backup fluxos Node-RED..."
docker cp prostart-nodered:/data/flows.json "$BACKUP_DIR/flows.json" 2>/dev/null
docker cp prostart-nodered:/data/flows_cred.json "$BACKUP_DIR/flows_cred.json" 2>/dev/null

echo ">>> Backup config Mosquitto..."
docker cp prostart-mosquitto:/mosquitto/config "$BACKUP_DIR/mosquitto_config" 2>/dev/null

echo ">>> Backup Grafana dashboards..."
docker cp prostart-grafana:/var/lib/grafana/dashboards "$BACKUP_DIR/grafana_dashboards" 2>/dev/null

ls -dt ./backups/*/ | tail -n +8 | xargs rm -rf 2>/dev/null

echo ">>> Backup concluído em $BACKUP_DIR"
