--
-- PostgreSQL database dump
--

\restrict e6Al21oJfcov9ntcocjguZA7V6rk8RYfrONhufYSBA0QL3WXzI4FT9AHbARdRqf

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
-- Data for Name: status_catalog; Type: TABLE DATA; Schema: public; Owner: prostart
--

COPY public.status_catalog (sta_id, sta_nam, sta_grp, sta_col, db_crt) FROM stdin;
0	Sem Produção	Sem Produção	#7F7F7F	2026-09-10 14:38:42.115717
1	CIP	CIP	#FF00FF	2026-09-09 22:19:17.566452
2	Formulando	Formulando	#006400	2026-09-09 22:19:17.569229
3	Reservado	Reservado	#FF960A	2026-09-09 22:19:18.874263
4	Esterilização	Esterilização	#FF0000	2026-09-09 22:51:42.522225
5	Pronto	Pronto	#642323	2026-09-10 14:38:42.115717
6	Produção	Produção	#00FF00	2026-09-09 23:55:42.883929
7	Enxágue	Enxágue	#00FFFF	2026-09-10 14:38:42.115717
8	Liberação após Enxágue	Liberação após Enxágue	#4B6432	2026-09-10 14:38:42.115717
9	Recirculação do Pasteurizador	Recirculação do Pasteurizador	#FFBE00	2026-09-10 14:38:42.115717
10	Recirculação com Tanque	Recirculação com Tanque	#640064	2026-09-10 14:38:42.115717
11	Produção com Recirculação com Tanque	Produção com Recirculação com Tanque	#FF3232	2026-09-10 14:38:42.115717
12	Manutenção	Manutenção	#143264	2026-09-10 14:38:42.115717
\.


--
-- Name: status_catalog_sta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prostart
--

SELECT pg_catalog.setval('public.status_catalog_sta_id_seq', 4, true);


--
-- PostgreSQL database dump complete
--

\unrestrict e6Al21oJfcov9ntcocjguZA7V6rk8RYfrONhufYSBA0QL3WXzI4FT9AHbARdRqf

