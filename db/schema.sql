--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: sex; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE sex AS ENUM (
    'Male',
    'Female'
);


ALTER TYPE public.sex OWNER TO postgres;

--
-- Name: joined_official_terms_refresh_row(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION joined_official_terms_refresh_row(id integer) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$ 
    begin 
      delete from joined_official_terms jot where jot.official_term_id = id; 
      insert into joined_official_terms select *, false from joined_official_terms_view jot where jot.official_term_id = id; 
      end 
    $$;


ALTER FUNCTION public.joined_official_terms_refresh_row(id integer) OWNER TO postgres;

--
-- Name: jot_counties_update_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_counties_update_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      perform joined_official_terms_refresh_row(jot.official_term_id)
        from joined_official_terms jot
        where jot.state_id = new.state_id and jot.county_ansi_code = new.ansi_code; 
      return null;
    end
    $$;


ALTER FUNCTION public.jot_counties_update_trigger() OWNER TO postgres;

--
-- Name: jot_municipalities_update_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_municipalities_update_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      perform joined_official_terms_refresh_row(jot.official_term_id)
        from joined_official_terms jot
        where jot.state_id = new.state_id and jot.municipality_ansi_code = new.ansi_code; 
      return null;
    end
    $$;


ALTER FUNCTION public.jot_municipalities_update_trigger() OWNER TO postgres;

--
-- Name: jot_office_types_update_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_office_types_update_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      perform joined_official_terms_refresh_row(jot.official_term_id)
        from joined_official_terms jot
        where jot.office_type_key = new.key;
      return null;
    end
    $$;


ALTER FUNCTION public.jot_office_types_update_trigger() OWNER TO postgres;

--
-- Name: jot_offices_update_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_offices_update_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      perform joined_official_terms_refresh_row(jot.official_term_id)
        from joined_official_terms jot
        where jot.office_id = new.id;
      return null;
    end
    $$;


ALTER FUNCTION public.jot_offices_update_trigger() OWNER TO postgres;

--
-- Name: jot_official_terms_delete_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_official_terms_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      perform joined_official_terms_refresh_row(old.id);
      return null;
    end
    $$;


ALTER FUNCTION public.jot_official_terms_delete_trigger() OWNER TO postgres;

--
-- Name: jot_official_terms_insert_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_official_terms_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      perform joined_official_terms_refresh_row(new.id);
      return null;
    end
    $$;


ALTER FUNCTION public.jot_official_terms_insert_trigger() OWNER TO postgres;

--
-- Name: jot_official_terms_update_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_official_terms_update_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      if old.id = new.id then
        perform joined_official_terms_refresh_row(new.id);
      else
        perform joined_official_terms_refresh_row(old.id);
        perform joined_official_terms_refresh_row(new.id);
      end if;
      return null;
    end
    $$;


ALTER FUNCTION public.jot_official_terms_update_trigger() OWNER TO postgres;

--
-- Name: jot_officials_update_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_officials_update_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      perform joined_official_terms_refresh_row(jot.official_term_id)
        from joined_official_terms jot
        where jot.official_id = new.id;
      return null;
    end
    $$;


ALTER FUNCTION public.jot_officials_update_trigger() OWNER TO postgres;

--
-- Name: jot_terms_update_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION jot_terms_update_trigger() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
    begin
      perform joined_official_terms_refresh_row(jot.official_term_id)
        from joined_official_terms jot
        where jot.term_id= new.id;
      return null;
    end
    $$;


ALTER FUNCTION public.jot_terms_update_trigger() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authentications; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(64) NOT NULL,
    uid character varying(64) NOT NULL,
    token text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.authentications OWNER TO postgres;

--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authentications_id_seq OWNER TO postgres;

--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: census_national_place_import; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE census_national_place_import (
    state_abbreviation text,
    state_id integer,
    place_id integer,
    place_name text,
    place_type text,
    status character(1),
    county text
);


ALTER TABLE public.census_national_place_import OWNER TO postgres;

--
-- Name: congressional_districts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE congressional_districts (
    state_id integer NOT NULL,
    district integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.congressional_districts OWNER TO postgres;

--
-- Name: counties; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE counties (
    state_id integer NOT NULL,
    ansi_code integer NOT NULL,
    name character varying(32) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.counties OWNER TO postgres;

--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0,
    attempts integer DEFAULT 0,
    handler text,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.delayed_jobs OWNER TO postgres;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delayed_jobs_id_seq OWNER TO postgres;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: graph_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE graph_types (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.graph_types OWNER TO postgres;

--
-- Name: graph_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE graph_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.graph_types_id_seq OWNER TO postgres;

--
-- Name: graph_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE graph_types_id_seq OWNED BY graph_types.id;


--
-- Name: imported_open_states_legislators; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE imported_open_states_legislators (
    leg_id text,
    full_name text,
    first_name text,
    middle_name text,
    last_name text,
    suffixes text,
    nickname text,
    active boolean,
    state text,
    chamber text,
    district text,
    party text,
    transparencydata_id text,
    photo_url text,
    source_created_at timestamp without time zone,
    source_updated_at timestamp without time zone
);


ALTER TABLE public.imported_open_states_legislators OWNER TO postgres;

--
-- Name: sunlight_congress_import; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sunlight_congress_import (
    title text,
    firstname text,
    middlename text,
    lastname text,
    name_suffix text,
    nickname text,
    party text,
    state text,
    district text,
    in_office integer,
    gender text,
    phone text,
    fax text,
    website text,
    webform text,
    congress_office text,
    bioguide_id text,
    votesmart_id integer,
    fec_id text,
    govtrack_id integer,
    crp_id text,
    twitter_id text,
    congresspedia_url text,
    youtube_url text,
    facebook_id text,
    official_rss text,
    senate_class text,
    birthdate date
);


ALTER TABLE public.sunlight_congress_import OWNER TO postgres;

--
-- Name: imported_sunlight_house_members; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW imported_sunlight_house_members AS
    SELECT sunlight_congress_import.firstname AS first_name, sunlight_congress_import.middlename AS middle_name, sunlight_congress_import.lastname AS last_name, sunlight_congress_import.name_suffix, sunlight_congress_import.nickname, sunlight_congress_import.party, sunlight_congress_import.state, (sunlight_congress_import.district)::integer AS district, sunlight_congress_import.gender, sunlight_congress_import.phone, sunlight_congress_import.fax, sunlight_congress_import.website, sunlight_congress_import.webform, sunlight_congress_import.congress_office, sunlight_congress_import.bioguide_id, sunlight_congress_import.votesmart_id, sunlight_congress_import.fec_id, sunlight_congress_import.govtrack_id, sunlight_congress_import.crp_id, sunlight_congress_import.twitter_id, sunlight_congress_import.congresspedia_url, sunlight_congress_import.youtube_url, sunlight_congress_import.facebook_id, sunlight_congress_import.official_rss, sunlight_congress_import.birthdate AS birth_date FROM sunlight_congress_import WHERE ((sunlight_congress_import.title = 'Rep'::text) AND (sunlight_congress_import.in_office = 1));


ALTER TABLE public.imported_sunlight_house_members OWNER TO postgres;

--
-- Name: imported_sunlight_senators; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW imported_sunlight_senators AS
    SELECT sunlight_congress_import.firstname AS first_name, sunlight_congress_import.middlename AS middle_name, sunlight_congress_import.lastname AS last_name, sunlight_congress_import.name_suffix, sunlight_congress_import.nickname, sunlight_congress_import.party, sunlight_congress_import.state, sunlight_congress_import.gender, sunlight_congress_import.phone, sunlight_congress_import.fax, sunlight_congress_import.website, sunlight_congress_import.webform, sunlight_congress_import.congress_office, sunlight_congress_import.bioguide_id, sunlight_congress_import.votesmart_id, sunlight_congress_import.fec_id, sunlight_congress_import.govtrack_id, sunlight_congress_import.crp_id, sunlight_congress_import.twitter_id, sunlight_congress_import.congresspedia_url, sunlight_congress_import.youtube_url, sunlight_congress_import.facebook_id, sunlight_congress_import.official_rss, CASE WHEN (sunlight_congress_import.senate_class = 'I'::text) THEN 1 WHEN (sunlight_congress_import.senate_class = 'II'::text) THEN 2 WHEN (sunlight_congress_import.senate_class = 'III'::text) THEN 3 ELSE NULL::integer END AS senate_class, sunlight_congress_import.birthdate AS birth_date FROM sunlight_congress_import WHERE ((sunlight_congress_import.title = 'Sen'::text) AND (sunlight_congress_import.in_office = 1));


ALTER TABLE public.imported_sunlight_senators OWNER TO postgres;

--
-- Name: joined_official_terms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE joined_official_terms (
    official_term_id integer,
    office_id integer,
    official_id integer,
    term_id integer,
    office_type_id integer,
    party_id integer,
    office_discriminator character varying(32),
    from_date date,
    to_date date,
    office_type_ukey character varying(20),
    office_type_name character varying(32),
    office_type_title character varying(20),
    office_type_abbreviated_title character varying(20),
    party_name character varying(32),
    party_member_noun character varying(32),
    party_abbreviation character varying(6),
    official_first_name character varying(20),
    official_middle_name character varying(20),
    official_last_name character varying(20),
    official_nickname character varying(20),
    official_name_suffix character varying(20),
    official_birth_date date,
    official_gender character(1),
    official_congress_office character varying(256),
    official_phone character varying(20),
    official_website character varying(256),
    official_webform character varying(256),
    official_twitter_id character varying(64),
    official_congresspedia_url character varying(256),
    official_youtube_url character varying(256),
    official_facebook_id character varying(64),
    official_fax character varying(20),
    official_votesmart_id integer,
    official_govtrack_id integer,
    official_bioguide_id character varying(32),
    official_eventful_id character varying(64),
    official_photo_extension character varying(20),
    official_rss character varying(256),
    official_open_states_leg_id character varying(20),
    official_external_photo_url character varying(255),
    official_transparencydata_id character varying(32),
    state_id integer,
    state_name text,
    state_abbreviation character(2),
    us_senate_class integer,
    congressional_district_no integer,
    state_house_district_key character varying(64),
    state_senate_district_key character varying(64),
    county_name character varying(32),
    county_ansi_code integer,
    municipality_name character varying(32),
    municipality_ansi_code integer,
    ward character varying(32),
    dirty boolean
);


ALTER TABLE public.joined_official_terms OWNER TO postgres;

--
-- Name: incumbents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW incumbents AS
    SELECT joined_official_terms.official_term_id, joined_official_terms.office_id, joined_official_terms.official_id, joined_official_terms.term_id, joined_official_terms.office_type_id, joined_official_terms.party_id, joined_official_terms.office_discriminator, joined_official_terms.from_date, joined_official_terms.to_date, joined_official_terms.office_type_ukey, joined_official_terms.office_type_name, joined_official_terms.office_type_title, joined_official_terms.office_type_abbreviated_title, joined_official_terms.party_name, joined_official_terms.party_member_noun, joined_official_terms.party_abbreviation, joined_official_terms.official_first_name, joined_official_terms.official_middle_name, joined_official_terms.official_last_name, joined_official_terms.official_nickname, joined_official_terms.official_name_suffix, joined_official_terms.official_birth_date, joined_official_terms.official_gender, joined_official_terms.official_congress_office, joined_official_terms.official_phone, joined_official_terms.official_website, joined_official_terms.official_webform, joined_official_terms.official_twitter_id, joined_official_terms.official_congresspedia_url, joined_official_terms.official_youtube_url, joined_official_terms.official_facebook_id, joined_official_terms.official_fax, joined_official_terms.official_votesmart_id, joined_official_terms.official_govtrack_id, joined_official_terms.official_bioguide_id, joined_official_terms.official_eventful_id, joined_official_terms.official_photo_extension, joined_official_terms.official_rss, joined_official_terms.official_open_states_leg_id, joined_official_terms.official_external_photo_url, joined_official_terms.official_transparencydata_id, joined_official_terms.state_id, joined_official_terms.state_name, joined_official_terms.state_abbreviation, joined_official_terms.us_senate_class, joined_official_terms.congressional_district_no, joined_official_terms.state_house_district_key, joined_official_terms.state_senate_district_key, joined_official_terms.county_name, joined_official_terms.county_ansi_code, joined_official_terms.municipality_name, joined_official_terms.municipality_ansi_code, joined_official_terms.ward, joined_official_terms.dirty FROM joined_official_terms WHERE ((joined_official_terms.from_date < now()) AND (joined_official_terms.to_date > now()));


ALTER TABLE public.incumbents OWNER TO postgres;

--
-- Name: issues; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE issues (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    comment text,
    poller_type text NOT NULL,
    poller_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.issues OWNER TO postgres;

--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issues_id_seq OWNER TO postgres;

--
-- Name: issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE issues_id_seq OWNED BY issues.id;


--
-- Name: municipalities; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE municipalities (
    state_id integer NOT NULL,
    ansi_code integer NOT NULL,
    name character varying(32) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.municipalities OWNER TO postgres;

--
-- Name: office_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE office_types (
    id integer NOT NULL,
    ukey character varying(20) NOT NULL,
    name character varying(32) NOT NULL,
    title character varying(20) NOT NULL,
    abbreviated_title character varying(20) NOT NULL,
    polity_type_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.office_types OWNER TO postgres;

--
-- Name: offices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE offices (
    id integer NOT NULL,
    office_type_id integer NOT NULL,
    state_id integer,
    us_senate_class integer,
    congressional_district_no integer,
    county_ansi_code integer,
    municipality_ansi_code integer,
    state_senate_district_key character varying(64),
    state_house_district_key character varying(64),
    ward character varying(32),
    discriminator character varying(32) DEFAULT '0'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT offices_us_senate_class_check CHECK ((us_senate_class = ANY (ARRAY[NULL::integer, 1, 2, 3])))
);


ALTER TABLE public.offices OWNER TO postgres;

--
-- Name: official_terms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE official_terms (
    id integer NOT NULL,
    official_id integer NOT NULL,
    office_id integer NOT NULL,
    term_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.official_terms OWNER TO postgres;

--
-- Name: officials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE officials_id_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.officials_id_seq OWNER TO postgres;

--
-- Name: officials; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE officials (
    id integer DEFAULT nextval('officials_id_seq'::regclass) NOT NULL,
    first_name character varying(20) NOT NULL,
    middle_name character varying(20),
    last_name character varying(20) NOT NULL,
    nickname character varying(20),
    name_suffix character varying(20),
    birth_date date,
    gender character(1),
    party_id integer,
    congress_office character varying(256),
    phone character varying(20),
    email character varying(256),
    website character varying(256),
    webform character varying(256),
    twitter_id character varying(64),
    congresspedia_url character varying(256),
    youtube_url character varying(256),
    facebook_id character varying(64),
    fax character varying(20),
    votesmart_id integer,
    govtrack_id integer,
    bioguide_id character varying(32),
    eventful_id character varying(64),
    photo_extension character varying(20),
    rss character varying(256),
    open_states_leg_id character varying(20),
    external_photo_url character varying(255),
    transparencydata_id character varying(32),
    source_created_at timestamp without time zone,
    source_updated_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.officials OWNER TO postgres;

--
-- Name: parties; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE parties (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    member_noun character varying(32) NOT NULL,
    abbreviation character varying(6) NOT NULL
);


ALTER TABLE public.parties OWNER TO postgres;

--
-- Name: states; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE states (
    id integer NOT NULL,
    name text NOT NULL,
    abbreviation character(2) NOT NULL,
    is_state boolean DEFAULT true NOT NULL
);


ALTER TABLE public.states OWNER TO postgres;

--
-- Name: terms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE terms (
    id integer NOT NULL,
    name character varying(40),
    from_date date NOT NULL,
    to_date date NOT NULL,
    standard boolean NOT NULL,
    office_type_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT terms_check CHECK ((to_date >= from_date))
);


ALTER TABLE public.terms OWNER TO postgres;

--
-- Name: joined_official_terms_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW joined_official_terms_view AS
    SELECT official_terms.id AS official_term_id, offices.id AS office_id, officials.id AS official_id, terms.id AS term_id, office_types.id AS office_type_id, parties.id AS party_id, offices.discriminator AS office_discriminator, terms.from_date, terms.to_date, office_types.ukey AS office_type_ukey, office_types.name AS office_type_name, office_types.title AS office_type_title, office_types.abbreviated_title AS office_type_abbreviated_title, parties.name AS party_name, parties.member_noun AS party_member_noun, parties.abbreviation AS party_abbreviation, officials.first_name AS official_first_name, officials.middle_name AS official_middle_name, officials.last_name AS official_last_name, officials.nickname AS official_nickname, officials.name_suffix AS official_name_suffix, officials.birth_date AS official_birth_date, officials.gender AS official_gender, officials.congress_office AS official_congress_office, officials.phone AS official_phone, officials.website AS official_website, officials.webform AS official_webform, officials.twitter_id AS official_twitter_id, officials.congresspedia_url AS official_congresspedia_url, officials.youtube_url AS official_youtube_url, officials.facebook_id AS official_facebook_id, officials.fax AS official_fax, officials.votesmart_id AS official_votesmart_id, officials.govtrack_id AS official_govtrack_id, officials.bioguide_id AS official_bioguide_id, officials.eventful_id AS official_eventful_id, officials.photo_extension AS official_photo_extension, officials.rss AS official_rss, officials.open_states_leg_id AS official_open_states_leg_id, officials.external_photo_url AS official_external_photo_url, officials.transparencydata_id AS official_transparencydata_id, states.id AS state_id, states.name AS state_name, states.abbreviation AS state_abbreviation, offices.us_senate_class, offices.congressional_district_no, offices.state_house_district_key, offices.state_senate_district_key, counties.name AS county_name, counties.ansi_code AS county_ansi_code, municipalities.name AS municipality_name, municipalities.ansi_code AS municipality_ansi_code, offices.ward FROM ((((((((official_terms JOIN officials ON ((official_terms.official_id = officials.id))) JOIN terms ON ((official_terms.term_id = terms.id))) JOIN offices ON ((official_terms.office_id = offices.id))) JOIN parties ON ((officials.party_id = parties.id))) JOIN office_types ON ((offices.office_type_id = office_types.id))) JOIN states ON ((offices.state_id = states.id))) LEFT JOIN municipalities ON (((offices.state_id = municipalities.state_id) AND (offices.municipality_ansi_code = municipalities.ansi_code)))) LEFT JOIN counties ON (((offices.state_id = counties.state_id) AND (offices.county_ansi_code = counties.ansi_code))));


ALTER TABLE public.joined_official_terms_view OWNER TO postgres;

--
-- Name: mailing_statuses; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mailing_statuses (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.mailing_statuses OWNER TO postgres;

--
-- Name: mailing_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mailing_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailing_statuses_id_seq OWNER TO postgres;

--
-- Name: mailing_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE mailing_statuses_id_seq OWNED BY mailing_statuses.id;


--
-- Name: municipality_categories; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE municipality_categories (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.municipality_categories OWNER TO postgres;

--
-- Name: nations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nations (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.nations OWNER TO postgres;

--
-- Name: office_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE office_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.office_types_id_seq OWNER TO postgres;

--
-- Name: office_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE office_types_id_seq OWNED BY office_types.id;


--
-- Name: offices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE offices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offices_id_seq OWNER TO postgres;

--
-- Name: offices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE offices_id_seq OWNED BY offices.id;


--
-- Name: official_mailing_recipients; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE official_mailing_recipients (
    id integer NOT NULL,
    official_mailing_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.official_mailing_recipients OWNER TO postgres;

--
-- Name: official_mailings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE official_mailings (
    id integer NOT NULL,
    mailing_status_id integer NOT NULL,
    official_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    mailing_start_time timestamp without time zone,
    mailing_end_time timestamp without time zone,
    rep_message text
);


ALTER TABLE public.official_mailings OWNER TO postgres;

--
-- Name: official_mailings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE official_mailings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.official_mailings_id_seq OWNER TO postgres;

--
-- Name: official_mailings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE official_mailings_id_seq OWNED BY official_mailings.id;


--
-- Name: official_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE official_terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.official_terms_id_seq OWNER TO postgres;

--
-- Name: official_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE official_terms_id_seq OWNED BY official_terms.id;


--
-- Name: polity_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE polity_types (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.polity_types OWNER TO postgres;

--
-- Name: polity_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE polity_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polity_types_id_seq OWNER TO postgres;

--
-- Name: polity_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE polity_types_id_seq OWNED BY polity_types.id;


--
-- Name: poll_workflow_states; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE poll_workflow_states (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.poll_workflow_states OWNER TO postgres;

--
-- Name: poll_workflow_states_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE poll_workflow_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poll_workflow_states_id_seq OWNER TO postgres;

--
-- Name: poll_workflow_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE poll_workflow_states_id_seq OWNED BY poll_workflow_states.id;


--
-- Name: postal_cities; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE postal_cities (
    state_id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.postal_cities OWNER TO postgres;

--
-- Name: question_votes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE question_votes (
    id integer NOT NULL,
    question_id integer NOT NULL,
    user_id integer NOT NULL,
    direction smallint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT question_votes_direction_check CHECK ((direction = ANY (ARRAY[(-1), 1])))
);


ALTER TABLE public.question_votes OWNER TO postgres;

--
-- Name: question_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE question_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_votes_id_seq OWNER TO postgres;

--
-- Name: question_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE question_votes_id_seq OWNED BY question_votes.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE questions (
    id integer NOT NULL,
    official_id integer NOT NULL,
    user_id integer NOT NULL,
    title text NOT NULL,
    body text NOT NULL,
    answer text,
    up_cache integer DEFAULT 0 NOT NULL,
    down_cache integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: quick_poll_mailings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quick_poll_mailings (
    id integer NOT NULL,
    quick_poll_id integer NOT NULL,
    official_mailing_id integer NOT NULL
);


ALTER TABLE public.quick_poll_mailings OWNER TO postgres;

--
-- Name: quick_poll_mailings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE quick_poll_mailings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quick_poll_mailings_id_seq OWNER TO postgres;

--
-- Name: quick_poll_mailings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE quick_poll_mailings_id_seq OWNED BY quick_poll_mailings.id;


--
-- Name: quick_poll_options; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quick_poll_options (
    id integer NOT NULL,
    text character varying(32) NOT NULL,
    quick_poll_id integer NOT NULL,
    value smallint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.quick_poll_options OWNER TO postgres;

--
-- Name: quick_poll_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE quick_poll_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quick_poll_options_id_seq OWNER TO postgres;

--
-- Name: quick_poll_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE quick_poll_options_id_seq OWNED BY quick_poll_options.id;


--
-- Name: quick_poll_responses; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quick_poll_responses (
    quick_poll_id integer NOT NULL,
    user_id integer NOT NULL,
    value smallint NOT NULL
);


ALTER TABLE public.quick_poll_responses OWNER TO postgres;

--
-- Name: quick_poll_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quick_poll_types (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.quick_poll_types OWNER TO postgres;

--
-- Name: quick_poll_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE quick_poll_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quick_poll_types_id_seq OWNER TO postgres;

--
-- Name: quick_poll_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE quick_poll_types_id_seq OWNED BY quick_poll_types.id;


--
-- Name: quick_poll_unregistered_responses; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quick_poll_unregistered_responses (
    quick_poll_id integer NOT NULL,
    value smallint NOT NULL,
    uid text NOT NULL
);


ALTER TABLE public.quick_poll_unregistered_responses OWNER TO postgres;

--
-- Name: quick_polls; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE quick_polls (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    body text NOT NULL,
    quick_poll_type_id integer NOT NULL,
    poll_workflow_state_id integer NOT NULL,
    issue_id integer NOT NULL,
    graph_type_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT quick_polls_check CHECK ((end_time > start_time))
);


ALTER TABLE public.quick_polls OWNER TO postgres;

--
-- Name: quick_polls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE quick_polls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quick_polls_id_seq OWNER TO postgres;

--
-- Name: quick_polls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE quick_polls_id_seq OWNED BY quick_polls.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id text,
    data text
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: site_roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE site_roles (
    id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.site_roles OWNER TO postgres;

--
-- Name: site_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE site_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.site_roles_id_seq OWNER TO postgres;

--
-- Name: site_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE site_roles_id_seq OWNED BY site_roles.id;


--
-- Name: standard_poll_option_sets; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE standard_poll_option_sets (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.standard_poll_option_sets OWNER TO postgres;

--
-- Name: standard_poll_option_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE standard_poll_option_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standard_poll_option_sets_id_seq OWNER TO postgres;

--
-- Name: standard_poll_option_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE standard_poll_option_sets_id_seq OWNED BY standard_poll_option_sets.id;


--
-- Name: standard_poll_options; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE standard_poll_options (
    id integer NOT NULL,
    standard_poll_option_set_id integer NOT NULL,
    text character varying(32) NOT NULL,
    value integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.standard_poll_options OWNER TO postgres;

--
-- Name: standard_poll_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE standard_poll_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standard_poll_options_id_seq OWNER TO postgres;

--
-- Name: standard_poll_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE standard_poll_options_id_seq OWNED BY standard_poll_options.id;


--
-- Name: state_house_districts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE state_house_districts (
    state_id integer NOT NULL,
    district character varying(64) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.state_house_districts OWNER TO postgres;

--
-- Name: state_senate_districts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE state_senate_districts (
    state_id integer NOT NULL,
    district character varying(64) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.state_senate_districts OWNER TO postgres;

--
-- Name: taggable_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE taggable_types (
    type character varying(32) NOT NULL
);


ALTER TABLE public.taggable_types OWNER TO postgres;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    tag character varying(32) NOT NULL,
    context character varying(32) DEFAULT 'main'::character varying NOT NULL,
    taggable_type character varying(32) NOT NULL,
    taggable_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: temp_imp_zip_codes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_imp_zip_codes (
    id character varying NOT NULL,
    state_abbreviation character varying,
    latitude numeric(10,7),
    longitude numeric(10,7),
    name character varying,
    state_name character varying
);


ALTER TABLE public.temp_imp_zip_codes OWNER TO postgres;

--
-- Name: terms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.terms_id_seq OWNER TO postgres;

--
-- Name: terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE terms_id_seq OWNED BY terms.id;


--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE test (
    id integer
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    encrypted_password text,
    reset_password_token text,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(40),
    last_sign_in_at timestamp without time zone,
    last_sign_in_ip character varying(40),
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    address1 character varying(128),
    address2 character varying(128),
    city character varying(32),
    zip character varying(10),
    rep_state_id integer,
    rep_congressional_district_no integer,
    rep_county_ansi_code integer,
    rep_municipality_ansi_code integer,
    rep_ward_key character varying(32),
    rep_state_senate_district_key character varying(64),
    rep_state_house_district_key character varying(64),
    latitude numeric(10,7),
    longitude numeric(10,7),
    facebook_current_location text,
    birth_date date,
    sex sex,
    site_role_id integer DEFAULT 1 NOT NULL,
    staff_official_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    email_kill_switch boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: wards; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE wards (
    state_id integer NOT NULL,
    municipality_ansi_code integer NOT NULL,
    ward character varying(32) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.wards OWNER TO postgres;

--
-- Name: zip_codes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE zip_codes (
    id character varying(5) NOT NULL,
    state_id integer NOT NULL,
    postal_city_name character varying NOT NULL,
    latitude numeric(10,7),
    longitude numeric(10,7)
);


ALTER TABLE public.zip_codes OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY graph_types ALTER COLUMN id SET DEFAULT nextval('graph_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issues ALTER COLUMN id SET DEFAULT nextval('issues_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mailing_statuses ALTER COLUMN id SET DEFAULT nextval('mailing_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY office_types ALTER COLUMN id SET DEFAULT nextval('office_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices ALTER COLUMN id SET DEFAULT nextval('offices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_mailings ALTER COLUMN id SET DEFAULT nextval('official_mailings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_terms ALTER COLUMN id SET DEFAULT nextval('official_terms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY polity_types ALTER COLUMN id SET DEFAULT nextval('polity_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY poll_workflow_states ALTER COLUMN id SET DEFAULT nextval('poll_workflow_states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_votes ALTER COLUMN id SET DEFAULT nextval('question_votes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_mailings ALTER COLUMN id SET DEFAULT nextval('quick_poll_mailings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_options ALTER COLUMN id SET DEFAULT nextval('quick_poll_options_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_types ALTER COLUMN id SET DEFAULT nextval('quick_poll_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_polls ALTER COLUMN id SET DEFAULT nextval('quick_polls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY site_roles ALTER COLUMN id SET DEFAULT nextval('site_roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY standard_poll_option_sets ALTER COLUMN id SET DEFAULT nextval('standard_poll_option_sets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY standard_poll_options ALTER COLUMN id SET DEFAULT nextval('standard_poll_options_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY terms ALTER COLUMN id SET DEFAULT nextval('terms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: congressional_districts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY congressional_districts
    ADD CONSTRAINT congressional_districts_pkey PRIMARY KEY (state_id, district);


--
-- Name: counties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY counties
    ADD CONSTRAINT counties_pkey PRIMARY KEY (state_id, ansi_code);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: graph_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY graph_types
    ADD CONSTRAINT graph_types_pkey PRIMARY KEY (id);


--
-- Name: issues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: mailing_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mailing_statuses
    ADD CONSTRAINT mailing_statuses_pkey PRIMARY KEY (id);


--
-- Name: municipalities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY municipalities
    ADD CONSTRAINT municipalities_pkey PRIMARY KEY (state_id, ansi_code);


--
-- Name: municipality_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY municipality_categories
    ADD CONSTRAINT municipality_categories_pkey PRIMARY KEY (id);


--
-- Name: nations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nations
    ADD CONSTRAINT nations_pkey PRIMARY KEY (id);


--
-- Name: office_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY office_types
    ADD CONSTRAINT office_types_pkey PRIMARY KEY (id);


--
-- Name: offices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_pkey PRIMARY KEY (id);


--
-- Name: official_mailing_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY official_mailing_recipients
    ADD CONSTRAINT official_mailing_recipients_pkey PRIMARY KEY (id);


--
-- Name: official_mailings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY official_mailings
    ADD CONSTRAINT official_mailings_pkey PRIMARY KEY (id);


--
-- Name: official_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY official_terms
    ADD CONSTRAINT official_terms_pkey PRIMARY KEY (id);


--
-- Name: officials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY officials
    ADD CONSTRAINT officials_pkey PRIMARY KEY (id);


--
-- Name: parties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parties
    ADD CONSTRAINT parties_pkey PRIMARY KEY (id);


--
-- Name: polity_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY polity_types
    ADD CONSTRAINT polity_types_pkey PRIMARY KEY (id);


--
-- Name: poll_workflow_states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY poll_workflow_states
    ADD CONSTRAINT poll_workflow_states_pkey PRIMARY KEY (id);


--
-- Name: postal_cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY postal_cities
    ADD CONSTRAINT postal_cities_pkey PRIMARY KEY (state_id, name);


--
-- Name: question_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY question_votes
    ADD CONSTRAINT question_votes_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: quick_poll_mailings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quick_poll_mailings
    ADD CONSTRAINT quick_poll_mailings_pkey PRIMARY KEY (id);


--
-- Name: quick_poll_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quick_poll_options
    ADD CONSTRAINT quick_poll_options_pkey PRIMARY KEY (id);


--
-- Name: quick_poll_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quick_poll_responses
    ADD CONSTRAINT quick_poll_responses_pkey PRIMARY KEY (quick_poll_id, user_id);


--
-- Name: quick_poll_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quick_poll_types
    ADD CONSTRAINT quick_poll_types_pkey PRIMARY KEY (id);


--
-- Name: quick_poll_unregistered_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quick_poll_unregistered_responses
    ADD CONSTRAINT quick_poll_unregistered_responses_pkey PRIMARY KEY (quick_poll_id, uid);


--
-- Name: quick_polls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY quick_polls
    ADD CONSTRAINT quick_polls_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: site_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY site_roles
    ADD CONSTRAINT site_roles_pkey PRIMARY KEY (id);


--
-- Name: standard_poll_option_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY standard_poll_option_sets
    ADD CONSTRAINT standard_poll_option_sets_pkey PRIMARY KEY (id);


--
-- Name: standard_poll_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY standard_poll_options
    ADD CONSTRAINT standard_poll_options_pkey PRIMARY KEY (id);


--
-- Name: state_house_districts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY state_house_districts
    ADD CONSTRAINT state_house_districts_pkey PRIMARY KEY (state_id, district);


--
-- Name: state_senate_districts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY state_senate_districts
    ADD CONSTRAINT state_senate_districts_pkey PRIMARY KEY (state_id, district);


--
-- Name: states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: taggable_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taggable_types
    ADD CONSTRAINT taggable_types_pkey PRIMARY KEY (type);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: temp_imp_zip_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY temp_imp_zip_codes
    ADD CONSTRAINT temp_imp_zip_codes_pkey PRIMARY KEY (id);


--
-- Name: terms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY terms
    ADD CONSTRAINT terms_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wards
    ADD CONSTRAINT wards_pkey PRIMARY KEY (state_id, municipality_ansi_code, ward);


--
-- Name: zip_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY zip_codes
    ADD CONSTRAINT zip_codes_pkey PRIMARY KEY (id);


--
-- Name: authentications_token_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX authentications_token_idx ON authentications USING btree (token);


--
-- Name: authentications_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX authentications_uid_idx ON authentications USING btree (uid);


--
-- Name: authentications_user_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX authentications_user_id_idx ON authentications USING btree (user_id);


--
-- Name: congressional_districts_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX congressional_districts_uidx ON congressional_districts USING btree (state_id, district);


--
-- Name: counties_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX counties_uidx ON counties USING btree (state_id, name);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: graph_type_name_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX graph_type_name_uidx ON graph_types USING btree (name);


--
-- Name: issues_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX issues_uidx ON issues USING btree (poller_type, poller_id, title);


--
-- Name: joined_official_terms_county_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX joined_official_terms_county_idx ON joined_official_terms USING btree (state_id, county_ansi_code);


--
-- Name: joined_official_terms_municipality_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX joined_official_terms_municipality_idx ON joined_official_terms USING btree (state_id, municipality_ansi_code);


--
-- Name: joined_official_terms_office_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX joined_official_terms_office_idx ON joined_official_terms USING btree (office_id);


--
-- Name: joined_official_terms_office_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX joined_official_terms_office_type_idx ON joined_official_terms USING btree (office_type_id);


--
-- Name: joined_official_terms_official_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX joined_official_terms_official_idx ON joined_official_terms USING btree (official_id);


--
-- Name: joined_official_terms_term_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX joined_official_terms_term_idx ON joined_official_terms USING btree (term_id);


--
-- Name: joined_official_terms_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX joined_official_terms_uidx ON joined_official_terms USING btree (official_term_id);


--
-- Name: municipalities_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX municipalities_name_idx ON municipalities USING btree (name);


--
-- Name: municipalities_state_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX municipalities_state_idx ON municipalities USING btree (state_id, name);


--
-- Name: office_types_polity_type_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX office_types_polity_type_uidx ON office_types USING btree (id, polity_type_id);


--
-- Name: office_types_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX office_types_uidx ON office_types USING btree (ukey);


--
-- Name: offices_congress_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX offices_congress_uidx ON offices USING btree (state_id, congressional_district_no);


--
-- Name: offices_state_house_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX offices_state_house_uidx ON offices USING btree (state_id, state_house_district_key, discriminator);


--
-- Name: offices_state_senate_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX offices_state_senate_uidx ON offices USING btree (state_id, state_senate_district_key, discriminator);


--
-- Name: offices_us_senate_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX offices_us_senate_uidx ON offices USING btree (state_id, us_senate_class);


--
-- Name: official_mailing_recipients_mailing_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX official_mailing_recipients_mailing_idx ON official_mailing_recipients USING btree (official_mailing_id);


--
-- Name: official_mailings_official_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX official_mailings_official_idx ON official_mailings USING btree (official_id);


--
-- Name: official_mailings_status_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX official_mailings_status_idx ON official_mailings USING btree (mailing_status_id);


--
-- Name: official_terms_office_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX official_terms_office_idx ON official_terms USING btree (office_id);


--
-- Name: official_terms_official_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX official_terms_official_idx ON official_terms USING btree (official_id);


--
-- Name: official_terms_term_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX official_terms_term_idx ON official_terms USING btree (term_id);


--
-- Name: officials_bioguide_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX officials_bioguide_uidx ON officials USING btree (bioguide_id);


--
-- Name: officials_facebook_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX officials_facebook_uidx ON officials USING btree (facebook_id);


--
-- Name: officials_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX officials_name_idx ON officials USING btree (last_name, first_name, middle_name);


--
-- Name: officials_open_states_leg_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX officials_open_states_leg_uidx ON officials USING btree (open_states_leg_id);


--
-- Name: officials_votesmart_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX officials_votesmart_uidx ON officials USING btree (votesmart_id);


--
-- Name: polity_types_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX polity_types_uidx ON polity_types USING btree (name);


--
-- Name: question_votes_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX question_votes_uidx ON question_votes USING btree (question_id, user_id);


--
-- Name: quick_poll_mailings_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX quick_poll_mailings_idx ON quick_poll_mailings USING btree (official_mailing_id);


--
-- Name: quick_poll_mailings_poll_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX quick_poll_mailings_poll_idx ON quick_poll_mailings USING btree (quick_poll_id);


--
-- Name: quick_poll_options_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX quick_poll_options_uidx ON quick_poll_options USING btree (quick_poll_id, value);


--
-- Name: quick_poll_responses_user_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX quick_poll_responses_user_idx ON quick_poll_responses USING btree (user_id);


--
-- Name: quick_polls_end_time_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX quick_polls_end_time_idx ON quick_polls USING btree (end_time);


--
-- Name: quick_polls_issue_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX quick_polls_issue_idx ON quick_polls USING btree (issue_id);


--
-- Name: quick_polls_start_time_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX quick_polls_start_time_idx ON quick_polls USING btree (start_time);


--
-- Name: site_role_name_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX site_role_name_uidx ON site_roles USING btree (name);


--
-- Name: standard_poll_option_sets_name_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX standard_poll_option_sets_name_uidx ON standard_poll_option_sets USING btree (name);


--
-- Name: standard_poll_options_text_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX standard_poll_options_text_uidx ON standard_poll_options USING btree (standard_poll_option_set_id, text);


--
-- Name: standard_poll_options_value_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX standard_poll_options_value_uidx ON standard_poll_options USING btree (standard_poll_option_set_id, value);


--
-- Name: states_abbreviation_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX states_abbreviation_uidx ON states USING btree (abbreviation);


--
-- Name: states_name_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX states_name_uidx ON states USING btree (name);


--
-- Name: tags_taggable_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX tags_taggable_idx ON tags USING btree (taggable_type, taggable_id);


--
-- Name: tags_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX tags_uidx ON tags USING btree (tag, context, taggable_type, taggable_id);


--
-- Name: terms_from_date_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX terms_from_date_idx ON terms USING btree (from_date);


--
-- Name: terms_office_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX terms_office_type_idx ON terms USING btree (office_type_id);


--
-- Name: terms_to_date_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX terms_to_date_idx ON terms USING btree (to_date);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: users_email_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX users_email_uidx ON users USING btree (email);


--
-- Name: users_reset_password_token_uidx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX users_reset_password_token_uidx ON users USING btree (reset_password_token);


--
-- Name: users_site_role_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX users_site_role_idx ON users USING btree (site_role_id);


--
-- Name: users_staff_official_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX users_staff_official_idx ON users USING btree (staff_official_id);


--
-- Name: jot_counties_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_counties_update_trigger AFTER UPDATE ON counties FOR EACH ROW EXECUTE PROCEDURE jot_counties_update_trigger();


--
-- Name: jot_municipalities_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_municipalities_update_trigger AFTER UPDATE ON municipalities FOR EACH ROW EXECUTE PROCEDURE jot_municipalities_update_trigger();


--
-- Name: jot_office_types_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_office_types_update_trigger AFTER UPDATE ON office_types FOR EACH ROW EXECUTE PROCEDURE jot_office_types_update_trigger();


--
-- Name: jot_offices_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_offices_update_trigger AFTER UPDATE ON offices FOR EACH ROW EXECUTE PROCEDURE jot_offices_update_trigger();


--
-- Name: jot_official_terms_delete_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_official_terms_delete_trigger AFTER DELETE ON official_terms FOR EACH ROW EXECUTE PROCEDURE jot_official_terms_delete_trigger();


--
-- Name: jot_official_terms_insert_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_official_terms_insert_trigger AFTER INSERT ON official_terms FOR EACH ROW EXECUTE PROCEDURE jot_official_terms_insert_trigger();


--
-- Name: jot_official_terms_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_official_terms_update_trigger AFTER UPDATE ON official_terms FOR EACH ROW EXECUTE PROCEDURE jot_official_terms_update_trigger();


--
-- Name: jot_officials_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_officials_update_trigger AFTER UPDATE ON officials FOR EACH ROW EXECUTE PROCEDURE jot_officials_update_trigger();


--
-- Name: jot_terms_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER jot_terms_update_trigger AFTER UPDATE ON terms FOR EACH ROW EXECUTE PROCEDURE jot_terms_update_trigger();


--
-- Name: authentications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: congressional_districts_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY congressional_districts
    ADD CONSTRAINT congressional_districts_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: counties_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY counties
    ADD CONSTRAINT counties_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: municipalities_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY municipalities
    ADD CONSTRAINT municipalities_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: office_types_polity_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY office_types
    ADD CONSTRAINT office_types_polity_type_id_fkey FOREIGN KEY (polity_type_id) REFERENCES polity_types(id);


--
-- Name: offices_office_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_office_type_id_fkey FOREIGN KEY (office_type_id) REFERENCES office_types(id);


--
-- Name: offices_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: offices_state_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_state_id_fkey1 FOREIGN KEY (state_id, congressional_district_no) REFERENCES congressional_districts(state_id, district);


--
-- Name: offices_state_id_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_state_id_fkey2 FOREIGN KEY (state_id, county_ansi_code) REFERENCES counties(state_id, ansi_code);


--
-- Name: offices_state_id_fkey3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_state_id_fkey3 FOREIGN KEY (state_id, municipality_ansi_code) REFERENCES municipalities(state_id, ansi_code);


--
-- Name: offices_state_id_fkey4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_state_id_fkey4 FOREIGN KEY (state_id, state_senate_district_key) REFERENCES state_senate_districts(state_id, district);


--
-- Name: offices_state_id_fkey5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_state_id_fkey5 FOREIGN KEY (state_id, state_house_district_key) REFERENCES state_house_districts(state_id, district);


--
-- Name: offices_state_id_fkey6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_state_id_fkey6 FOREIGN KEY (state_id, municipality_ansi_code, ward) REFERENCES wards(state_id, municipality_ansi_code, ward);


--
-- Name: official_mailing_recipients_official_mailing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_mailing_recipients
    ADD CONSTRAINT official_mailing_recipients_official_mailing_id_fkey FOREIGN KEY (official_mailing_id) REFERENCES official_mailings(id);


--
-- Name: official_mailing_recipients_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_mailing_recipients
    ADD CONSTRAINT official_mailing_recipients_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: official_mailings_official_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_mailings
    ADD CONSTRAINT official_mailings_official_id_fkey FOREIGN KEY (official_id) REFERENCES officials(id);


--
-- Name: official_mailings_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_mailings
    ADD CONSTRAINT official_mailings_status_id_fkey FOREIGN KEY (mailing_status_id) REFERENCES mailing_statuses(id);


--
-- Name: official_terms_office_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_terms
    ADD CONSTRAINT official_terms_office_id_fkey FOREIGN KEY (office_id) REFERENCES offices(id);


--
-- Name: official_terms_official_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_terms
    ADD CONSTRAINT official_terms_official_id_fkey FOREIGN KEY (official_id) REFERENCES officials(id);


--
-- Name: official_terms_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY official_terms
    ADD CONSTRAINT official_terms_term_id_fkey FOREIGN KEY (term_id) REFERENCES terms(id);


--
-- Name: officials_party_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY officials
    ADD CONSTRAINT officials_party_id_fkey FOREIGN KEY (party_id) REFERENCES parties(id);


--
-- Name: postal_cities_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postal_cities
    ADD CONSTRAINT postal_cities_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: question_votes_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_votes
    ADD CONSTRAINT question_votes_question_id_fkey FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: question_votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_votes
    ADD CONSTRAINT question_votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: questions_official_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_official_id_fkey FOREIGN KEY (official_id) REFERENCES officials(id);


--
-- Name: questions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: quick_poll_mailings_official_mailing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_mailings
    ADD CONSTRAINT quick_poll_mailings_official_mailing_id_fkey FOREIGN KEY (official_mailing_id) REFERENCES official_mailings(id);


--
-- Name: quick_poll_mailings_quick_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_mailings
    ADD CONSTRAINT quick_poll_mailings_quick_poll_id_fkey FOREIGN KEY (quick_poll_id) REFERENCES quick_polls(id);


--
-- Name: quick_poll_options_quick_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_options
    ADD CONSTRAINT quick_poll_options_quick_poll_id_fkey FOREIGN KEY (quick_poll_id) REFERENCES quick_polls(id);


--
-- Name: quick_poll_responses_quick_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_responses
    ADD CONSTRAINT quick_poll_responses_quick_poll_id_fkey FOREIGN KEY (quick_poll_id) REFERENCES quick_polls(id);


--
-- Name: quick_poll_responses_quick_poll_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_responses
    ADD CONSTRAINT quick_poll_responses_quick_poll_id_fkey1 FOREIGN KEY (quick_poll_id, value) REFERENCES quick_poll_options(quick_poll_id, value);


--
-- Name: quick_poll_responses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_responses
    ADD CONSTRAINT quick_poll_responses_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: quick_poll_unregistered_responses_quick_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_unregistered_responses
    ADD CONSTRAINT quick_poll_unregistered_responses_quick_poll_id_fkey FOREIGN KEY (quick_poll_id) REFERENCES quick_polls(id);


--
-- Name: quick_poll_unregistered_responses_quick_poll_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_poll_unregistered_responses
    ADD CONSTRAINT quick_poll_unregistered_responses_quick_poll_id_fkey1 FOREIGN KEY (quick_poll_id, value) REFERENCES quick_poll_options(quick_poll_id, value);


--
-- Name: quick_polls_graph_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_polls
    ADD CONSTRAINT quick_polls_graph_type_id_fkey FOREIGN KEY (graph_type_id) REFERENCES graph_types(id);


--
-- Name: quick_polls_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_polls
    ADD CONSTRAINT quick_polls_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES issues(id);


--
-- Name: quick_polls_poll_workflow_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_polls
    ADD CONSTRAINT quick_polls_poll_workflow_state_id_fkey FOREIGN KEY (poll_workflow_state_id) REFERENCES poll_workflow_states(id);


--
-- Name: quick_polls_quick_poll_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY quick_polls
    ADD CONSTRAINT quick_polls_quick_poll_type_id_fkey FOREIGN KEY (quick_poll_type_id) REFERENCES quick_poll_types(id);


--
-- Name: standard_poll_options_standard_poll_option_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY standard_poll_options
    ADD CONSTRAINT standard_poll_options_standard_poll_option_set_id_fkey FOREIGN KEY (standard_poll_option_set_id) REFERENCES standard_poll_option_sets(id) ON DELETE CASCADE;


--
-- Name: state_house_districts_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY state_house_districts
    ADD CONSTRAINT state_house_districts_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: state_senate_districts_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY state_senate_districts
    ADD CONSTRAINT state_senate_districts_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: tags_taggable_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_taggable_type_fkey FOREIGN KEY (taggable_type) REFERENCES taggable_types(type);


--
-- Name: terms_office_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY terms
    ADD CONSTRAINT terms_office_type_id_fkey FOREIGN KEY (office_type_id) REFERENCES office_types(id);


--
-- Name: users_rep_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_rep_state_id_fkey FOREIGN KEY (rep_state_id) REFERENCES states(id);


--
-- Name: users_rep_state_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_rep_state_id_fkey1 FOREIGN KEY (rep_state_id, rep_congressional_district_no) REFERENCES congressional_districts(state_id, district);


--
-- Name: users_rep_state_id_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_rep_state_id_fkey2 FOREIGN KEY (rep_state_id, rep_state_senate_district_key) REFERENCES state_senate_districts(state_id, district);


--
-- Name: users_rep_state_id_fkey3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_rep_state_id_fkey3 FOREIGN KEY (rep_state_id, rep_state_house_district_key) REFERENCES state_house_districts(state_id, district);


--
-- Name: users_rep_state_id_fkey4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_rep_state_id_fkey4 FOREIGN KEY (rep_state_id, rep_county_ansi_code) REFERENCES counties(state_id, ansi_code);


--
-- Name: users_rep_state_id_fkey5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_rep_state_id_fkey5 FOREIGN KEY (rep_state_id, rep_municipality_ansi_code) REFERENCES municipalities(state_id, ansi_code);


--
-- Name: users_rep_state_id_fkey6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_rep_state_id_fkey6 FOREIGN KEY (rep_state_id, rep_municipality_ansi_code, rep_ward_key) REFERENCES wards(state_id, municipality_ansi_code, ward);


--
-- Name: users_site_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_site_role_id_fkey FOREIGN KEY (site_role_id) REFERENCES site_roles(id);


--
-- Name: users_staff_official_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_staff_official_id_fkey FOREIGN KEY (staff_official_id) REFERENCES officials(id);


--
-- Name: wards_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wards
    ADD CONSTRAINT wards_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: wards_state_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wards
    ADD CONSTRAINT wards_state_id_fkey1 FOREIGN KEY (state_id, municipality_ansi_code) REFERENCES municipalities(state_id, ansi_code);


--
-- Name: zip_codes_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY zip_codes
    ADD CONSTRAINT zip_codes_state_id_fkey FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: zip_codes_state_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY zip_codes
    ADD CONSTRAINT zip_codes_state_id_fkey1 FOREIGN KEY (state_id, postal_city_name) REFERENCES postal_cities(state_id, name);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

