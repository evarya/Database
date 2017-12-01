--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

-- Started on 2017-12-01 23:12:35

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 192 (class 1259 OID 17984)
-- Name: brightness; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE brightness (
    brightness_id integer NOT NULL,
    visible_mag numeric NOT NULL,
    CONSTRAINT brightness_visible_mag_check CHECK ((visible_mag < (5)::numeric))
);


ALTER TABLE brightness OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 17982)
-- Name: brightness_brightness_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE brightness_brightness_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE brightness_brightness_id_seq OWNER TO postgres;

--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 191
-- Name: brightness_brightness_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE brightness_brightness_id_seq OWNED BY brightness.brightness_id;


--
-- TOC entry 194 (class 1259 OID 17998)
-- Name: catalogues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE catalogues (
    catalogue_id integer NOT NULL,
    catalogue_name text NOT NULL,
    year_of_publ date,
    numofobj integer,
    abbreviation text,
    CONSTRAINT catalogues_abbreviation_check CHECK ((length(abbreviation) < 30)),
    CONSTRAINT catalogues_catalogue_name_check CHECK ((length(catalogue_name) < 80)),
    CONSTRAINT catalogues_numofobj_check CHECK ((numofobj > 1000)),
    CONSTRAINT catalogues_year_of_publ_check CHECK (((year_of_publ >= '1900-01-01'::date) AND (year_of_publ <= ('now'::text)::date)))
);


ALTER TABLE catalogues OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 17996)
-- Name: catalogues_catalogue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE catalogues_catalogue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE catalogues_catalogue_id_seq OWNER TO postgres;

--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 193
-- Name: catalogues_catalogue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE catalogues_catalogue_id_seq OWNED BY catalogues.catalogue_id;


--
-- TOC entry 188 (class 1259 OID 17945)
-- Name: constellations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE constellations (
    constellation_id integer NOT NULL,
    constellation_name text NOT NULL,
    CONSTRAINT constellations_constellation_name_check CHECK ((length(constellation_name) < 30))
);


ALTER TABLE constellations OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 17943)
-- Name: constellations_constellation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE constellations_constellation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE constellations_constellation_id_seq OWNER TO postgres;

--
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 187
-- Name: constellations_constellation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE constellations_constellation_id_seq OWNED BY constellations.constellation_id;


--
-- TOC entry 186 (class 1259 OID 17931)
-- Name: star_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE star_types (
    star_type_id integer NOT NULL,
    type_name text NOT NULL,
    CONSTRAINT star_types_type_name_check CHECK ((length(type_name) < 30))
);


ALTER TABLE star_types OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 17929)
-- Name: star_types_star_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE star_types_star_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE star_types_star_type_id_seq OWNER TO postgres;

--
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 185
-- Name: star_types_star_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE star_types_star_type_id_seq OWNED BY star_types.star_type_id;


--
-- TOC entry 190 (class 1259 OID 17959)
-- Name: stars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE stars (
    star_id integer NOT NULL,
    star_name text NOT NULL,
    spectral_type text,
    variable_star boolean NOT NULL,
    star_type_id integer,
    constellation_id integer,
    CONSTRAINT stars_spectral_type_check CHECK ((length(spectral_type) < 30)),
    CONSTRAINT stars_star_name_check CHECK ((length(star_name) < 30))
);


ALTER TABLE stars OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 18013)
-- Name: stars_brightness_relationships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE stars_brightness_relationships (
    star_id integer NOT NULL,
    brightness_id integer NOT NULL
);


ALTER TABLE stars_brightness_relationships OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 18028)
-- Name: stars_catalogues_relationships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE stars_catalogues_relationships (
    star_id integer NOT NULL,
    catalogue_id integer NOT NULL,
    numincat integer NOT NULL
);


ALTER TABLE stars_catalogues_relationships OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 17957)
-- Name: stars_star_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stars_star_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stars_star_id_seq OWNER TO postgres;

--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 189
-- Name: stars_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE stars_star_id_seq OWNED BY stars.star_id;


--
-- TOC entry 2045 (class 2604 OID 17987)
-- Name: brightness brightness_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY brightness ALTER COLUMN brightness_id SET DEFAULT nextval('brightness_brightness_id_seq'::regclass);


--
-- TOC entry 2047 (class 2604 OID 18001)
-- Name: catalogues catalogue_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY catalogues ALTER COLUMN catalogue_id SET DEFAULT nextval('catalogues_catalogue_id_seq'::regclass);


--
-- TOC entry 2040 (class 2604 OID 17948)
-- Name: constellations constellation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY constellations ALTER COLUMN constellation_id SET DEFAULT nextval('constellations_constellation_id_seq'::regclass);


--
-- TOC entry 2038 (class 2604 OID 17934)
-- Name: star_types star_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY star_types ALTER COLUMN star_type_id SET DEFAULT nextval('star_types_star_type_id_seq'::regclass);


--
-- TOC entry 2042 (class 2604 OID 17962)
-- Name: stars star_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars ALTER COLUMN star_id SET DEFAULT nextval('stars_star_id_seq'::regclass);


--
-- TOC entry 2206 (class 0 OID 17984)
-- Dependencies: 192
-- Data for Name: brightness; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO brightness VALUES (1, 0.03);
INSERT INTO brightness VALUES (2, 0.08);
INSERT INTO brightness VALUES (3, 0.12);
INSERT INTO brightness VALUES (4, 0.38);
INSERT INTO brightness VALUES (5, 0.46);
INSERT INTO brightness VALUES (6, 0.50);
INSERT INTO brightness VALUES (7, 0.61);
INSERT INTO brightness VALUES (8, 0.77);
INSERT INTO brightness VALUES (9, 0.79);
INSERT INTO brightness VALUES (10, 0.85);
INSERT INTO brightness VALUES (11, 0.91);
INSERT INTO brightness VALUES (12, 1.04);
INSERT INTO brightness VALUES (13, 1.14);
INSERT INTO brightness VALUES (14, 1.16);
INSERT INTO brightness VALUES (15, 1.25);
INSERT INTO brightness VALUES (16, 1.35);
INSERT INTO brightness VALUES (17, 1.52);
INSERT INTO brightness VALUES (18, 1.57);
INSERT INTO brightness VALUES (19, 1.63);
INSERT INTO brightness VALUES (20, -0.05);
INSERT INTO brightness VALUES (21, -0.27);
INSERT INTO brightness VALUES (22, -0.72);
INSERT INTO brightness VALUES (23, -1.46);


--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 191
-- Name: brightness_brightness_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('brightness_brightness_id_seq', 23, true);


--
-- TOC entry 2208 (class 0 OID 17998)
-- Dependencies: 194
-- Data for Name: catalogues; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO catalogues VALUES (1, 'Henry Draper Catalogue', '1924-01-01', 225300, 'HD');
INSERT INTO catalogues VALUES (2, 'Bright Star Catalogue', '1991-01-01', 9096, 'HR');
INSERT INTO catalogues VALUES (3, 'Smithsonian Astrophysical Observatory Star Catalog', '1966-01-01', 258997, 'SAO');
INSERT INTO catalogues VALUES (4, 'Bonner Durchmusterung', NULL, 325037, 'BD');
INSERT INTO catalogues VALUES (5, 'The Guide Star Catalog', '2001-01-01', 945598, 'GSC');
INSERT INTO catalogues VALUES (6, 'Washington Double Star Catalog', '2012-01-01', 115769, 'WDS');
INSERT INTO catalogues VALUES (7, 'U.S. Naval Observatory A1.0 catalogue', NULL, 488860, 'USNO-A1.0');
INSERT INTO catalogues VALUES (8, 'General Catalogue of Variable Stars', '2004-01-01', 28435, 'GCVS');
INSERT INTO catalogues VALUES (9, 'The Gliese Catalogue of Nearby Stars', '2010-01-01', 3800, 'Gl/GJ');


--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 193
-- Name: catalogues_catalogue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('catalogues_catalogue_id_seq', 9, true);


--
-- TOC entry 2202 (class 0 OID 17945)
-- Dependencies: 188
-- Data for Name: constellations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO constellations VALUES (1, 'Canis Majoris');
INSERT INTO constellations VALUES (2, 'Carinae');
INSERT INTO constellations VALUES (3, 'Centauri');
INSERT INTO constellations VALUES (4, 'Bootis');
INSERT INTO constellations VALUES (5, 'Lyrae');
INSERT INTO constellations VALUES (6, 'Aurigae');
INSERT INTO constellations VALUES (7, 'Orionis');
INSERT INTO constellations VALUES (8, 'Canis Minoris');
INSERT INTO constellations VALUES (9, 'Eridani');
INSERT INTO constellations VALUES (10, 'Aquilae');
INSERT INTO constellations VALUES (11, 'Crucis');
INSERT INTO constellations VALUES (12, 'Tauri');
INSERT INTO constellations VALUES (13, 'Scorpii');
INSERT INTO constellations VALUES (14, 'Virginis');
INSERT INTO constellations VALUES (15, 'Geminorum');
INSERT INTO constellations VALUES (16, 'Piscis Austrini');
INSERT INTO constellations VALUES (17, 'Leonis');
INSERT INTO constellations VALUES (18, 'Cygni');


--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 187
-- Name: constellations_constellation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('constellations_constellation_id_seq', 18, true);


--
-- TOC entry 2200 (class 0 OID 17931)
-- Dependencies: 186
-- Data for Name: star_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO star_types VALUES (1, 'star');
INSERT INTO star_types VALUES (2, 'binary star');
INSERT INTO star_types VALUES (3, 'trinary star');
INSERT INTO star_types VALUES (4, 'quaternary star');
INSERT INTO star_types VALUES (5, 'quintenary star');
INSERT INTO star_types VALUES (6, 'sextenary star');
INSERT INTO star_types VALUES (7, 'septenary star');
INSERT INTO star_types VALUES (8, 'multiple star system');
INSERT INTO star_types VALUES (9, 'unknown');


--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 185
-- Name: star_types_star_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('star_types_star_type_id_seq', 9, true);


--
-- TOC entry 2204 (class 0 OID 17959)
-- Dependencies: 190
-- Data for Name: stars; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO stars VALUES (1, 'Sirius', 'A1V', false, 2, 1);
INSERT INTO stars VALUES (2, 'Canopus', 'A9II', false, 1, 2);
INSERT INTO stars VALUES (3, 'Rigil Kentaurus', 'G2V', false, 3, 3);
INSERT INTO stars VALUES (4, 'Arcturus', 'K1.5IIIp', true, 1, 4);
INSERT INTO stars VALUES (5, 'Vega', 'A0Va', true, 1, 5);
INSERT INTO stars VALUES (6, 'Capella', 'G6III', false, 1, 6);
INSERT INTO stars VALUES (7, 'Rigel', 'B8Iae', true, 1, 7);
INSERT INTO stars VALUES (8, 'Procyon', 'F5IV', false, 2, 8);
INSERT INTO stars VALUES (9, 'Betelgeuse', 'M2Iab', true, 1, 7);
INSERT INTO stars VALUES (10, 'Achernar', 'B3Vnp', false, 1, 9);
INSERT INTO stars VALUES (11, 'Hadar ', 'B1III', true, 1, 3);
INSERT INTO stars VALUES (12, 'Altair', 'A7Vn', false, 1, 10);
INSERT INTO stars VALUES (13, 'Acrux', 'B1Vn', false, 1, 11);
INSERT INTO stars VALUES (14, 'Aldebaran', 'K5III', true, 1, 12);
INSERT INTO stars VALUES (15, 'Antares', 'M1.5Iab', true, 1, 13);
INSERT INTO stars VALUES (16, 'Spica', 'B1V', true, 1, 14);
INSERT INTO stars VALUES (17, 'Pollux', 'K0IIIb', false, 1, 15);
INSERT INTO stars VALUES (18, 'Fomalhaut', 'A3Va', false, 1, 16);
INSERT INTO stars VALUES (19, 'Mimosa', 'B0.5III', true, 2, 11);
INSERT INTO stars VALUES (20, 'Deneb', 'A2Ia', false, 1, 18);
INSERT INTO stars VALUES (21, 'Regulus', 'B7Vn', false, 1, 17);
INSERT INTO stars VALUES (22, 'Adhara', 'B2II', false, 1, 1);
INSERT INTO stars VALUES (23, 'Castor', 'A1V ', false, 1, 15);
INSERT INTO stars VALUES (24, 'Shaula', 'B1.5IV', true, 1, 13);
INSERT INTO stars VALUES (25, 'Gacrux', 'M3.5III', true, 1, 11);


--
-- TOC entry 2209 (class 0 OID 18013)
-- Dependencies: 195
-- Data for Name: stars_brightness_relationships; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO stars_brightness_relationships VALUES (1, 23);
INSERT INTO stars_brightness_relationships VALUES (2, 22);
INSERT INTO stars_brightness_relationships VALUES (3, 21);
INSERT INTO stars_brightness_relationships VALUES (4, 20);
INSERT INTO stars_brightness_relationships VALUES (5, 1);
INSERT INTO stars_brightness_relationships VALUES (6, 2);
INSERT INTO stars_brightness_relationships VALUES (7, 3);
INSERT INTO stars_brightness_relationships VALUES (8, 4);
INSERT INTO stars_brightness_relationships VALUES (9, 6);
INSERT INTO stars_brightness_relationships VALUES (10, 5);
INSERT INTO stars_brightness_relationships VALUES (11, 7);
INSERT INTO stars_brightness_relationships VALUES (12, 8);
INSERT INTO stars_brightness_relationships VALUES (13, 9);
INSERT INTO stars_brightness_relationships VALUES (14, 10);
INSERT INTO stars_brightness_relationships VALUES (15, 11);
INSERT INTO stars_brightness_relationships VALUES (16, 12);
INSERT INTO stars_brightness_relationships VALUES (17, 13);
INSERT INTO stars_brightness_relationships VALUES (18, 14);
INSERT INTO stars_brightness_relationships VALUES (19, 15);
INSERT INTO stars_brightness_relationships VALUES (20, 15);
INSERT INTO stars_brightness_relationships VALUES (21, 16);
INSERT INTO stars_brightness_relationships VALUES (22, 17);
INSERT INTO stars_brightness_relationships VALUES (23, 18);
INSERT INTO stars_brightness_relationships VALUES (24, 19);
INSERT INTO stars_brightness_relationships VALUES (25, 20);


--
-- TOC entry 2210 (class 0 OID 18028)
-- Dependencies: 196
-- Data for Name: stars_catalogues_relationships; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO stars_catalogues_relationships VALUES (1, 1, 48915);
INSERT INTO stars_catalogues_relationships VALUES (2, 5, 45348);
INSERT INTO stars_catalogues_relationships VALUES (8, 1, 61421);
INSERT INTO stars_catalogues_relationships VALUES (4, 1, 124897);
INSERT INTO stars_catalogues_relationships VALUES (24, 2, 158926);
INSERT INTO stars_catalogues_relationships VALUES (17, 1, 62509);
INSERT INTO stars_catalogues_relationships VALUES (5, 1, 172167);
INSERT INTO stars_catalogues_relationships VALUES (13, 5, 1607);
INSERT INTO stars_catalogues_relationships VALUES (9, 1, 39801);
INSERT INTO stars_catalogues_relationships VALUES (10, 1, 10144);
INSERT INTO stars_catalogues_relationships VALUES (3, 1, 128620);
INSERT INTO stars_catalogues_relationships VALUES (14, 3, 122451);
INSERT INTO stars_catalogues_relationships VALUES (12, 1, 187642);
INSERT INTO stars_catalogues_relationships VALUES (6, 1, 34029);
INSERT INTO stars_catalogues_relationships VALUES (7, 2, 34085);
INSERT INTO stars_catalogues_relationships VALUES (13, 1, 108248);
INSERT INTO stars_catalogues_relationships VALUES (16, 1, 116658);
INSERT INTO stars_catalogues_relationships VALUES (15, 1, 148478);
INSERT INTO stars_catalogues_relationships VALUES (18, 1, 216956);
INSERT INTO stars_catalogues_relationships VALUES (19, 2, 111123);
INSERT INTO stars_catalogues_relationships VALUES (20, 1, 197345);
INSERT INTO stars_catalogues_relationships VALUES (14, 1, 29139);
INSERT INTO stars_catalogues_relationships VALUES (21, 2, 87901);
INSERT INTO stars_catalogues_relationships VALUES (22, 1, 52089);
INSERT INTO stars_catalogues_relationships VALUES (25, 1, 108903);
INSERT INTO stars_catalogues_relationships VALUES (4, 2, 5340);
INSERT INTO stars_catalogues_relationships VALUES (19, 9, 4853);
INSERT INTO stars_catalogues_relationships VALUES (16, 4, 3672);
INSERT INTO stars_catalogues_relationships VALUES (13, 7, 128620);
INSERT INTO stars_catalogues_relationships VALUES (9, 6, 5552);
INSERT INTO stars_catalogues_relationships VALUES (8, 7, 57887);
INSERT INTO stars_catalogues_relationships VALUES (3, 4, 6876);
INSERT INTO stars_catalogues_relationships VALUES (19, 5, 94097);
INSERT INTO stars_catalogues_relationships VALUES (23, 7, 7587);
INSERT INTO stars_catalogues_relationships VALUES (11, 8, 85787);
INSERT INTO stars_catalogues_relationships VALUES (17, 3, 134352);
INSERT INTO stars_catalogues_relationships VALUES (1, 2, 2491);
INSERT INTO stars_catalogues_relationships VALUES (9, 5, 64831);


--
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 189
-- Name: stars_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stars_star_id_seq', 25, true);


--
-- TOC entry 2065 (class 2606 OID 17993)
-- Name: brightness brightness_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY brightness
    ADD CONSTRAINT brightness_pk PRIMARY KEY (brightness_id);


--
-- TOC entry 2067 (class 2606 OID 17995)
-- Name: brightness brightness_visible_mag_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY brightness
    ADD CONSTRAINT brightness_visible_mag_key UNIQUE (visible_mag);


--
-- TOC entry 2069 (class 2606 OID 18012)
-- Name: catalogues catalogues_catalogue_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY catalogues
    ADD CONSTRAINT catalogues_catalogue_name_key UNIQUE (catalogue_name);


--
-- TOC entry 2071 (class 2606 OID 18010)
-- Name: catalogues catalogues_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY catalogues
    ADD CONSTRAINT catalogues_pk PRIMARY KEY (catalogue_id);


--
-- TOC entry 2057 (class 2606 OID 17956)
-- Name: constellations constellations_constellation_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY constellations
    ADD CONSTRAINT constellations_constellation_name_key UNIQUE (constellation_name);


--
-- TOC entry 2059 (class 2606 OID 17954)
-- Name: constellations constellations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY constellations
    ADD CONSTRAINT constellations_pk PRIMARY KEY (constellation_id);


--
-- TOC entry 2053 (class 2606 OID 17940)
-- Name: star_types star_types_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY star_types
    ADD CONSTRAINT star_types_pk PRIMARY KEY (star_type_id);


--
-- TOC entry 2055 (class 2606 OID 17942)
-- Name: star_types star_types_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY star_types
    ADD CONSTRAINT star_types_type_name_key UNIQUE (type_name);


--
-- TOC entry 2073 (class 2606 OID 18017)
-- Name: stars_brightness_relationships stars_brightness_relationships_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars_brightness_relationships
    ADD CONSTRAINT stars_brightness_relationships_pk PRIMARY KEY (star_id, brightness_id);


--
-- TOC entry 2075 (class 2606 OID 18032)
-- Name: stars_catalogues_relationships stars_catalogues_relationships_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars_catalogues_relationships
    ADD CONSTRAINT stars_catalogues_relationships_pk PRIMARY KEY (star_id, catalogue_id);


--
-- TOC entry 2061 (class 2606 OID 17969)
-- Name: stars stars_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_pk PRIMARY KEY (star_id);


--
-- TOC entry 2063 (class 2606 OID 17971)
-- Name: stars stars_star_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_star_name_key UNIQUE (star_name);


--
-- TOC entry 2079 (class 2606 OID 18023)
-- Name: stars_brightness_relationships stars_brightness_relationships_brightness_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars_brightness_relationships
    ADD CONSTRAINT stars_brightness_relationships_brightness_id_fkey FOREIGN KEY (brightness_id) REFERENCES brightness(brightness_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2078 (class 2606 OID 18018)
-- Name: stars_brightness_relationships stars_brightness_relationships_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars_brightness_relationships
    ADD CONSTRAINT stars_brightness_relationships_star_id_fkey FOREIGN KEY (star_id) REFERENCES stars(star_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2081 (class 2606 OID 18038)
-- Name: stars_catalogues_relationships stars_catalogues_relationships_catalogue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars_catalogues_relationships
    ADD CONSTRAINT stars_catalogues_relationships_catalogue_id_fkey FOREIGN KEY (catalogue_id) REFERENCES catalogues(catalogue_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2080 (class 2606 OID 18033)
-- Name: stars_catalogues_relationships stars_catalogues_relationships_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars_catalogues_relationships
    ADD CONSTRAINT stars_catalogues_relationships_star_id_fkey FOREIGN KEY (star_id) REFERENCES stars(star_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2077 (class 2606 OID 17977)
-- Name: stars stars_constellation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_constellation_id_fkey FOREIGN KEY (constellation_id) REFERENCES constellations(constellation_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2076 (class 2606 OID 17972)
-- Name: stars stars_star_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_star_type_id_fkey FOREIGN KEY (star_type_id) REFERENCES star_types(star_type_id) ON UPDATE CASCADE ON DELETE SET NULL;


-- Completed on 2017-12-01 23:12:36

--
-- PostgreSQL database dump complete
--

