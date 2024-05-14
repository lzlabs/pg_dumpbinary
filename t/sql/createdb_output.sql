--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)

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
-- Name: test_bin_dump_orig; Type: DATABASE; Schema: -; Owner: gilles
--

CREATE DATABASE test_bin_dump_orig WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'fr_FR.UTF-8';


ALTER DATABASE test_bin_dump_orig OWNER TO gilles;

\connect test_bin_dump_orig

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


ALTER SEQUENCE "SEQNSP".test_seq1_id_seq OWNER TO gilles;

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
-- PostgreSQL database dump complete
--

\o
\echo Restoring data to table "BTEST"."T1"
\copy "BTEST"."T1"  FROM 't/test_bin_dump/data-BTEST.T1.bin' WITH (FORMAT binary);
\o
\echo Restoring data to table "BTEST".measurement_default
\copy "BTEST".measurement_default  FROM 't/test_bin_dump/data-BTEST.measurement_default.bin' WITH (FORMAT binary);
\o
\echo Restoring data to table "BTEST".measurement_y2016
\copy "BTEST".measurement_y2016  FROM 't/test_bin_dump/data-BTEST.measurement_y2016.bin' WITH (FORMAT binary);
\o
\echo Restoring data to table "BTEST".measurement_y2017
\copy "BTEST".measurement_y2017  FROM 't/test_bin_dump/data-BTEST.measurement_y2017.bin' WITH (FORMAT binary);
\o
\echo Restoring data to table "BTEST".t2
\copy "BTEST".t2  FROM 't/test_bin_dump/data-BTEST.t2.bin' WITH (FORMAT binary);
\o
\echo Restoring data to table "SEQNSP".test_seq1
\copy "SEQNSP".test_seq1  FROM 't/test_bin_dump/data-SEQNSP.test_seq1.bin' WITH (FORMAT binary);
\o
\echo Restoring data to table "SEQNSP".test_seq2
\copy "SEQNSP".test_seq2  FROM 't/test_bin_dump/data-SEQNSP.test_seq2.bin' WITH (FORMAT binary);
\o
\echo Restoring data to table public."T1"
\copy public."T1"  FROM 't/test_bin_dump/data-public.T1.bin' WITH (FORMAT binary);
\o
\echo Restoring data to table public.t2
\copy public.t2 (id) FROM 't/test_bin_dump/data-public.t2.bin' WITH (FORMAT binary);
SELECT pg_catalog.setval('"SEQNSP".test_seq1_id_seq', 5, true);
SELECT pg_catalog.setval('"SEQNSP".test_seq2_id_seq', 5, true);
--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)

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

SET default_tablespace = '';

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

