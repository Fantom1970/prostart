--
-- PostgreSQL database dump
--

\restrict ghKcN9EngBncKkaZXdPvr8PGjANZxXVxfAtT7yF7BUcbmOOQgUS8rhinBwGEyXR

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
-- Data for Name: enterprises; Type: TABLE DATA; Schema: public; Owner: prostart
--

COPY public.enterprises (ent_id, ent_nam, ent_sts, db_crt) FROM stdin;
1	Zelopack	t	2026-09-09 22:19:17.561095
\.


--
-- Name: enterprises_ent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prostart
--

SELECT pg_catalog.setval('public.enterprises_ent_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

\unrestrict ghKcN9EngBncKkaZXdPvr8PGjANZxXVxfAtT7yF7BUcbmOOQgUS8rhinBwGEyXR

