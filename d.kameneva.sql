
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS "d.kameneva";

CREATE DATABASE "d.kameneva" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';

ALTER DATABASE "d.kameneva" OWNER TO postgres;

\connect "d.kameneva"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;



CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;



COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;





CREATE TABLE brightness (
    brightness_id integer NOT NULL,
    visible_mag numeric NOT NULL,
    CONSTRAINT brightness_visible_mag_check CHECK ((visible_mag < (5)::numeric))
);


ALTER TABLE brightness OWNER TO postgres;


CREATE SEQUENCE brightness_brightness_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE brightness_brightness_id_seq OWNER TO postgres;


ALTER SEQUENCE brightness_brightness_id_seq OWNED BY brightness.brightness_id;


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



CREATE SEQUENCE catalogues_catalogue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE catalogues_catalogue_id_seq OWNER TO postgres;


ALTER SEQUENCE catalogues_catalogue_id_seq OWNED BY catalogues.catalogue_id;



CREATE TABLE constellations (
    constellation_id integer NOT NULL,
    constellation_name text NOT NULL,
    CONSTRAINT constellations_constellation_name_check CHECK ((length(constellation_name) < 30))
);


ALTER TABLE constellations OWNER TO postgres;



CREATE SEQUENCE constellations_constellation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE constellations_constellation_id_seq OWNER TO postgres;



ALTER SEQUENCE constellations_constellation_id_seq OWNED BY constellations.constellation_id;




CREATE TABLE star_types (
    star_type_id integer NOT NULL,
    type_name text NOT NULL,
    CONSTRAINT star_types_type_name_check CHECK ((length(type_name) < 30))
);


ALTER TABLE star_types OWNER TO postgres;



CREATE SEQUENCE star_types_star_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE star_types_star_type_id_seq OWNER TO postgres;


ALTER SEQUENCE star_types_star_type_id_seq OWNED BY star_types.star_type_id;




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



CREATE TABLE stars_brightness_relationships (
    star_id integer NOT NULL,
    brightness_id integer NOT NULL
);


ALTER TABLE stars_brightness_relationships OWNER TO postgres;



CREATE TABLE stars_catalogues_relationships (
    star_id integer NOT NULL,
    catalogue_id integer NOT NULL,
    numincat integer NOT NULL
);


ALTER TABLE stars_catalogues_relationships OWNER TO postgres;



CREATE SEQUENCE stars_star_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stars_star_id_seq OWNER TO postgres;


ALTER SEQUENCE stars_star_id_seq OWNED BY stars.star_id;




ALTER TABLE ONLY brightness ALTER COLUMN brightness_id SET DEFAULT nextval('brightness_brightness_id_seq'::regclass);


ALTER TABLE ONLY catalogues ALTER COLUMN catalogue_id SET DEFAULT nextval('catalogues_catalogue_id_seq'::regclass);


ALTER TABLE ONLY constellations ALTER COLUMN constellation_id SET DEFAULT nextval('constellations_constellation_id_seq'::regclass);


ALTER TABLE ONLY star_types ALTER COLUMN star_type_id SET DEFAULT nextval('star_types_star_type_id_seq'::regclass);


ALTER TABLE ONLY stars ALTER COLUMN star_id SET DEFAULT nextval('stars_star_id_seq'::regclass);



COPY brightness (brightness_id, visible_mag) FROM stdin;
1	0.03
2	0.08
3	0.12
4	0.38
5	0.46
6	0.50
7	0.61
8	0.77
9	0.79
10	0.85
11	0.91
12	1.04
13	1.14
14	1.16
15	1.25
16	1.35
17	1.52
18	1.57
19	1.63
20	-0.05
21	-0.27
22	-0.72
23	-1.46
\.


SELECT pg_catalog.setval('brightness_brightness_id_seq', 23, true);



COPY catalogues (catalogue_id, catalogue_name, year_of_publ, numofobj, abbreviation) FROM stdin;
1	Henry Draper Catalogue	1924-01-01	225300	HD
2	Bright Star Catalogue	1991-01-01	9096	HR
3	Smithsonian Astrophysical Observatory Star Catalog	1966-01-01	258997	SAO
4	Bonner Durchmusterung	\N	325037	BD
5	The Guide Star Catalog	2001-01-01	945598	GSC
6	Washington Double Star Catalog	2012-01-01	115769	WDS
7	U.S. Naval Observatory A1.0 catalogue	\N	488860	USNO-A1.0
8	General Catalogue of Variable Stars	2004-01-01	28435	GCVS
9	The Gliese Catalogue of Nearby Stars	2010-01-01	3800	Gl/GJ
\.

SELECT pg_catalog.setval('catalogues_catalogue_id_seq', 9, true);



COPY constellations (constellation_id, constellation_name) FROM stdin;
1	Canis Majoris
2	Carinae
3	Centauri
4	Bootis
5	Lyrae
6	Aurigae
7	Orionis
8	Canis Minoris
9	Eridani
10	Aquilae
11	Crucis
12	Tauri
13	Scorpii
14	Virginis
15	Geminorum
16	Piscis Austrini
17	Leonis
18	Cygni
\.



SELECT pg_catalog.setval('constellations_constellation_id_seq', 18, true);




COPY star_types (star_type_id, type_name) FROM stdin;
1	star
2	binary star
3	trinary star
4	quaternary star
5	quintenary star
6	sextenary star
7	septenary star
8	multiple star system
9	unknown
\.


SELECT pg_catalog.setval('star_types_star_type_id_seq', 9, true);



COPY stars (star_id, star_name, spectral_type, variable_star, star_type_id, constellation_id) FROM stdin;
1	Sirius	A1V	f	2	1
2	Canopus	A9II	f	1	2
3	Rigil Kentaurus	G2V	f	3	3
4	Arcturus	K1.5IIIp	t	1	4
5	Vega	A0Va	t	1	5
6	Capella	G6III	f	1	6
7	Rigel	B8Iae	t	1	7
8	Procyon	F5IV	f	2	8
9	Betelgeuse	M2Iab	t	1	7
10	Achernar	B3Vnp	f	1	9
11	Hadar 	B1III	t	1	3
12	Altair	A7Vn	f	1	10
13	Acrux	B1Vn	f	1	11
14	Aldebaran	K5III	t	1	12
15	Antares	M1.5Iab	t	1	13
16	Spica	B1V	t	1	14
17	Pollux	K0IIIb	f	1	15
18	Fomalhaut	A3Va	f	1	16
19	Mimosa	B0.5III	t	2	11
20	Deneb	A2Ia	f	1	18
21	Regulus	B7Vn	f	1	17
22	Adhara	B2II	f	1	1
23	Castor	A1V 	f	1	15
24	Shaula	B1.5IV	t	1	13
25	Gacrux	M3.5III	t	1	11
\.



COPY stars_brightness_relationships (star_id, brightness_id) FROM stdin;
1	23
2	22
3	21
4	20
5	1
6	2
7	3
8	4
9	6
10	5
11	7
12	8
13	9
14	10
15	11
16	12
17	13
18	14
19	15
20	15
21	16
22	17
23	18
24	19
25	20
\.




COPY stars_catalogues_relationships (star_id, catalogue_id, numincat) FROM stdin;
1	1	48915
2	5	45348
8	1	61421
4	1	124897
24	2	158926
17	1	62509
5	1	172167
13	7	1607
9	1	39801
10	1	10144
3	1	128620
14	1	122451
12	1	187642
6	1	34029
7	2	34085
13	1	108248
16	1	116658
15	1	148478
18	1	216956
19	2	111123
20	1	197345
14	1	29139
21	2	87901
22	1	52089
25	1	108903
4	2	5340
19	9	4853
16	4	3672
3	1	128620
9	6	5552
8	7	57887
3	4	6876
19	5	94097
23	7	7587
11	8	85787
17	3	134352
1	2	2491
9	5	64831
\.


SELECT pg_catalog.setval('stars_star_id_seq', 25, true);


ALTER TABLE ONLY brightness
    ADD CONSTRAINT brightness_visible_mag_key UNIQUE (visible_mag);
    
    
ALTER TABLE ONLY brightness
    ADD CONSTRAINT brightness_pk PRIMARY KEY (brightness_id);




ALTER TABLE ONLY catalogues
    ADD CONSTRAINT catalogues_catalogue_name_key UNIQUE (catalogue_name);


ALTER TABLE ONLY catalogues
    ADD CONSTRAINT catalogues_pk PRIMARY KEY (catalogue_id);




ALTER TABLE ONLY constellations
    ADD CONSTRAINT constellations_constellation_name_key UNIQUE (constellation_name);


ALTER TABLE ONLY constellations
    ADD CONSTRAINT constellations_pk PRIMARY KEY (constellation_id);




ALTER TABLE ONLY star_types
    ADD CONSTRAINT star_types_type_name_key UNIQUE (type_name);


ALTER TABLE ONLY star_types
    ADD CONSTRAINT star_types_pk PRIMARY KEY (star_type_id);
    
    


ALTER TABLE ONLY stars_brightness_relationships
    ADD CONSTRAINT stars_brightness_relationships_pk PRIMARY KEY (star_id, brightness_id);


ALTER TABLE ONLY stars_brightness_relationships
    ADD CONSTRAINT stars_brightness_relationships_brightness_id_fkey FOREIGN KEY (brightness_id) REFERENCES brightness(brightness_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY stars_brightness_relationships
    ADD CONSTRAINT stars_brightness_relationships_star_id_fkey FOREIGN KEY (star_id) REFERENCES stars(star_id) ON UPDATE CASCADE ON DELETE CASCADE;





ALTER TABLE ONLY stars_catalogues_relationships
    ADD CONSTRAINT stars_catalogues_relationships_pk PRIMARY KEY (star_id, catalogue_id);


ALTER TABLE ONLY stars_catalogues_relationships
    ADD CONSTRAINT stars_catalogues_relationships_catalogue_id_fkey FOREIGN KEY (catalogue_id) REFERENCES catalogues(catalogue_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY stars_catalogues_relationships
    ADD CONSTRAINT stars_catalogues_relationships_star_id_fkey FOREIGN KEY (star_id) REFERENCES stars(star_id) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_star_name_key UNIQUE (star_name);


ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_pk PRIMARY KEY (star_id);


ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_constellation_id_fkey FOREIGN KEY (constellation_id) REFERENCES constellations(constellation_id) ON UPDATE CASCADE ON DELETE SET NULL;


ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_star_type_id_fkey FOREIGN KEY (star_type_id) REFERENCES star_types(star_type_id) ON UPDATE CASCADE ON DELETE SET NULL;


