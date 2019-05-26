--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3 (Ubuntu 11.3-1.pgdg18.04+1)
-- Dumped by pg_dump version 11.3 (Ubuntu 11.3-1.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: BTEST; Type: SCHEMA; Schema: -; Owner: gilles
--

CREATE SCHEMA "BTEST";


ALTER SCHEMA "BTEST" OWNER TO gilles;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Empty$Table; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST"."Empty$Table" (
    id integer
);


ALTER TABLE "BTEST"."Empty$Table" OWNER TO gilles;

--
-- Name: T1; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST"."T1" (
    "COL1" integer,
    "COL2" text
);


ALTER TABLE "BTEST"."T1" OWNER TO gilles;

--
-- Name: t2; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST".t2 (
    id integer
);


ALTER TABLE "BTEST".t2 OWNER TO gilles;

--
-- Name: T1; Type: TABLE; Schema: public; Owner: gilles
--

CREATE TABLE public."T1" (
    "COL1" integer,
    "COL2" text
);


ALTER TABLE public."T1" OWNER TO gilles;

--
-- Name: t2; Type: TABLE; Schema: public; Owner: gilles
--

CREATE TABLE public.t2 (
    id integer
);


ALTER TABLE public.t2 OWNER TO gilles;

--
-- Data for Name: Empty$Table; Type: TABLE DATA; Schema: BTEST; Owner: gilles
--

COPY "BTEST"."Empty$Table" (id) FROM stdin;
\.


--
-- Data for Name: T1; Type: TABLE DATA; Schema: BTEST; Owner: gilles
--

COPY "BTEST"."T1" ("COL1", "COL2") FROM stdin;
1	blb 1
2	blb 2
3	blb 3
4	blb 4
5	blb 5
6	blb 6
7	blb 7
8	blb 8
9	blb 9
10	blb 10
11	blb 11
12	blb 12
13	blb 13
14	blb 14
15	blb 15
16	blb 16
17	blb 17
18	blb 18
19	blb 19
20	blb 20
21	blb 21
22	blb 22
23	blb 23
24	blb 24
25	blb 25
26	blb 26
27	blb 27
28	blb 28
29	blb 29
30	blb 30
31	blb 31
32	blb 32
33	blb 33
34	blb 34
35	blb 35
36	blb 36
37	blb 37
38	blb 38
39	blb 39
40	blb 40
41	blb 41
42	blb 42
43	blb 43
44	blb 44
45	blb 45
46	blb 46
47	blb 47
48	blb 48
49	blb 49
50	blb 50
51	blb 51
52	blb 52
53	blb 53
54	blb 54
55	blb 55
56	blb 56
57	blb 57
58	blb 58
59	blb 59
60	blb 60
61	blb 61
62	blb 62
63	blb 63
64	blb 64
65	blb 65
66	blb 66
67	blb 67
68	blb 68
69	blb 69
70	blb 70
71	blb 71
72	blb 72
73	blb 73
74	blb 74
75	blb 75
76	blb 76
77	blb 77
78	blb 78
79	blb 79
80	blb 80
81	blb 81
82	blb 82
83	blb 83
84	blb 84
85	blb 85
86	blb 86
87	blb 87
88	blb 88
89	blb 89
90	blb 90
91	blb 91
92	blb 92
93	blb 93
94	blb 94
95	blb 95
96	blb 96
97	blb 97
98	blb 98
99	blb 99
100	blb 100
\.


--
-- Data for Name: t2; Type: TABLE DATA; Schema: BTEST; Owner: gilles
--

COPY "BTEST".t2 (id) FROM stdin;
2
3
4
5
6
7
8
9
10
\.


--
-- Data for Name: T1; Type: TABLE DATA; Schema: public; Owner: gilles
--

COPY public."T1" ("COL1", "COL2") FROM stdin;
1	blb 1
2	blb 2
3	blb 3
4	blb 4
5	blb 5
6	blb 6
7	blb 7
8	blb 8
9	blb 9
10	blb 10
11	blb 11
12	blb 12
13	blb 13
14	blb 14
15	blb 15
16	blb 16
17	blb 17
18	blb 18
19	blb 19
20	blb 20
21	blb 21
22	blb 22
23	blb 23
24	blb 24
25	blb 25
26	blb 26
27	blb 27
28	blb 28
29	blb 29
30	blb 30
31	blb 31
32	blb 32
33	blb 33
34	blb 34
35	blb 35
36	blb 36
37	blb 37
38	blb 38
39	blb 39
40	blb 40
41	blb 41
42	blb 42
43	blb 43
44	blb 44
45	blb 45
46	blb 46
47	blb 47
48	blb 48
49	blb 49
50	blb 50
51	blb 51
52	blb 52
53	blb 53
54	blb 54
55	blb 55
56	blb 56
57	blb 57
58	blb 58
59	blb 59
60	blb 60
61	blb 61
62	blb 62
63	blb 63
64	blb 64
65	blb 65
66	blb 66
67	blb 67
68	blb 68
69	blb 69
70	blb 70
71	blb 71
72	blb 72
73	blb 73
74	blb 74
75	blb 75
76	blb 76
77	blb 77
78	blb 78
79	blb 79
80	blb 80
81	blb 81
82	blb 82
83	blb 83
84	blb 84
85	blb 85
86	blb 86
87	blb 87
88	blb 88
89	blb 89
90	blb 90
91	blb 91
92	blb 92
93	blb 93
94	blb 94
95	blb 95
96	blb 96
97	blb 97
98	blb 98
99	blb 99
100	blb 100
\.


--
-- Data for Name: t2; Type: TABLE DATA; Schema: public; Owner: gilles
--

COPY public.t2 (id) FROM stdin;
1
2
3
4
5
6
7
8
9
10
\.


--
-- PostgreSQL database dump complete
--

