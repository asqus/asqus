--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: graph_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY graph_types (id, name) FROM stdin;
1	Pie Chart
2	Bar
\.


--
-- Name: graph_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('graph_types_id_seq', 2, true);


--
-- Data for Name: mailing_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY mailing_statuses (id, name) FROM stdin;
1	Initial
2	Ready
3	Sending
4	Complete
5	Error
\.


--
-- Name: mailing_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mailing_statuses_id_seq', 1, false);


--
-- Data for Name: polity_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY polity_types (id, name) FROM stdin;
1	Nation
2	State
3	SenateSeat
4	CongressionalDistrict
5	StateSenateDistrict
6	StateHouseDistrict
7	County
8	Municipality
9	Ward
\.


--
-- Data for Name: office_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY office_types (id, ukey, name, title, abbreviated_title, polity_type_id, created_at, updated_at) FROM stdin;
1	POTUS	President	President	President	1	2013-05-14 23:39:19.830167	2013-05-14 23:39:19.830167
2	VPOTUS	Vice President	Vice President	V.P.	1	2013-05-14 23:39:19.923928	2013-05-14 23:39:19.923928
3	US_SENATOR	U.S. Senator	Senator	Sen.	3	2013-05-14 23:39:19.929546	2013-05-14 23:39:19.929546
4	US_REP	U.S. Representative	Representative	Rep.	4	2013-05-14 23:39:19.934108	2013-05-14 23:39:19.934108
5	GOVERNOR	Governor	Governor	Gov.	2	2013-05-14 23:39:19.938055	2013-05-14 23:39:19.938055
6	LT_GOVERNOR	Lieutenant Governor	Lieutenant Governor	Lt. Gov.	2	2013-05-14 23:39:19.941942	2013-05-14 23:39:19.941942
7	STATE_SENATOR	State Senator	Senator	Sen.	5	2013-05-14 23:39:19.945727	2013-05-14 23:39:19.945727
8	STATE_REP	State Representative	Representative	Rep.	6	2013-05-14 23:39:19.949539	2013-05-14 23:39:19.949539
9	MAYOR	Mayor	Mayor	Mayor	8	2013-05-14 23:39:19.953242	2013-05-14 23:39:19.953242
10	US_HOUSE_DELEGATE	House Delegate	Delegate	Del	4	2013-05-14 23:39:19.95708	2013-05-14 23:39:19.95708
\.


--
-- Name: office_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('office_types_id_seq', 10, true);


--
-- Name: polity_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('polity_types_id_seq', 9, true);


--
-- Data for Name: poll_workflow_states; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY poll_workflow_states (id, name) FROM stdin;
1	Start
2	Published
3	Closed
\.


--
-- Name: poll_workflow_states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('poll_workflow_states_id_seq', 3, true);


--
-- Data for Name: quick_poll_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY quick_poll_types (id, name) FROM stdin;
1	Public
2	Private
3	Anonymous
\.


--
-- Name: quick_poll_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('quick_poll_types_id_seq', 3, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20130323161751
20130701024857
20130606223937
20130718233318
20130731194329
20130816195311
20130820223955
20130905042933
\.


--
-- Data for Name: site_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY site_roles (id, name) FROM stdin;
1	User
2	Admin
\.


--
-- Name: site_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('site_roles_id_seq', 2, true);


--
-- PostgreSQL database dump complete
--

