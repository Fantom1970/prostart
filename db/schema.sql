--
-- PostgreSQL database dump
--

\restrict SbbUrRbNXI7unLAjkaP1RMASiNqOxBriV36hdTWhCgnwobIKKLcWveKuSaENNsb

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data (Community Edition)';


--
-- Name: telemetry; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA telemetry;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: enterprises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprises (
    ent_id integer NOT NULL,
    ent_nam character varying(100) NOT NULL,
    ent_sts boolean DEFAULT true,
    db_crt timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: enterprises_ent_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprises_ent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprises_ent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprises_ent_id_seq OWNED BY public.enterprises.ent_id;


--
-- Name: status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.status (
    id bigint NOT NULL,
    ent_id integer NOT NULL,
    un_id integer NOT NULL,
    sta_id integer NOT NULL,
    sta_bgn timestamp without time zone DEFAULT now() NOT NULL,
    sta_end timestamp without time zone,
    db_crt timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: process_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.process_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: process_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.process_events_id_seq OWNED BY public.status.id;


--
-- Name: status_catalog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.status_catalog (
    sta_id integer NOT NULL,
    sta_nam character varying(100) NOT NULL,
    sta_grp character varying(50),
    sta_col character varying(7),
    db_crt timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: status_catalog_sta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.status_catalog_sta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: status_catalog_sta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.status_catalog_sta_id_seq OWNED BY public.status_catalog.sta_id;


--
-- Name: step_catalog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.step_catalog (
    un_id integer NOT NULL,
    stp_id integer NOT NULL,
    stp_nam character varying(100) NOT NULL,
    stp_col character varying(7),
    stp_grp character varying(50)
);


--
-- Name: steps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.steps (
    id bigint NOT NULL,
    ent_id integer NOT NULL,
    un_id integer NOT NULL,
    stp_id integer NOT NULL,
    stp_bgn timestamp without time zone DEFAULT now() NOT NULL,
    stp_end timestamp without time zone,
    db_crt timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: steps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.steps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: steps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.steps_id_seq OWNED BY public.steps.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.units (
    un_id integer NOT NULL,
    ent_id integer NOT NULL,
    un_cod character varying(50) NOT NULL,
    un_nam character varying(100) NOT NULL,
    un_typ character varying(50),
    un_sts boolean DEFAULT true,
    db_crt timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: units_un_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.units_un_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: units_un_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.units_un_id_seq OWNED BY public.units.un_id;


--
-- Name: measurements; Type: TABLE; Schema: telemetry; Owner: -
--

CREATE TABLE telemetry.measurements (
    "time" timestamp with time zone NOT NULL,
    variable_id integer NOT NULL,
    value double precision,
    quality smallint DEFAULT 1
);


--
-- Name: variables; Type: TABLE; Schema: telemetry; Owner: -
--

CREATE TABLE telemetry.variables (
    id integer NOT NULL,
    tag_name character varying(100) NOT NULL,
    description text,
    unit character varying(20),
    data_type character varying(20) DEFAULT 'float'::character varying,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: variables_id_seq; Type: SEQUENCE; Schema: telemetry; Owner: -
--

CREATE SEQUENCE telemetry.variables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variables_id_seq; Type: SEQUENCE OWNED BY; Schema: telemetry; Owner: -
--

ALTER SEQUENCE telemetry.variables_id_seq OWNED BY telemetry.variables.id;


--
-- Name: enterprises ent_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises ALTER COLUMN ent_id SET DEFAULT nextval('public.enterprises_ent_id_seq'::regclass);


--
-- Name: status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.process_events_id_seq'::regclass);


--
-- Name: status_catalog sta_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status_catalog ALTER COLUMN sta_id SET DEFAULT nextval('public.status_catalog_sta_id_seq'::regclass);


--
-- Name: steps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steps ALTER COLUMN id SET DEFAULT nextval('public.steps_id_seq'::regclass);


--
-- Name: units un_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units ALTER COLUMN un_id SET DEFAULT nextval('public.units_un_id_seq'::regclass);


--
-- Name: variables id; Type: DEFAULT; Schema: telemetry; Owner: -
--

ALTER TABLE ONLY telemetry.variables ALTER COLUMN id SET DEFAULT nextval('telemetry.variables_id_seq'::regclass);


--
-- Name: enterprises enterprises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises
    ADD CONSTRAINT enterprises_pkey PRIMARY KEY (ent_id);


--
-- Name: status process_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT process_events_pkey PRIMARY KEY (id);


--
-- Name: status_catalog status_catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status_catalog
    ADD CONSTRAINT status_catalog_pkey PRIMARY KEY (sta_id);


--
-- Name: step_catalog step_catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.step_catalog
    ADD CONSTRAINT step_catalog_pkey PRIMARY KEY (un_id, stp_id);


--
-- Name: steps steps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_pkey PRIMARY KEY (id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (un_id);


--
-- Name: units units_un_cod_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_un_cod_key UNIQUE (un_cod);


--
-- Name: variables variables_pkey; Type: CONSTRAINT; Schema: telemetry; Owner: -
--

ALTER TABLE ONLY telemetry.variables
    ADD CONSTRAINT variables_pkey PRIMARY KEY (id);


--
-- Name: variables variables_tag_name_key; Type: CONSTRAINT; Schema: telemetry; Owner: -
--

ALTER TABLE ONLY telemetry.variables
    ADD CONSTRAINT variables_tag_name_key UNIQUE (tag_name);


--
-- Name: idx_proc_evt_sta_end; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proc_evt_sta_end ON public.status USING btree (sta_end);


--
-- Name: idx_proc_evt_sta_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proc_evt_sta_id ON public.status USING btree (sta_id);


--
-- Name: idx_proc_evt_unit; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proc_evt_unit ON public.status USING btree (un_id, ent_id);


--
-- Name: idx_steps_end; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_steps_end ON public.steps USING btree (stp_end);


--
-- Name: idx_steps_unit; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_steps_unit ON public.steps USING btree (un_id, ent_id);


--
-- Name: idx_units_ent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_units_ent_id ON public.units USING btree (ent_id);


--
-- Name: idx_measurements_var_time; Type: INDEX; Schema: telemetry; Owner: -
--

CREATE INDEX idx_measurements_var_time ON telemetry.measurements USING btree (variable_id, "time" DESC);


--
-- Name: measurements_time_idx; Type: INDEX; Schema: telemetry; Owner: -
--

CREATE INDEX measurements_time_idx ON telemetry.measurements USING btree ("time" DESC);


--
-- Name: status process_events_ent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT process_events_ent_id_fkey FOREIGN KEY (ent_id) REFERENCES public.enterprises(ent_id);


--
-- Name: status process_events_sta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT process_events_sta_id_fkey FOREIGN KEY (sta_id) REFERENCES public.status_catalog(sta_id);


--
-- Name: status process_events_un_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT process_events_un_id_fkey FOREIGN KEY (un_id) REFERENCES public.units(un_id);


--
-- Name: step_catalog step_catalog_un_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.step_catalog
    ADD CONSTRAINT step_catalog_un_id_fkey FOREIGN KEY (un_id) REFERENCES public.units(un_id);


--
-- Name: steps steps_ent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_ent_id_fkey FOREIGN KEY (ent_id) REFERENCES public.enterprises(ent_id);


--
-- Name: steps steps_un_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_un_id_fkey FOREIGN KEY (un_id) REFERENCES public.units(un_id);


--
-- Name: steps steps_un_id_stp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_un_id_stp_id_fkey FOREIGN KEY (un_id, stp_id) REFERENCES public.step_catalog(un_id, stp_id);


--
-- Name: units units_ent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_ent_id_fkey FOREIGN KEY (ent_id) REFERENCES public.enterprises(ent_id);


--
-- Name: measurements measurements_variable_id_fkey; Type: FK CONSTRAINT; Schema: telemetry; Owner: -
--

ALTER TABLE ONLY telemetry.measurements
    ADD CONSTRAINT measurements_variable_id_fkey FOREIGN KEY (variable_id) REFERENCES telemetry.variables(id);


--
-- Name: SCHEMA telemetry; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA telemetry TO grafana_reader;


--
-- Name: TABLE measurements; Type: ACL; Schema: telemetry; Owner: -
--

GRANT SELECT ON TABLE telemetry.measurements TO grafana_reader;


--
-- Name: TABLE variables; Type: ACL; Schema: telemetry; Owner: -
--

GRANT SELECT ON TABLE telemetry.variables TO grafana_reader;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: telemetry; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE prostart IN SCHEMA telemetry GRANT SELECT ON TABLES TO grafana_reader;


--
-- PostgreSQL database dump complete
--

\unrestrict SbbUrRbNXI7unLAjkaP1RMASiNqOxBriV36hdTWhCgnwobIKKLcWveKuSaENNsb

