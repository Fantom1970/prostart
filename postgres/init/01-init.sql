CREATE EXTENSION IF NOT EXISTS timescaledb;

CREATE SCHEMA IF NOT EXISTS telemetry;

CREATE TABLE IF NOT EXISTS telemetry.variables (
    id          SERIAL PRIMARY KEY,
    tag_name    VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    unit        VARCHAR(20),
    data_type   VARCHAR(20) DEFAULT 'float',
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS telemetry.measurements (
    time        TIMESTAMPTZ NOT NULL,
    variable_id INTEGER NOT NULL REFERENCES telemetry.variables(id),
    value       DOUBLE PRECISION,
    quality     SMALLINT DEFAULT 1
);

SELECT create_hypertable(
    'telemetry.measurements',
    'time',
    chunk_time_interval => INTERVAL '1 day',
    if_not_exists => TRUE
);

CREATE INDEX IF NOT EXISTS idx_measurements_var_time
    ON telemetry.measurements (variable_id, time DESC);

CREATE USER grafana_reader WITH PASSWORD 'Grafana@Dev2026';
GRANT USAGE ON SCHEMA telemetry TO grafana_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA telemetry TO grafana_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA telemetry
    GRANT SELECT ON TABLES TO grafana_reader;

INSERT INTO telemetry.variables (tag_name, description, unit)
VALUES ('prostart.laptop.temp', 'Temperatura de teste', '°C')
ON CONFLICT (tag_name) DO NOTHING;
