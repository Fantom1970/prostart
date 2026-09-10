--
-- PostgreSQL database dump
--

\restrict vL5aTzLraU6zxnSktsCpJyS4c53C8fkWgPIejnRChYCEGxKeqJUAQQEBZXN62pF

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
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: prostart
--

COPY public.units (un_id, ent_id, un_cod, un_nam, un_typ, un_sts, db_crt) FROM stdin;
1	1	PST480_01	Embaladora 01	Embaladora	t	2026-09-09 22:19:17.563587
\.


--
-- Name: units_un_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prostart
--

SELECT pg_catalog.setval('public.units_un_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

\unrestrict vL5aTzLraU6zxnSktsCpJyS4c53C8fkWgPIejnRChYCEGxKeqJUAQQEBZXN62pF

