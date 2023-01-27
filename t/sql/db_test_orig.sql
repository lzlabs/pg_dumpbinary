--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Ubuntu 14.2-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.2 (Ubuntu 14.2-1.pgdg20.04+1)

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

--
-- Name: SEQNSP; Type: SCHEMA; Schema: -; Owner: gilles
--

CREATE SCHEMA "SEQNSP";


ALTER SCHEMA "SEQNSP" OWNER TO gilles;

SET default_tablespace = '';

SET default_table_access_method = heap;

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
-- Name: empty_measurement; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST".empty_measurement (
    logdate date NOT NULL,
    peaktemp integer,
    unitsales integer
)
PARTITION BY RANGE (logdate);


ALTER TABLE "BTEST".empty_measurement OWNER TO gilles;

--
-- Name: measurement; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST".measurement (
    logdate date NOT NULL,
    peaktemp integer,
    unitsales integer
)
PARTITION BY RANGE (logdate);


ALTER TABLE "BTEST".measurement OWNER TO gilles;

--
-- Name: measurement_default; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST".measurement_default (
    logdate date NOT NULL,
    peaktemp integer,
    unitsales integer
);


ALTER TABLE "BTEST".measurement_default OWNER TO gilles;

--
-- Name: measurement_y2016; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST".measurement_y2016 (
    logdate date NOT NULL,
    peaktemp integer,
    unitsales integer
);


ALTER TABLE "BTEST".measurement_y2016 OWNER TO gilles;

--
-- Name: measurement_y2017; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST".measurement_y2017 (
    logdate date NOT NULL,
    peaktemp integer,
    unitsales integer
);


ALTER TABLE "BTEST".measurement_y2017 OWNER TO gilles;

--
-- Name: t2; Type: TABLE; Schema: BTEST; Owner: gilles
--

CREATE TABLE "BTEST".t2 (
    id integer
);


ALTER TABLE "BTEST".t2 OWNER TO gilles;

--
-- Name: test_seq1; Type: TABLE; Schema: SEQNSP; Owner: gilles
--

CREATE TABLE "SEQNSP".test_seq1 (
    id integer NOT NULL,
    lbl text
);


ALTER TABLE "SEQNSP".test_seq1 OWNER TO gilles;

--
-- Name: test_seq1_id_seq; Type: SEQUENCE; Schema: SEQNSP; Owner: gilles
--

CREATE SEQUENCE "SEQNSP".test_seq1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "SEQNSP".test_seq1_id_seq OWNER TO gilles;

--
-- Name: test_seq1_id_seq; Type: SEQUENCE OWNED BY; Schema: SEQNSP; Owner: gilles
--

ALTER SEQUENCE "SEQNSP".test_seq1_id_seq OWNED BY "SEQNSP".test_seq1.id;


--
-- Name: test_seq2; Type: TABLE; Schema: SEQNSP; Owner: gilles
--

CREATE TABLE "SEQNSP".test_seq2 (
    id integer NOT NULL,
    lbl character varying NOT NULL
);


ALTER TABLE "SEQNSP".test_seq2 OWNER TO gilles;

--
-- Name: test_seq2_id_seq; Type: SEQUENCE; Schema: SEQNSP; Owner: gilles
--

ALTER TABLE "SEQNSP".test_seq2 ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "SEQNSP".test_seq2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- Name: measurement_default; Type: TABLE ATTACH; Schema: BTEST; Owner: gilles
--

ALTER TABLE ONLY "BTEST".measurement ATTACH PARTITION "BTEST".measurement_default DEFAULT;


--
-- Name: measurement_y2016; Type: TABLE ATTACH; Schema: BTEST; Owner: gilles
--

ALTER TABLE ONLY "BTEST".measurement ATTACH PARTITION "BTEST".measurement_y2016 FOR VALUES FROM ('2016-01-01') TO ('2017-01-01');


--
-- Name: measurement_y2017; Type: TABLE ATTACH; Schema: BTEST; Owner: gilles
--

ALTER TABLE ONLY "BTEST".measurement ATTACH PARTITION "BTEST".measurement_y2017 FOR VALUES FROM ('2017-01-01') TO ('2018-01-01');


--
-- Name: test_seq1 id; Type: DEFAULT; Schema: SEQNSP; Owner: gilles
--

ALTER TABLE ONLY "SEQNSP".test_seq1 ALTER COLUMN id SET DEFAULT nextval('"SEQNSP".test_seq1_id_seq'::regclass);


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
-- Data for Name: measurement_default; Type: TABLE DATA; Schema: BTEST; Owner: gilles
--

COPY "BTEST".measurement_default (logdate, peaktemp, unitsales) FROM stdin;
2018-07-10	66	100
\.


--
-- Data for Name: measurement_y2016; Type: TABLE DATA; Schema: BTEST; Owner: gilles
--

COPY "BTEST".measurement_y2016 (logdate, peaktemp, unitsales) FROM stdin;
2016-07-10	44	140
\.


--
-- Data for Name: measurement_y2017; Type: TABLE DATA; Schema: BTEST; Owner: gilles
--

COPY "BTEST".measurement_y2017 (logdate, peaktemp, unitsales) FROM stdin;
2017-07-10	66	100
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
-- Data for Name: test_seq1; Type: TABLE DATA; Schema: SEQNSP; Owner: gilles
--

COPY "SEQNSP".test_seq1 (id, lbl) FROM stdin;
1	one
2	two
3	three
4	four
5	five
\.


--
-- Data for Name: test_seq2; Type: TABLE DATA; Schema: SEQNSP; Owner: gilles
--

COPY "SEQNSP".test_seq2 (id, lbl) FROM stdin;
1	one
2	two
3	three
4	four
5	five
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
-- Name: test_seq1_id_seq; Type: SEQUENCE SET; Schema: SEQNSP; Owner: gilles
--

SELECT pg_catalog.setval('"SEQNSP".test_seq1_id_seq', 5, true);


--
-- Name: test_seq2_id_seq; Type: SEQUENCE SET; Schema: SEQNSP; Owner: gilles
--

SELECT pg_catalog.setval('"SEQNSP".test_seq2_id_seq', 5, true);


--
-- Name: ixsales; Type: INDEX; Schema: BTEST; Owner: gilles
--

CREATE INDEX ixsales ON ONLY "BTEST".measurement USING btree (unitsales);


--
-- Name: measurement_default_unitsales_idx; Type: INDEX; Schema: BTEST; Owner: gilles
--

CREATE INDEX measurement_default_unitsales_idx ON "BTEST".measurement_default USING btree (unitsales);


--
-- Name: measurement_y2016_unitsales_idx; Type: INDEX; Schema: BTEST; Owner: gilles
--

CREATE INDEX measurement_y2016_unitsales_idx ON "BTEST".measurement_y2016 USING btree (unitsales);


--
-- Name: measurement_y2017_unitsales_idx; Type: INDEX; Schema: BTEST; Owner: gilles
--

CREATE INDEX measurement_y2017_unitsales_idx ON "BTEST".measurement_y2017 USING btree (unitsales);


--
-- Name: measurement_default_unitsales_idx; Type: INDEX ATTACH; Schema: BTEST; Owner: gilles
--

ALTER INDEX "BTEST".ixsales ATTACH PARTITION "BTEST".measurement_default_unitsales_idx;


--
-- Name: measurement_y2016_unitsales_idx; Type: INDEX ATTACH; Schema: BTEST; Owner: gilles
--

ALTER INDEX "BTEST".ixsales ATTACH PARTITION "BTEST".measurement_y2016_unitsales_idx;


--
-- Name: measurement_y2017_unitsales_idx; Type: INDEX ATTACH; Schema: BTEST; Owner: gilles
--

ALTER INDEX "BTEST".ixsales ATTACH PARTITION "BTEST".measurement_y2017_unitsales_idx;


--
-- PostgreSQL database dump complete
--

