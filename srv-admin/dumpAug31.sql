--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1 (Debian 13.1-1.pgdg100+1)

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

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authentication_local_invitationtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_local_invitationtoken (
    token character varying(60) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    contract_id character varying(256) NOT NULL,
    principal_id character varying(256) NOT NULL,
    target_email character varying(254),
    user_id integer NOT NULL
);


ALTER TABLE public.authentication_local_invitationtoken OWNER TO postgres;

--
-- Name: authentication_local_passwordresettoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_local_passwordresettoken (
    token character varying(60) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authentication_local_passwordresettoken OWNER TO postgres;

--
-- Name: authentication_local_verificationtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_local_verificationtoken (
    token character varying(60) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authentication_local_verificationtoken OWNER TO postgres;

--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO postgres;

--
-- Name: chat_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_session (
    id integer NOT NULL,
    is_customer_session boolean NOT NULL,
    code character varying(150) NOT NULL
);


ALTER TABLE public.chat_session OWNER TO postgres;

--
-- Name: chat_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_session_id_seq OWNER TO postgres;

--
-- Name: chat_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_session_id_seq OWNED BY public.chat_session.id;


--
-- Name: content_faq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_faq (
    id integer NOT NULL,
    title character varying(150) NOT NULL,
    text text NOT NULL,
    href character varying(256),
    "group" character varying(150),
    sorting integer NOT NULL,
    visible_object character varying(1024),
    visible_role_id integer
);


ALTER TABLE public.content_faq OWNER TO postgres;

--
-- Name: content_faq_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_faq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_faq_id_seq OWNER TO postgres;

--
-- Name: content_faq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_faq_id_seq OWNED BY public.content_faq.id;


--
-- Name: content_news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_news (
    id integer NOT NULL,
    title character varying(150) NOT NULL,
    text text NOT NULL,
    document character varying(350),
    href character varying(1024),
    kind character varying(2) NOT NULL,
    show_in_header boolean NOT NULL,
    date_from date,
    date_to date,
    "order" integer NOT NULL,
    documents character varying(350),
    CONSTRAINT content_news_order_check CHECK (("order" >= 0))
);


ALTER TABLE public.content_news OWNER TO postgres;

--
-- Name: content_news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_news_id_seq OWNER TO postgres;

--
-- Name: content_news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_news_id_seq OWNED BY public.content_news.id;


--
-- Name: content_news_property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_news_property (
    id integer NOT NULL,
    news_id integer NOT NULL,
    property_id character varying(20) NOT NULL
);


ALTER TABLE public.content_news_property OWNER TO postgres;

--
-- Name: content_news_property_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_news_property_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_news_property_id_seq OWNER TO postgres;

--
-- Name: content_news_property_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_news_property_id_seq OWNED BY public.content_news_property.id;


--
-- Name: content_offer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_offer (
    id integer NOT NULL,
    title character varying(150) NOT NULL,
    text text NOT NULL,
    icon character varying(100),
    website character varying(250) NOT NULL,
    hidden boolean NOT NULL,
    only_login boolean NOT NULL,
    only_guest boolean NOT NULL,
    report_clickes integer NOT NULL,
    sorting integer NOT NULL,
    date_from date,
    date_to date,
    visible_role_id integer,
    icons character varying(350)
);


ALTER TABLE public.content_offer OWNER TO postgres;

--
-- Name: content_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_offer_id_seq OWNER TO postgres;

--
-- Name: content_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_offer_id_seq OWNED BY public.content_offer.id;


--
-- Name: content_page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_page (
    id integer NOT NULL,
    slug character varying(150) NOT NULL,
    html text NOT NULL
);


ALTER TABLE public.content_page OWNER TO postgres;

--
-- Name: content_page_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_page_id_seq OWNER TO postgres;

--
-- Name: content_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_page_id_seq OWNED BY public.content_page.id;


--
-- Name: defect_area; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_area (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    name_af character varying(100),
    name_ar character varying(100),
    name_ar_dz character varying(100),
    name_ast character varying(100),
    name_az character varying(100),
    name_bg character varying(100),
    name_be character varying(100),
    name_bn character varying(100),
    name_br character varying(100),
    name_bs character varying(100),
    name_ca character varying(100),
    name_cs character varying(100),
    name_cy character varying(100),
    name_da character varying(100),
    name_de character varying(100),
    name_dsb character varying(100),
    name_el character varying(100),
    name_en character varying(100),
    name_en_au character varying(100),
    name_en_gb character varying(100),
    name_eo character varying(100),
    name_es character varying(100),
    name_es_ar character varying(100),
    name_es_co character varying(100),
    name_es_mx character varying(100),
    name_es_ni character varying(100),
    name_es_ve character varying(100),
    name_et character varying(100),
    name_eu character varying(100),
    name_fa character varying(100),
    name_fi character varying(100),
    name_fr character varying(100),
    name_fy character varying(100),
    name_ga character varying(100),
    name_gd character varying(100),
    name_gl character varying(100),
    name_he character varying(100),
    name_hi character varying(100),
    name_hr character varying(100),
    name_hsb character varying(100),
    name_hu character varying(100),
    name_hy character varying(100),
    name_ia character varying(100),
    name_ind character varying(100),
    name_ig character varying(100),
    name_io character varying(100),
    name_is character varying(100),
    name_it character varying(100),
    name_ja character varying(100),
    name_ka character varying(100),
    name_kab character varying(100),
    name_kk character varying(100),
    name_km character varying(100),
    name_kn character varying(100),
    name_ko character varying(100),
    name_ky character varying(100),
    name_lb character varying(100),
    name_lt character varying(100),
    name_lv character varying(100),
    name_mk character varying(100),
    name_ml character varying(100),
    name_mn character varying(100),
    name_mr character varying(100),
    name_my character varying(100),
    name_nb character varying(100),
    name_ne character varying(100),
    name_nl character varying(100),
    name_nn character varying(100),
    name_os character varying(100),
    name_pa character varying(100),
    name_pl character varying(100),
    name_pt character varying(100),
    name_pt_br character varying(100),
    name_ro character varying(100),
    name_ru character varying(100),
    name_sk character varying(100),
    name_sl character varying(100),
    name_sq character varying(100),
    name_sr character varying(100),
    name_sr_latn character varying(100),
    name_sv character varying(100),
    name_sw character varying(100),
    name_ta character varying(100),
    name_te character varying(100),
    name_tg character varying(100),
    name_th character varying(100),
    name_tk character varying(100),
    name_tr character varying(100),
    name_tt character varying(100),
    name_udm character varying(100),
    name_uk character varying(100),
    name_ur character varying(100),
    name_uz character varying(100),
    name_vi character varying(100),
    name_zh_hans character varying(100),
    name_zh_hant character varying(100),
    sorting smallint NOT NULL,
    CONSTRAINT defect_area_sorting_check CHECK ((sorting >= 0))
);


ALTER TABLE public.defect_area OWNER TO postgres;

--
-- Name: defect_area_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_area_id_seq OWNER TO postgres;

--
-- Name: defect_area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_area_id_seq OWNED BY public.defect_area.id;


--
-- Name: defect_area_visible_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_area_visible_groups (
    id integer NOT NULL,
    area_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.defect_area_visible_groups OWNER TO postgres;

--
-- Name: defect_area_visible_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_area_visible_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_area_visible_groups_id_seq OWNER TO postgres;

--
-- Name: defect_area_visible_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_area_visible_groups_id_seq OWNED BY public.defect_area_visible_groups.id;


--
-- Name: defect_defect; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_defect (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    name_af character varying(100),
    name_ar character varying(100),
    name_ar_dz character varying(100),
    name_ast character varying(100),
    name_az character varying(100),
    name_bg character varying(100),
    name_be character varying(100),
    name_bn character varying(100),
    name_br character varying(100),
    name_bs character varying(100),
    name_ca character varying(100),
    name_cs character varying(100),
    name_cy character varying(100),
    name_da character varying(100),
    name_de character varying(100),
    name_dsb character varying(100),
    name_el character varying(100),
    name_en character varying(100),
    name_en_au character varying(100),
    name_en_gb character varying(100),
    name_eo character varying(100),
    name_es character varying(100),
    name_es_ar character varying(100),
    name_es_co character varying(100),
    name_es_mx character varying(100),
    name_es_ni character varying(100),
    name_es_ve character varying(100),
    name_et character varying(100),
    name_eu character varying(100),
    name_fa character varying(100),
    name_fi character varying(100),
    name_fr character varying(100),
    name_fy character varying(100),
    name_ga character varying(100),
    name_gd character varying(100),
    name_gl character varying(100),
    name_he character varying(100),
    name_hi character varying(100),
    name_hr character varying(100),
    name_hsb character varying(100),
    name_hu character varying(100),
    name_hy character varying(100),
    name_ia character varying(100),
    name_ind character varying(100),
    name_ig character varying(100),
    name_io character varying(100),
    name_is character varying(100),
    name_it character varying(100),
    name_ja character varying(100),
    name_ka character varying(100),
    name_kab character varying(100),
    name_kk character varying(100),
    name_km character varying(100),
    name_kn character varying(100),
    name_ko character varying(100),
    name_ky character varying(100),
    name_lb character varying(100),
    name_lt character varying(100),
    name_lv character varying(100),
    name_mk character varying(100),
    name_ml character varying(100),
    name_mn character varying(100),
    name_mr character varying(100),
    name_my character varying(100),
    name_nb character varying(100),
    name_ne character varying(100),
    name_nl character varying(100),
    name_nn character varying(100),
    name_os character varying(100),
    name_pa character varying(100),
    name_pl character varying(100),
    name_pt character varying(100),
    name_pt_br character varying(100),
    name_ro character varying(100),
    name_ru character varying(100),
    name_sk character varying(100),
    name_sl character varying(100),
    name_sq character varying(100),
    name_sr character varying(100),
    name_sr_latn character varying(100),
    name_sv character varying(100),
    name_sw character varying(100),
    name_ta character varying(100),
    name_te character varying(100),
    name_tg character varying(100),
    name_th character varying(100),
    name_tk character varying(100),
    name_tr character varying(100),
    name_tt character varying(100),
    name_udm character varying(100),
    name_uk character varying(100),
    name_ur character varying(100),
    name_uz character varying(100),
    name_vi character varying(100),
    name_zh_hans character varying(100),
    name_zh_hant character varying(100),
    show_emergency_alert boolean NOT NULL,
    is_image_required boolean NOT NULL,
    area_id integer,
    defect_type_id integer
);


ALTER TABLE public.defect_defect OWNER TO postgres;

--
-- Name: defect_defect_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_defect_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_defect_id_seq OWNER TO postgres;

--
-- Name: defect_defect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_defect_id_seq OWNED BY public.defect_defect.id;


--
-- Name: defect_defect_visible_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_defect_visible_groups (
    id integer NOT NULL,
    defect_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.defect_defect_visible_groups OWNER TO postgres;

--
-- Name: defect_defect_visible_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_defect_visible_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_defect_visible_groups_id_seq OWNER TO postgres;

--
-- Name: defect_defect_visible_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_defect_visible_groups_id_seq OWNED BY public.defect_defect_visible_groups.id;


--
-- Name: defect_defectresolutionrating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_defectresolutionrating (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    is_defect_resolved boolean NOT NULL,
    craftsman_rating integer NOT NULL,
    reported_defect_id integer,
    CONSTRAINT defect_defectresolutionrating_craftsman_rating_check CHECK ((craftsman_rating >= 0))
);


ALTER TABLE public.defect_defectresolutionrating OWNER TO postgres;

--
-- Name: defect_defectresolutionrating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_defectresolutionrating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_defectresolutionrating_id_seq OWNER TO postgres;

--
-- Name: defect_defectresolutionrating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_defectresolutionrating_id_seq OWNED BY public.defect_defectresolutionrating.id;


--
-- Name: defect_defecttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_defecttype (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    name_af character varying(100),
    name_ar character varying(100),
    name_ar_dz character varying(100),
    name_ast character varying(100),
    name_az character varying(100),
    name_bg character varying(100),
    name_be character varying(100),
    name_bn character varying(100),
    name_br character varying(100),
    name_bs character varying(100),
    name_ca character varying(100),
    name_cs character varying(100),
    name_cy character varying(100),
    name_da character varying(100),
    name_de character varying(100),
    name_dsb character varying(100),
    name_el character varying(100),
    name_en character varying(100),
    name_en_au character varying(100),
    name_en_gb character varying(100),
    name_eo character varying(100),
    name_es character varying(100),
    name_es_ar character varying(100),
    name_es_co character varying(100),
    name_es_mx character varying(100),
    name_es_ni character varying(100),
    name_es_ve character varying(100),
    name_et character varying(100),
    name_eu character varying(100),
    name_fa character varying(100),
    name_fi character varying(100),
    name_fr character varying(100),
    name_fy character varying(100),
    name_ga character varying(100),
    name_gd character varying(100),
    name_gl character varying(100),
    name_he character varying(100),
    name_hi character varying(100),
    name_hr character varying(100),
    name_hsb character varying(100),
    name_hu character varying(100),
    name_hy character varying(100),
    name_ia character varying(100),
    name_ind character varying(100),
    name_ig character varying(100),
    name_io character varying(100),
    name_is character varying(100),
    name_it character varying(100),
    name_ja character varying(100),
    name_ka character varying(100),
    name_kab character varying(100),
    name_kk character varying(100),
    name_km character varying(100),
    name_kn character varying(100),
    name_ko character varying(100),
    name_ky character varying(100),
    name_lb character varying(100),
    name_lt character varying(100),
    name_lv character varying(100),
    name_mk character varying(100),
    name_ml character varying(100),
    name_mn character varying(100),
    name_mr character varying(100),
    name_my character varying(100),
    name_nb character varying(100),
    name_ne character varying(100),
    name_nl character varying(100),
    name_nn character varying(100),
    name_os character varying(100),
    name_pa character varying(100),
    name_pl character varying(100),
    name_pt character varying(100),
    name_pt_br character varying(100),
    name_ro character varying(100),
    name_ru character varying(100),
    name_sk character varying(100),
    name_sl character varying(100),
    name_sq character varying(100),
    name_sr character varying(100),
    name_sr_latn character varying(100),
    name_sv character varying(100),
    name_sw character varying(100),
    name_ta character varying(100),
    name_te character varying(100),
    name_tg character varying(100),
    name_th character varying(100),
    name_tk character varying(100),
    name_tr character varying(100),
    name_tt character varying(100),
    name_udm character varying(100),
    name_uk character varying(100),
    name_ur character varying(100),
    name_uz character varying(100),
    name_vi character varying(100),
    name_zh_hans character varying(100),
    name_zh_hant character varying(100),
    description character varying(100),
    description_af character varying(100),
    description_ar character varying(100),
    description_ar_dz character varying(100),
    description_ast character varying(100),
    description_az character varying(100),
    description_bg character varying(100),
    description_be character varying(100),
    description_bn character varying(100),
    description_br character varying(100),
    description_bs character varying(100),
    description_ca character varying(100),
    description_cs character varying(100),
    description_cy character varying(100),
    description_da character varying(100),
    description_de character varying(100),
    description_dsb character varying(100),
    description_el character varying(100),
    description_en character varying(100),
    description_en_au character varying(100),
    description_en_gb character varying(100),
    description_eo character varying(100),
    description_es character varying(100),
    description_es_ar character varying(100),
    description_es_co character varying(100),
    description_es_mx character varying(100),
    description_es_ni character varying(100),
    description_es_ve character varying(100),
    description_et character varying(100),
    description_eu character varying(100),
    description_fa character varying(100),
    description_fi character varying(100),
    description_fr character varying(100),
    description_fy character varying(100),
    description_ga character varying(100),
    description_gd character varying(100),
    description_gl character varying(100),
    description_he character varying(100),
    description_hi character varying(100),
    description_hr character varying(100),
    description_hsb character varying(100),
    description_hu character varying(100),
    description_hy character varying(100),
    description_ia character varying(100),
    description_ind character varying(100),
    description_ig character varying(100),
    description_io character varying(100),
    description_is character varying(100),
    description_it character varying(100),
    description_ja character varying(100),
    description_ka character varying(100),
    description_kab character varying(100),
    description_kk character varying(100),
    description_km character varying(100),
    description_kn character varying(100),
    description_ko character varying(100),
    description_ky character varying(100),
    description_lb character varying(100),
    description_lt character varying(100),
    description_lv character varying(100),
    description_mk character varying(100),
    description_ml character varying(100),
    description_mn character varying(100),
    description_mr character varying(100),
    description_my character varying(100),
    description_nb character varying(100),
    description_ne character varying(100),
    description_nl character varying(100),
    description_nn character varying(100),
    description_os character varying(100),
    description_pa character varying(100),
    description_pl character varying(100),
    description_pt character varying(100),
    description_pt_br character varying(100),
    description_ro character varying(100),
    description_ru character varying(100),
    description_sk character varying(100),
    description_sl character varying(100),
    description_sq character varying(100),
    description_sr character varying(100),
    description_sr_latn character varying(100),
    description_sv character varying(100),
    description_sw character varying(100),
    description_ta character varying(100),
    description_te character varying(100),
    description_tg character varying(100),
    description_th character varying(100),
    description_tk character varying(100),
    description_tr character varying(100),
    description_tt character varying(100),
    description_udm character varying(100),
    description_uk character varying(100),
    description_ur character varying(100),
    description_uz character varying(100),
    description_vi character varying(100),
    description_zh_hans character varying(100),
    description_zh_hant character varying(100),
    sorting smallint NOT NULL,
    CONSTRAINT defect_defecttype_sorting_check CHECK ((sorting >= 0))
);


ALTER TABLE public.defect_defecttype OWNER TO postgres;

--
-- Name: defect_defecttype_areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_defecttype_areas (
    id integer NOT NULL,
    defecttype_id integer NOT NULL,
    area_id integer NOT NULL
);


ALTER TABLE public.defect_defecttype_areas OWNER TO postgres;

--
-- Name: defect_defecttype_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_defecttype_areas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_defecttype_areas_id_seq OWNER TO postgres;

--
-- Name: defect_defecttype_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_defecttype_areas_id_seq OWNED BY public.defect_defecttype_areas.id;


--
-- Name: defect_defecttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_defecttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_defecttype_id_seq OWNER TO postgres;

--
-- Name: defect_defecttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_defecttype_id_seq OWNED BY public.defect_defecttype.id;


--
-- Name: defect_defecttype_visible_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_defecttype_visible_groups (
    id integer NOT NULL,
    defecttype_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.defect_defecttype_visible_groups OWNER TO postgres;

--
-- Name: defect_defecttype_visible_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_defecttype_visible_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_defecttype_visible_groups_id_seq OWNER TO postgres;

--
-- Name: defect_defecttype_visible_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_defecttype_visible_groups_id_seq OWNED BY public.defect_defecttype_visible_groups.id;


--
-- Name: defect_reporteddefect; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect_reporteddefect (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    status character varying(50) NOT NULL,
    description text NOT NULL,
    image_1 character varying(100),
    image_2 character varying(100),
    contract_id integer,
    defect_id integer,
    reported_by_id integer
);


ALTER TABLE public.defect_reporteddefect OWNER TO postgres;

--
-- Name: defect_reporteddefect_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_reporteddefect_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_reporteddefect_id_seq OWNER TO postgres;

--
-- Name: defect_reporteddefect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_reporteddefect_id_seq OWNED BY public.defect_reporteddefect.id;


--
-- Name: dit_push_notifications_pushnotifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dit_push_notifications_pushnotifications (
    id integer NOT NULL,
    title text NOT NULL,
    message text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dit_push_notifications_pushnotifications OWNER TO postgres;

--
-- Name: dit_push_notifications_pushnotifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dit_push_notifications_pushnotifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dit_push_notifications_pushnotifications_id_seq OWNER TO postgres;

--
-- Name: dit_push_notifications_pushnotifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dit_push_notifications_pushnotifications_id_seq OWNED BY public.dit_push_notifications_pushnotifications.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: easy_thumbnails_source; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.easy_thumbnails_source (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL
);


ALTER TABLE public.easy_thumbnails_source OWNER TO postgres;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.easy_thumbnails_source_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_source_id_seq OWNER TO postgres;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.easy_thumbnails_source_id_seq OWNED BY public.easy_thumbnails_source.id;


--
-- Name: easy_thumbnails_thumbnail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.easy_thumbnails_thumbnail (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL,
    source_id integer NOT NULL
);


ALTER TABLE public.easy_thumbnails_thumbnail OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.easy_thumbnails_thumbnail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnail_id_seq OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.easy_thumbnails_thumbnail_id_seq OWNED BY public.easy_thumbnails_thumbnail.id;


--
-- Name: easy_thumbnails_thumbnaildimensions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.easy_thumbnails_thumbnaildimensions (
    id integer NOT NULL,
    thumbnail_id integer NOT NULL,
    width integer,
    height integer,
    CONSTRAINT easy_thumbnails_thumbnaildimensions_height_check CHECK ((height >= 0)),
    CONSTRAINT easy_thumbnails_thumbnaildimensions_width_check CHECK ((width >= 0))
);


ALTER TABLE public.easy_thumbnails_thumbnaildimensions OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.easy_thumbnails_thumbnaildimensions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnaildimensions_id_seq OWNER TO postgres;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.easy_thumbnails_thumbnaildimensions_id_seq OWNED BY public.easy_thumbnails_thumbnaildimensions.id;


--
-- Name: gwg_tenant_tenant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gwg_tenant_tenant (
    bukrs character varying(4) NOT NULL,
    swenr character varying(8) NOT NULL,
    sgenr character varying(8) NOT NULL,
    smenr character varying(8) NOT NULL,
    recnnr character varying(13) NOT NULL,
    name_last character varying(40) NOT NULL,
    name_first character varying(40) NOT NULL,
    partnerid character varying(23) NOT NULL,
    mobile character varying(11),
    phone character varying(11)
);


ALTER TABLE public.gwg_tenant_tenant OWNER TO postgres;

--
-- Name: gwg_tenant_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gwg_tenant_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    email character varying(255) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    is_verified boolean NOT NULL,
    birthdate date,
    city character varying(50),
    first_name character varying(100),
    last_name character varying(100),
    mobile character varying(100),
    phone character varying(100),
    principal_id character varying(100),
    street character varying(100),
    street_number character varying(10),
    zip_code character varying(5),
    is_data_accepted boolean NOT NULL,
    code character varying(200),
    email_contract character varying(255)
);


ALTER TABLE public.gwg_tenant_user OWNER TO postgres;

--
-- Name: gwg_tenant_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gwg_tenant_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.gwg_tenant_user_groups OWNER TO postgres;

--
-- Name: gwg_tenant_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gwg_tenant_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gwg_tenant_user_groups_id_seq OWNER TO postgres;

--
-- Name: gwg_tenant_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gwg_tenant_user_groups_id_seq OWNED BY public.gwg_tenant_user_groups.id;


--
-- Name: gwg_tenant_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gwg_tenant_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gwg_tenant_user_id_seq OWNER TO postgres;

--
-- Name: gwg_tenant_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gwg_tenant_user_id_seq OWNED BY public.gwg_tenant_user.id;


--
-- Name: gwg_tenant_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gwg_tenant_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.gwg_tenant_user_user_permissions OWNER TO postgres;

--
-- Name: gwg_tenant_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gwg_tenant_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gwg_tenant_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: gwg_tenant_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gwg_tenant_user_user_permissions_id_seq OWNED BY public.gwg_tenant_user_user_permissions.id;


--
-- Name: issues_issue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issues_issue (
    id integer NOT NULL,
    "group" character varying(100),
    display_location integer NOT NULL,
    title character varying(200) NOT NULL,
    html text NOT NULL,
    background character varying(100),
    background2 character varying(100),
    attachment character varying(100),
    version character varying(100) NOT NULL,
    signing_type character varying(4),
    description text,
    sorting integer NOT NULL,
    codegrp character varying(200),
    code character varying(200),
    type character varying(200),
    visible_role_id integer,
    category character varying(200),
    description_postman text
);


ALTER TABLE public.issues_issue OWNER TO postgres;

--
-- Name: issues_issue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.issues_issue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issues_issue_id_seq OWNER TO postgres;

--
-- Name: issues_issue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.issues_issue_id_seq OWNED BY public.issues_issue.id;


--
-- Name: issues_issueanswer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issues_issueanswer (
    id integer NOT NULL,
    question character varying(150) NOT NULL,
    type character varying(2) NOT NULL,
    multi boolean NOT NULL,
    marker character varying(100) NOT NULL,
    answers character varying(1024),
    sorting integer NOT NULL,
    required boolean NOT NULL,
    issue_id integer,
    code character varying(100)
);


ALTER TABLE public.issues_issueanswer OWNER TO postgres;

--
-- Name: issues_issueanswer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.issues_issueanswer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issues_issueanswer_id_seq OWNER TO postgres;

--
-- Name: issues_issueanswer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.issues_issueanswer_id_seq OWNED BY public.issues_issueanswer.id;


--
-- Name: issues_issuerequested; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issues_issuerequested (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    answers text,
    status character varying(64),
    issue_id integer,
    user_id integer,
    code character varying(100)
);


ALTER TABLE public.issues_issuerequested OWNER TO postgres;

--
-- Name: issues_issuerequested_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.issues_issuerequested_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issues_issuerequested_id_seq OWNER TO postgres;

--
-- Name: issues_issuerequested_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.issues_issuerequested_id_seq OWNED BY public.issues_issuerequested.id;


--
-- Name: push_notifications_apnsdevice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.push_notifications_apnsdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    device_id uuid,
    registration_id character varying(200) NOT NULL,
    user_id integer,
    application_id character varying(64)
);


ALTER TABLE public.push_notifications_apnsdevice OWNER TO postgres;

--
-- Name: push_notifications_apnsdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.push_notifications_apnsdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_notifications_apnsdevice_id_seq OWNER TO postgres;

--
-- Name: push_notifications_apnsdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.push_notifications_apnsdevice_id_seq OWNED BY public.push_notifications_apnsdevice.id;


--
-- Name: push_notifications_gcmdevice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.push_notifications_gcmdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    device_id bigint,
    registration_id text NOT NULL,
    user_id integer,
    cloud_message_type character varying(3) NOT NULL,
    application_id character varying(64)
);


ALTER TABLE public.push_notifications_gcmdevice OWNER TO postgres;

--
-- Name: push_notifications_gcmdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.push_notifications_gcmdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_notifications_gcmdevice_id_seq OWNER TO postgres;

--
-- Name: push_notifications_gcmdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.push_notifications_gcmdevice_id_seq OWNED BY public.push_notifications_gcmdevice.id;


--
-- Name: push_notifications_webpushdevice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.push_notifications_webpushdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    application_id character varying(64),
    registration_id text NOT NULL,
    p256dh character varying(88) NOT NULL,
    auth character varying(24) NOT NULL,
    browser character varying(10) NOT NULL,
    user_id integer
);


ALTER TABLE public.push_notifications_webpushdevice OWNER TO postgres;

--
-- Name: push_notifications_webpushdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.push_notifications_webpushdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_notifications_webpushdevice_id_seq OWNER TO postgres;

--
-- Name: push_notifications_webpushdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.push_notifications_webpushdevice_id_seq OWNED BY public.push_notifications_webpushdevice.id;


--
-- Name: push_notifications_wnsdevice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.push_notifications_wnsdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    device_id uuid,
    registration_id text NOT NULL,
    user_id integer,
    application_id character varying(64)
);


ALTER TABLE public.push_notifications_wnsdevice OWNER TO postgres;

--
-- Name: push_notifications_wnsdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.push_notifications_wnsdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_notifications_wnsdevice_id_seq OWNER TO postgres;

--
-- Name: push_notifications_wnsdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.push_notifications_wnsdevice_id_seq OWNED BY public.push_notifications_wnsdevice.id;


--
-- Name: real_estate_contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.real_estate_contract (
    id integer NOT NULL,
    code character varying(20),
    number character varying(200),
    company_code character varying(200),
    economic_unit character varying(200),
    building character varying(200),
    type character varying(200),
    type_name character varying(200),
    description character varying(200),
    city character varying(200),
    city_district character varying(200),
    date_from date,
    date_to date,
    is_active boolean,
    rental_contract character varying(200),
    rental_unit character varying(200),
    street character varying(200),
    street_number character varying(200),
    zip_code character varying(200)
);


ALTER TABLE public.real_estate_contract OWNER TO postgres;

--
-- Name: real_estate_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.real_estate_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.real_estate_contract_id_seq OWNER TO postgres;

--
-- Name: real_estate_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.real_estate_contract_id_seq OWNED BY public.real_estate_contract.id;


--
-- Name: real_estate_contract_partners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.real_estate_contract_partners (
    id integer NOT NULL,
    contract_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.real_estate_contract_partners OWNER TO postgres;

--
-- Name: real_estate_contract_partners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.real_estate_contract_partners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.real_estate_contract_partners_id_seq OWNER TO postgres;

--
-- Name: real_estate_contract_partners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.real_estate_contract_partners_id_seq OWNED BY public.real_estate_contract_partners.id;


--
-- Name: real_estate_property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.real_estate_property (
    id character varying(20) NOT NULL,
    company_code integer NOT NULL,
    entity integer NOT NULL,
    object integer NOT NULL,
    street character varying(128),
    number character varying(128),
    zip character varying(128),
    city character varying(128),
    center character varying(128)
);


ALTER TABLE public.real_estate_property OWNER TO postgres;

--
-- Name: survey_survey; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.survey_survey (
    id integer NOT NULL,
    title character varying(512) NOT NULL,
    text text,
    text2 text,
    dialog character varying(512) NOT NULL,
    visible_object character varying(1024),
    date_from date,
    date_to date,
    is_active boolean NOT NULL,
    member integer NOT NULL
);


ALTER TABLE public.survey_survey OWNER TO postgres;

--
-- Name: survey_survey_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.survey_survey_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.survey_survey_id_seq OWNER TO postgres;

--
-- Name: survey_survey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.survey_survey_id_seq OWNED BY public.survey_survey.id;


--
-- Name: survey_surveyanswerstext; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.survey_surveyanswerstext (
    id integer NOT NULL,
    answer1 text,
    answer2 text,
    answer3 text,
    answer4 text,
    answer5 text,
    answer6 text,
    question_id integer,
    user_id integer
);


ALTER TABLE public.survey_surveyanswerstext OWNER TO postgres;

--
-- Name: survey_surveyanswerstext_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.survey_surveyanswerstext_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.survey_surveyanswerstext_id_seq OWNER TO postgres;

--
-- Name: survey_surveyanswerstext_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.survey_surveyanswerstext_id_seq OWNED BY public.survey_surveyanswerstext.id;


--
-- Name: survey_surveymembers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.survey_surveymembers (
    id integer NOT NULL,
    survey_id integer,
    user_id integer
);


ALTER TABLE public.survey_surveymembers OWNER TO postgres;

--
-- Name: survey_surveymembers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.survey_surveymembers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.survey_surveymembers_id_seq OWNER TO postgres;

--
-- Name: survey_surveymembers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.survey_surveymembers_id_seq OWNED BY public.survey_surveymembers.id;


--
-- Name: survey_surveyquestion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.survey_surveyquestion (
    id integer NOT NULL,
    question text,
    multi boolean NOT NULL,
    sorting integer NOT NULL,
    answer1 character varying(512),
    type1 character varying(2) NOT NULL,
    count1 integer NOT NULL,
    answer2 character varying(512),
    type2 character varying(2),
    count2 integer NOT NULL,
    answer3 character varying(512),
    type3 character varying(2),
    count3 integer NOT NULL,
    answer4 character varying(512),
    type4 character varying(2),
    count4 integer NOT NULL,
    answer5 character varying(512),
    type5 character varying(2),
    count5 integer NOT NULL,
    answer6 character varying(512),
    type6 character varying(2),
    count6 integer NOT NULL,
    survey_id integer
);


ALTER TABLE public.survey_surveyquestion OWNER TO postgres;

--
-- Name: survey_surveyquestion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.survey_surveyquestion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.survey_surveyquestion_id_seq OWNER TO postgres;

--
-- Name: survey_surveyquestion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.survey_surveyquestion_id_seq OWNED BY public.survey_surveyquestion.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: chat_session id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_session ALTER COLUMN id SET DEFAULT nextval('public.chat_session_id_seq'::regclass);


--
-- Name: content_faq id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_faq ALTER COLUMN id SET DEFAULT nextval('public.content_faq_id_seq'::regclass);


--
-- Name: content_news id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_news ALTER COLUMN id SET DEFAULT nextval('public.content_news_id_seq'::regclass);


--
-- Name: content_news_property id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_news_property ALTER COLUMN id SET DEFAULT nextval('public.content_news_property_id_seq'::regclass);


--
-- Name: content_offer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_offer ALTER COLUMN id SET DEFAULT nextval('public.content_offer_id_seq'::regclass);


--
-- Name: content_page id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_page ALTER COLUMN id SET DEFAULT nextval('public.content_page_id_seq'::regclass);


--
-- Name: defect_area id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_area ALTER COLUMN id SET DEFAULT nextval('public.defect_area_id_seq'::regclass);


--
-- Name: defect_area_visible_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_area_visible_groups ALTER COLUMN id SET DEFAULT nextval('public.defect_area_visible_groups_id_seq'::regclass);


--
-- Name: defect_defect id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect ALTER COLUMN id SET DEFAULT nextval('public.defect_defect_id_seq'::regclass);


--
-- Name: defect_defect_visible_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect_visible_groups ALTER COLUMN id SET DEFAULT nextval('public.defect_defect_visible_groups_id_seq'::regclass);


--
-- Name: defect_defectresolutionrating id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defectresolutionrating ALTER COLUMN id SET DEFAULT nextval('public.defect_defectresolutionrating_id_seq'::regclass);


--
-- Name: defect_defecttype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype ALTER COLUMN id SET DEFAULT nextval('public.defect_defecttype_id_seq'::regclass);


--
-- Name: defect_defecttype_areas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_areas ALTER COLUMN id SET DEFAULT nextval('public.defect_defecttype_areas_id_seq'::regclass);


--
-- Name: defect_defecttype_visible_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_visible_groups ALTER COLUMN id SET DEFAULT nextval('public.defect_defecttype_visible_groups_id_seq'::regclass);


--
-- Name: defect_reporteddefect id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_reporteddefect ALTER COLUMN id SET DEFAULT nextval('public.defect_reporteddefect_id_seq'::regclass);


--
-- Name: dit_push_notifications_pushnotifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dit_push_notifications_pushnotifications ALTER COLUMN id SET DEFAULT nextval('public.dit_push_notifications_pushnotifications_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: easy_thumbnails_source id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_source ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_source_id_seq'::regclass);


--
-- Name: easy_thumbnails_thumbnail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_thumbnail_id_seq'::regclass);


--
-- Name: easy_thumbnails_thumbnaildimensions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_thumbnaildimensions_id_seq'::regclass);


--
-- Name: gwg_tenant_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user ALTER COLUMN id SET DEFAULT nextval('public.gwg_tenant_user_id_seq'::regclass);


--
-- Name: gwg_tenant_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_groups ALTER COLUMN id SET DEFAULT nextval('public.gwg_tenant_user_groups_id_seq'::regclass);


--
-- Name: gwg_tenant_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.gwg_tenant_user_user_permissions_id_seq'::regclass);


--
-- Name: issues_issue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issue ALTER COLUMN id SET DEFAULT nextval('public.issues_issue_id_seq'::regclass);


--
-- Name: issues_issueanswer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issueanswer ALTER COLUMN id SET DEFAULT nextval('public.issues_issueanswer_id_seq'::regclass);


--
-- Name: issues_issuerequested id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issuerequested ALTER COLUMN id SET DEFAULT nextval('public.issues_issuerequested_id_seq'::regclass);


--
-- Name: push_notifications_apnsdevice id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_apnsdevice ALTER COLUMN id SET DEFAULT nextval('public.push_notifications_apnsdevice_id_seq'::regclass);


--
-- Name: push_notifications_gcmdevice id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_gcmdevice ALTER COLUMN id SET DEFAULT nextval('public.push_notifications_gcmdevice_id_seq'::regclass);


--
-- Name: push_notifications_webpushdevice id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_webpushdevice ALTER COLUMN id SET DEFAULT nextval('public.push_notifications_webpushdevice_id_seq'::regclass);


--
-- Name: push_notifications_wnsdevice id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_wnsdevice ALTER COLUMN id SET DEFAULT nextval('public.push_notifications_wnsdevice_id_seq'::regclass);


--
-- Name: real_estate_contract id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_contract ALTER COLUMN id SET DEFAULT nextval('public.real_estate_contract_id_seq'::regclass);


--
-- Name: real_estate_contract_partners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_contract_partners ALTER COLUMN id SET DEFAULT nextval('public.real_estate_contract_partners_id_seq'::regclass);


--
-- Name: survey_survey id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_survey ALTER COLUMN id SET DEFAULT nextval('public.survey_survey_id_seq'::regclass);


--
-- Name: survey_surveyanswerstext id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveyanswerstext ALTER COLUMN id SET DEFAULT nextval('public.survey_surveyanswerstext_id_seq'::regclass);


--
-- Name: survey_surveymembers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveymembers ALTER COLUMN id SET DEFAULT nextval('public.survey_surveymembers_id_seq'::regclass);


--
-- Name: survey_surveyquestion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveyquestion ALTER COLUMN id SET DEFAULT nextval('public.survey_surveyquestion_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
1	Mieter
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Token	6	add_token
22	Can change Token	6	change_token
23	Can delete Token	6	delete_token
24	Can view Token	6	view_token
25	Can add token	7	add_tokenproxy
26	Can change token	7	change_tokenproxy
27	Can delete token	7	delete_tokenproxy
28	Can view token	7	view_tokenproxy
29	Can add verification token	8	add_verificationtoken
30	Can change verification token	8	change_verificationtoken
31	Can delete verification token	8	delete_verificationtoken
32	Can view verification token	8	view_verificationtoken
33	Can add password reset token	9	add_passwordresettoken
34	Can change password reset token	9	change_passwordresettoken
35	Can delete password reset token	9	delete_passwordresettoken
36	Can view password reset token	9	view_passwordresettoken
37	Can add tenant	10	add_tenant
38	Can change tenant	10	change_tenant
39	Can delete tenant	10	delete_tenant
40	Can view tenant	10	view_tenant
41	Can add User	11	add_user
42	Can change User	11	change_user
43	Can delete User	11	delete_user
44	Can view User	11	view_user
45	Can add Neuigkeit	12	add_news
46	Can change Neuigkeit	12	change_news
47	Can delete Neuigkeit	12	delete_news
48	Can view Neuigkeit	12	view_news
49	Can add Objekt	13	add_property
50	Can change Objekt	13	change_property
51	Can delete Objekt	13	delete_property
52	Can view Objekt	13	view_property
53	Can add FAQ	14	add_faq
54	Can change FAQ	14	change_faq
55	Can delete FAQ	14	delete_faq
56	Can view FAQ	14	view_faq
57	Can add Vertrag	15	add_contract
58	Can change Vertrag	15	change_contract
59	Can delete Vertrag	15	delete_contract
60	Can view Vertrag	15	view_contract
61	Can add Umfrage	16	add_survey
62	Can change Umfrage	16	change_survey
63	Can delete Umfrage	16	delete_survey
64	Can view Umfrage	16	view_survey
65	Can add Umfrage Frage	17	add_surveyquestion
66	Can change Umfrage Frage	17	change_surveyquestion
67	Can delete Umfrage Frage	17	delete_surveyquestion
68	Can view Umfrage Frage	17	view_surveyquestion
69	Can add Umfragen Teilnehmer	18	add_surveymembers
70	Can change Umfragen Teilnehmer	18	change_surveymembers
71	Can delete Umfragen Teilnehmer	18	delete_surveymembers
72	Can view Umfragen Teilnehmer	18	view_surveymembers
73	Can add Umfrage Textantwort der Mieter	19	add_surveyanswerstext
74	Can change Umfrage Textantwort der Mieter	19	change_surveyanswerstext
75	Can delete Umfrage Textantwort der Mieter	19	delete_surveyanswerstext
76	Can view Umfrage Textantwort der Mieter	19	view_surveyanswerstext
77	Can add Chat Session	20	add_session
78	Can change Chat Session	20	change_session
79	Can delete Chat Session	20	delete_session
80	Can view Chat Session	20	view_session
81	Can add site	21	add_site
82	Can change site	21	change_site
83	Can delete site	21	delete_site
84	Can view site	21	view_site
85	Can add Formular PDF	22	add_issue
86	Can change Formular PDF	22	change_issue
87	Can delete Formular PDF	22	delete_issue
88	Can view Formular PDF	22	view_issue
89	Can add Angefordertes Formular	23	add_issuerequested
90	Can change Angefordertes Formular	23	change_issuerequested
91	Can delete Angefordertes Formular	23	delete_issuerequested
92	Can view Angefordertes Formular	23	view_issuerequested
93	Can add Formular Antworten	24	add_issueanswer
94	Can change Formular Antworten	24	change_issueanswer
95	Can delete Formular Antworten	24	delete_issueanswer
96	Can view Formular Antworten	24	view_issueanswer
97	Can add APNS device	25	add_apnsdevice
98	Can change APNS device	25	change_apnsdevice
99	Can delete APNS device	25	delete_apnsdevice
100	Can view APNS device	25	view_apnsdevice
101	Can add GCM device	26	add_gcmdevice
102	Can change GCM device	26	change_gcmdevice
103	Can delete GCM device	26	delete_gcmdevice
104	Can view GCM device	26	view_gcmdevice
105	Can add WNS device	27	add_wnsdevice
106	Can change WNS device	27	change_wnsdevice
107	Can delete WNS device	27	delete_wnsdevice
108	Can view WNS device	27	view_wnsdevice
109	Can add WebPush device	28	add_webpushdevice
110	Can change WebPush device	28	change_webpushdevice
111	Can delete WebPush device	28	delete_webpushdevice
112	Can view WebPush device	28	view_webpushdevice
113	Can add Angebot	29	add_offer
114	Can change Angebot	29	change_offer
115	Can delete Angebot	29	delete_offer
116	Can view Angebot	29	view_offer
117	Can add page	30	add_page
118	Can change page	30	change_page
119	Can delete page	30	delete_page
120	Can view page	30	view_page
121	Can add Push-Nachricht	31	add_pushnotifications
122	Can change Push-Nachricht	31	change_pushnotifications
123	Can delete Push-Nachricht	31	delete_pushnotifications
124	Can view Push-Nachricht	31	view_pushnotifications
125	Can add Raum	32	add_area
126	Can change Raum	32	change_area
127	Can delete Raum	32	delete_area
128	Can view Raum	32	view_area
129	Can add Defect	33	add_defect
130	Can change Defect	33	change_defect
131	Can delete Defect	33	delete_defect
132	Can view Defect	33	view_defect
133	Can add Defect resolution rating	34	add_defectresolutionrating
134	Can change Defect resolution rating	34	change_defectresolutionrating
135	Can delete Defect resolution rating	34	delete_defectresolutionrating
136	Can view Defect resolution rating	34	view_defectresolutionrating
137	Can add Defect type	35	add_defecttype
138	Can change Defect type	35	change_defecttype
139	Can delete Defect type	35	delete_defecttype
140	Can view Defect type	35	view_defecttype
141	Can add Reported defect	36	add_reporteddefect
142	Can change Reported defect	36	change_reporteddefect
143	Can delete Reported defect	36	delete_reporteddefect
144	Can view Reported defect	36	view_reporteddefect
145	Can add source	37	add_source
146	Can change source	37	change_source
147	Can delete source	37	delete_source
148	Can view source	37	view_source
149	Can add thumbnail	38	add_thumbnail
150	Can change thumbnail	38	change_thumbnail
151	Can delete thumbnail	38	delete_thumbnail
152	Can view thumbnail	38	view_thumbnail
153	Can add thumbnail dimensions	39	add_thumbnaildimensions
154	Can change thumbnail dimensions	39	change_thumbnaildimensions
155	Can delete thumbnail dimensions	39	delete_thumbnaildimensions
156	Can view thumbnail dimensions	39	view_thumbnaildimensions
157	Can add invitation token	40	add_invitationtoken
158	Can change invitation token	40	change_invitationtoken
159	Can delete invitation token	40	delete_invitationtoken
160	Can view invitation token	40	view_invitationtoken
\.


--
-- Data for Name: authentication_local_invitationtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_local_invitationtoken (token, created_at, contract_id, principal_id, target_email, user_id) FROM stdin;
\.


--
-- Data for Name: authentication_local_passwordresettoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_local_passwordresettoken (token, created_at, user_id) FROM stdin;
4182db912a0ee7d1c88b42329d367e39322d2bb3	2021-07-12 00:00:00+00	7
\.


--
-- Data for Name: authentication_local_verificationtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_local_verificationtoken (token, created_at, user_id) FROM stdin;
380ce0144993661b394a51034bd2fe95fdc83e8f	2020-12-23 16:51:56.134311+00	7
7dad4d74787c60456139cf0e540988ed0daec0ce	2021-01-13 16:24:42.616062+00	9
fab4cf2b1428ec6560ecde518204c881cc339cda	2021-01-27 09:10:44.594869+00	21
41e21a7d327a12204a4eb63a5ce9e0c9bc7f6d1c	2021-01-27 09:12:34.744385+00	22
f9babc2a11dafbcc623c0802e2d710141b74ec19	2021-02-04 13:26:20.175156+00	25
3e14bc7b6c8cb8fc43f40c6125763642d2d66bfb	2021-02-12 09:31:16.708428+00	28
1155065a45d79d0f68216e4b3022cf1c38abe9c8	2021-02-16 18:01:15.697997+00	32
75794899430ca3f2a70e265f82bf62f21558c0cc	2021-02-16 22:08:50.29215+00	37
a62d3b5b63b2746857c8abab61a48366aec7398f	2021-04-27 10:46:48.048428+00	38
83267e5f117a7ccf76834b04ad8db5f2a786a8a4	2021-04-27 12:52:29.472384+00	39
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
\.


--
-- Data for Name: chat_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_session (id, is_customer_session, code) FROM stdin;
2	t	64-201223-Q0002
6	t	64-210128-Q0001
7	t	64-210201-Q0006
8	t	64-210211-Q0007
9	t	64-210216-Q0005
\.


--
-- Data for Name: content_faq; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_faq (id, title, text, href, "group", sorting, visible_object, visible_role_id) FROM stdin;
1	Wie gehe ich vor, wenn sich meine Kontaktdaten geändert haben?	Sollten sich Ihre Adresse, Ihr Name oder Ihre Telefonnummer geändert haben, so wählen Sie bitte das richtige Formular aus und übersenden uns dieses mit Ihrer Unterschrift an die für Sie zuständige Geschäftsstelle. Die zuständige Geschäftsstelle finden Sie auf allen Schriftstücken, die Sie von uns erhalten haben.	\N	Mieter	10	\N	\N
3	Darf ich Haustiere in meiner Wohnung halten?	Kleintiere dürfen ohne Genehmigung des Vermieters gehalten werden. Für die Haltung von Hunden oder Katzen bedarf es einer schriftlichen Genehmigung. Bitte kontaktieren Sie diesbezüglich Ihre/-n Kundenbetreuer/-in.	\N	Mieter	10	\N	\N
4	Kann ich bei der GWG-Gruppe auch Garagen oder Stellplätze für mein Auto mieten?	Als Wohnungsmieter/-in bei der GWG-Gruppe können Sie sich gerne über mögliche Stellplatzangebote bei Ihrem/Ihrer Kundenbetreuer/-in erkundigen. Als externer Bewerber finden Sie zudem all unsere freien Stellplatz- und Garagenangebote auf unserer Homepage: Mietobjekte.	\N	Mieter	10	\N	\N
5	Wie gehe ich vor, wenn sich meine Kontaktdaten geändert haben?	Sollten sich Ihre Adresse, Ihr Name oder Ihre Telefonnummer geändert haben, so wählen Sie bitte das richtige Formular aus und übersenden uns dieses mit Ihrer Unterschrift an die für Sie zuständige Geschäftsstelle. Die zuständige Geschäftsstelle finden Sie auf allen Schriftstücken, die Sie von uns erhalten haben.	\N	Mieter	10	\N	\N
6	Test DIT	TEST	\N	\N	10	\N	\N
10	Test NEU	Test Feb 22	\N	\N	10	\N	\N
9	Test VPN	Test VPN	\N	Mieter	99999999	\N	\N
\.


--
-- Data for Name: content_news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_news (id, title, text, document, href, kind, show_in_header, date_from, date_to, "order", documents) FROM stdin;
3	GWG UNTERSTÜTZT CORONA-HELDEN MIT 70.000 EUR	30.000 Euro gehen an Einrichtungen am Hauptsitz Stuttgart, 40.000 Euro an die bundesweiten Standorte		\N	1	f	\N	\N	0	\N
4	Test Header	Ich bin ein Test Header		\N	1	t	\N	\N	0	\N
9	FS test	Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.		\N	2	f	\N	\N	0	\N
11	Test 2021 NEWS	NEWS NEWS \r\n\r\nneu		\N	1	t	\N	\N	40	\N
2	GWG-GRUPPE TREIBT DIGITALISIERUNG VORAN	Die GWG-Gruppe treibt die Digitalisierung ihrer bundesweit rund 15.000 Wohn- und Gewerbeeinheiten sowie zentraler interner Prozesse mit großen Schritten voran.		https://gwg-gruppe.de/unternehmen/presse/detail/gwg-gruppe-treibt-digitalisierung-voran	1	f	\N	\N	20	\N
1	Willkommen in der Mieter-App der GWG	Machen Sie es sich leicht mit der - mit der kostenlosen GWG Mieter-App haben Sie rund um die Uhr alles im Griff, was sich um Ihre Wohnung dreht.		\N	1	t	\N	\N	10	\N
12	Test 2021 212	Test Text 1345	news-documents/c376b19b5ee208670f2a99ddc6324938_20210129.jpg	\N	1	t	\N	\N	11	\N
13	Test mit Bild	Test mit Bild	news-documents/testumfrage1_20210210.png	\N	1	t	\N	\N	50	\N
10	Neuigkeiten Test	Neuigkeiten Test - sollte nicht im Header erscheinen		\N	1	f	\N	\N	44	\N
8	TEST123	TEST123	news-documents/examplepic_20210211.jpg	\N	1	t	\N	\N	0	\N
6	Test Header	Ich bin ein Header.	news-documents/examplepic_20210211_2iOZrmZ.jpg	\N	1	f	\N	\N	0	\N
\.


--
-- Data for Name: content_news_property; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_news_property (id, news_id, property_id) FROM stdin;
\.


--
-- Data for Name: content_offer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_offer (id, title, text, icon, website, hidden, only_login, only_guest, report_clickes, sorting, date_from, date_to, visible_role_id, icons) FROM stdin;
1	asdf	asdf	marketplace/5596f02549da444998ba43cab7d682ca.png	asdf	f	t	t	0	0	\N	\N	1	\N
2	Test Mieter	asdf	marketplace/bf902c8b3ac6458db9d7b41ee67a81f7.png	asdf	f	t	t	0	1	2021-01-01	2021-01-31	1	\N
3	Angebote Test Title	Angebot Test Text 123	marketplace/b2a963603409401983c6d393869e5052.png	www.google.de	f	t	t	0	55	\N	\N	\N	\N
4	Test Angebot 2021	Test 2021 Text1		www.google.com	f	t	t	0	0	\N	\N	\N	\N
\.


--
-- Data for Name: content_page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_page (id, slug, html) FROM stdin;
1	impressum	<html><body><h1>Please Change Me</h1></body></html>
2	datenschutz	<html><body><h1>Please Change Me</h1></body></html>
\.


--
-- Data for Name: defect_area; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_area (id, name, name_af, name_ar, name_ar_dz, name_ast, name_az, name_bg, name_be, name_bn, name_br, name_bs, name_ca, name_cs, name_cy, name_da, name_de, name_dsb, name_el, name_en, name_en_au, name_en_gb, name_eo, name_es, name_es_ar, name_es_co, name_es_mx, name_es_ni, name_es_ve, name_et, name_eu, name_fa, name_fi, name_fr, name_fy, name_ga, name_gd, name_gl, name_he, name_hi, name_hr, name_hsb, name_hu, name_hy, name_ia, name_ind, name_ig, name_io, name_is, name_it, name_ja, name_ka, name_kab, name_kk, name_km, name_kn, name_ko, name_ky, name_lb, name_lt, name_lv, name_mk, name_ml, name_mn, name_mr, name_my, name_nb, name_ne, name_nl, name_nn, name_os, name_pa, name_pl, name_pt, name_pt_br, name_ro, name_ru, name_sk, name_sl, name_sq, name_sr, name_sr_latn, name_sv, name_sw, name_ta, name_te, name_tg, name_th, name_tk, name_tr, name_tt, name_udm, name_uk, name_ur, name_uz, name_vi, name_zh_hans, name_zh_hant, sorting) FROM stdin;
\.


--
-- Data for Name: defect_area_visible_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_area_visible_groups (id, area_id, group_id) FROM stdin;
\.


--
-- Data for Name: defect_defect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_defect (id, name, name_af, name_ar, name_ar_dz, name_ast, name_az, name_bg, name_be, name_bn, name_br, name_bs, name_ca, name_cs, name_cy, name_da, name_de, name_dsb, name_el, name_en, name_en_au, name_en_gb, name_eo, name_es, name_es_ar, name_es_co, name_es_mx, name_es_ni, name_es_ve, name_et, name_eu, name_fa, name_fi, name_fr, name_fy, name_ga, name_gd, name_gl, name_he, name_hi, name_hr, name_hsb, name_hu, name_hy, name_ia, name_ind, name_ig, name_io, name_is, name_it, name_ja, name_ka, name_kab, name_kk, name_km, name_kn, name_ko, name_ky, name_lb, name_lt, name_lv, name_mk, name_ml, name_mn, name_mr, name_my, name_nb, name_ne, name_nl, name_nn, name_os, name_pa, name_pl, name_pt, name_pt_br, name_ro, name_ru, name_sk, name_sl, name_sq, name_sr, name_sr_latn, name_sv, name_sw, name_ta, name_te, name_tg, name_th, name_tk, name_tr, name_tt, name_udm, name_uk, name_ur, name_uz, name_vi, name_zh_hans, name_zh_hant, show_emergency_alert, is_image_required, area_id, defect_type_id) FROM stdin;
\.


--
-- Data for Name: defect_defect_visible_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_defect_visible_groups (id, defect_id, group_id) FROM stdin;
\.


--
-- Data for Name: defect_defectresolutionrating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_defectresolutionrating (id, created_at, is_defect_resolved, craftsman_rating, reported_defect_id) FROM stdin;
\.


--
-- Data for Name: defect_defecttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_defecttype (id, name, name_af, name_ar, name_ar_dz, name_ast, name_az, name_bg, name_be, name_bn, name_br, name_bs, name_ca, name_cs, name_cy, name_da, name_de, name_dsb, name_el, name_en, name_en_au, name_en_gb, name_eo, name_es, name_es_ar, name_es_co, name_es_mx, name_es_ni, name_es_ve, name_et, name_eu, name_fa, name_fi, name_fr, name_fy, name_ga, name_gd, name_gl, name_he, name_hi, name_hr, name_hsb, name_hu, name_hy, name_ia, name_ind, name_ig, name_io, name_is, name_it, name_ja, name_ka, name_kab, name_kk, name_km, name_kn, name_ko, name_ky, name_lb, name_lt, name_lv, name_mk, name_ml, name_mn, name_mr, name_my, name_nb, name_ne, name_nl, name_nn, name_os, name_pa, name_pl, name_pt, name_pt_br, name_ro, name_ru, name_sk, name_sl, name_sq, name_sr, name_sr_latn, name_sv, name_sw, name_ta, name_te, name_tg, name_th, name_tk, name_tr, name_tt, name_udm, name_uk, name_ur, name_uz, name_vi, name_zh_hans, name_zh_hant, description, description_af, description_ar, description_ar_dz, description_ast, description_az, description_bg, description_be, description_bn, description_br, description_bs, description_ca, description_cs, description_cy, description_da, description_de, description_dsb, description_el, description_en, description_en_au, description_en_gb, description_eo, description_es, description_es_ar, description_es_co, description_es_mx, description_es_ni, description_es_ve, description_et, description_eu, description_fa, description_fi, description_fr, description_fy, description_ga, description_gd, description_gl, description_he, description_hi, description_hr, description_hsb, description_hu, description_hy, description_ia, description_ind, description_ig, description_io, description_is, description_it, description_ja, description_ka, description_kab, description_kk, description_km, description_kn, description_ko, description_ky, description_lb, description_lt, description_lv, description_mk, description_ml, description_mn, description_mr, description_my, description_nb, description_ne, description_nl, description_nn, description_os, description_pa, description_pl, description_pt, description_pt_br, description_ro, description_ru, description_sk, description_sl, description_sq, description_sr, description_sr_latn, description_sv, description_sw, description_ta, description_te, description_tg, description_th, description_tk, description_tr, description_tt, description_udm, description_uk, description_ur, description_uz, description_vi, description_zh_hans, description_zh_hant, sorting) FROM stdin;
\.


--
-- Data for Name: defect_defecttype_areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_defecttype_areas (id, defecttype_id, area_id) FROM stdin;
\.


--
-- Data for Name: defect_defecttype_visible_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_defecttype_visible_groups (id, defecttype_id, group_id) FROM stdin;
\.


--
-- Data for Name: defect_reporteddefect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect_reporteddefect (id, created_at, updated_at, status, description, image_1, image_2, contract_id, defect_id, reported_by_id) FROM stdin;
\.


--
-- Data for Name: dit_push_notifications_pushnotifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dit_push_notifications_pushnotifications (id, title, message, created_at) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-12-07 14:34:13.767468+00	2	a@b.cd	2	[{"changed": {"fields": ["Verified"]}}]	11	1
2	2020-12-17 08:48:07.071713+00	3	philipp@litzenberger.engineering	3		11	1
3	2020-12-17 11:08:19.647235+00	4	philipp@litzenberger.engineering	3		11	1
4	2020-12-23 16:58:10.596322+00	5	philipp@litzenberger.engineering	3		11	1
5	2020-12-23 17:00:44.55682+00	7	f_stop@gmx.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
6	2020-12-23 17:39:39.19789+00	1	Session object (1)	3		20	1
7	2020-12-23 18:53:31.768296+00	1	Willkommen in der Mieter-App der GWG	1	[{"added": {}}]	12	1
8	2020-12-23 18:54:08.55178+00	2	GWG-GRUPPE TREIBT DIGITALISIERUNG VORAN	1	[{"added": {}}]	12	1
9	2020-12-23 18:54:55.762679+00	3	GWG UNTERSTÜTZT CORONA-HELDEN MIT 70.000 EUR	1	[{"added": {}}]	12	1
10	2020-12-23 18:55:23.684023+00	3	GWG UNTERSTÜTZT CORONA-HELDEN MIT 70.000 EUR	2	[{"changed": {"fields": ["Im Header anzeigen"]}}]	12	1
11	2020-12-23 18:56:24.823083+00	1	1 Mieter Wie gehe ich vor, wenn sich meine Kontaktdaten geändert haben?	1	[{"added": {}}]	14	1
12	2020-12-23 18:57:00.051412+00	3	3 Mieter Darf ich Haustiere in meiner Wohnung halten?	1	[{"added": {}}]	14	1
13	2020-12-23 18:57:17.158217+00	4	4 Mieter Kann ich bei der GWG-Gruppe auch Garagen oder Stellplätze für mein Auto mieten?	1	[{"added": {}}]	14	1
14	2020-12-23 18:57:36.948109+00	5	5 Mieter Wie gehe ich vor, wenn sich meine Kontaktdaten geändert haben?	1	[{"added": {}}]	14	1
15	2020-12-23 19:33:44.454053+00	2	GWG-GRUPPE TREIBT DIGITALISIERUNG VORAN	2	[{"changed": {"fields": ["Order"]}}]	12	1
16	2021-01-06 08:21:20.706003+00	1	IssueRequested object (1)	1	[{"added": {}}]	23	1
17	2021-01-09 00:12:51.481349+00	9	IssueAnswer object (9)	2	[{"changed": {"fields": ["Typ", "Markierung in der HTML Vorlage"]}}]	24	1
18	2021-01-09 00:19:28.15807+00	8	IssueAnswer object (8)	2	[{"changed": {"fields": ["Typ", "Markierung in der HTML Vorlage"]}}]	24	1
19	2021-01-12 15:50:12.13279+00	4	Test Header	1	[{"added": {}}]	12	1
20	2021-01-12 16:03:23.091987+00	5	Test Header	1	[{"added": {}}]	12	1
21	2021-01-12 16:04:51.913547+00	6	Test Header	1	[{"added": {}}]	12	1
22	2021-01-12 16:08:14.029969+00	6	Test Header	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
23	2021-01-12 16:42:16.74774+00	6	Test Header	2	[{"changed": {"fields": ["Im Header anzeigen"]}}]	12	1
24	2021-01-13 08:57:44.735151+00	8	IssueAnswer object (8)	2	[{"changed": {"fields": ["Typ"]}}]	24	1
25	2021-01-13 09:03:03.246512+00	6	W Genehmigung Untermieter	2	[{"changed": {"fields": ["Beschreibung"]}}]	22	1
26	2021-01-13 12:36:10.902222+00	6	6 None Test DIT	1	[{"added": {}}]	14	1
27	2021-01-13 13:03:38.278124+00	7	TEST	1	[{"added": {}}]	12	1
28	2021-01-13 13:06:04.833727+00	7	TEST	2	[]	12	1
29	2021-01-13 13:13:46.035384+00	8	TEST123	1	[{"added": {}}]	12	1
30	2021-01-14 09:08:48.507498+00	9	FS test	1	[{"added": {}}]	12	1
31	2021-01-14 15:24:40.039437+00	9	FS test	2	[{"changed": {"fields": ["Text"]}}]	12	1
32	2021-01-14 21:36:47.74309+00	6	W Genehmigung Untermieter	2	[{"changed": {"fields": ["Meldungsart"]}}]	22	1
33	2021-01-15 10:36:39.272384+00	8	philipp@litzenberger.engineering	3		11	1
34	2021-01-15 10:37:31.105129+00	2	a@b.cd	3		11	1
35	2021-01-19 14:11:57.075661+00	6	mail@stopienski.de	3		11	1
36	2021-01-19 15:21:31.914168+00	11	mail@stopienski.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
37	2021-01-19 16:15:05.299289+00	12	f.stopienski@gmx.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
38	2021-01-19 16:21:59.787791+00	8	Contract object (8)	2	[{"changed": {"fields": ["Partners"]}}]	15	1
39	2021-01-20 07:22:16.109294+00	16	WEG Schlüssel- / Zylinderbestellung	3		22	1
40	2021-01-20 07:22:16.117233+00	15	W Wohnungsgeberbestätigung	3		22	1
41	2021-01-20 07:22:16.119659+00	14	W Vorauszahlung anpassen	3		22	1
42	2021-01-20 07:22:16.122084+00	13	W Schlüssel- / Zylinderbestellung	3		22	1
43	2021-01-20 07:22:16.124445+00	12	W Ratenzahlungsvereinbarung	3		22	1
44	2021-01-20 07:22:16.126877+00	11	W Person in Mietvertrag aufnehmen	3		22	1
45	2021-01-20 07:22:16.129272+00	10	W Neue Bankverbindung / Änderung Bankverbindung	3		22	1
46	2021-01-20 07:22:16.131426+00	9	W Nachmieter	3		22	1
47	2021-01-20 07:22:16.13352+00	8	W Katzengenehmigung	3		22	1
48	2021-01-20 07:22:16.135641+00	7	W Hundgenehmigung	3		22	1
49	2021-01-20 07:22:16.137885+00	6	W Genehmigung Untermieter	3		22	1
50	2021-01-20 07:22:16.139937+00	5	W Genehmigung Kleintier	3		22	1
51	2021-01-20 07:22:16.142017+00	4	W Auszahlung Guthaben	3		22	1
52	2021-01-20 07:22:16.144147+00	3	W Anforderung Mietbescheinigung	3		22	1
53	2021-01-20 07:22:16.146173+00	2	Test Infoticket	3		22	1
54	2021-01-20 07:22:16.148206+00	1	TEST - Info	3		22	1
55	2021-01-20 16:42:06.405314+00	13	Andreas.laub@diimt.de	1	[{"added": {}}]	11	1
56	2021-01-20 20:29:04.808714+00	1	Apple iPhone 6+	3		25	1
57	2021-01-20 20:54:39.950016+00	1	Offer object (1)	1	[{"added": {}}]	29	1
58	2021-01-22 10:12:13.202875+00	6909d238328300a8ec16ccf0a4021ca937cfd191	6909d238328300a8ec16ccf0a4021ca937cfd191	3		8	1
59	2021-01-22 10:13:52.346821+00	10	philipp@litzenberger.engineering	3		11	1
60	2021-01-22 15:17:36.835967+00	14	philipp@litzenberger.engineering	3		11	1
61	2021-01-22 15:35:47.240563+00	2	Offer object (2)	1	[{"added": {}}]	29	1
62	2021-01-22 15:42:05.807889+00	12	f.stopienski@gmx.de	3		11	1
63	2021-01-22 15:45:06.177207+00	16	f.stopienski@gmx.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
64	2021-01-22 19:08:24.253116+00	1	Offer object (1)	2	[{"changed": {"fields": ["Visible role"]}}]	29	1
65	2021-01-23 10:22:19.74055+00	1	Offer object (1)	2	[{"changed": {"fields": ["Icon"]}}]	29	1
66	2021-01-25 09:24:37.05613+00	7	7 None Test FAQ Titel	1	[{"added": {}}]	14	1
67	2021-01-25 09:30:24.992269+00	7	7 Mieter Test FAQ Titel	2	[{"changed": {"fields": ["Gruppe"]}}]	14	1
68	2021-01-25 09:38:36.445696+00	10	Neuigkeiten Test	1	[{"added": {}}]	12	1
69	2021-01-25 18:16:56.580604+00	7	7 Mieter Test FAQ Titel	2	[{"changed": {"fields": ["Sortierung?"]}}]	14	1
70	2021-01-25 18:30:35.305436+00	17	clarissa.jass@dit-digital.de	1	[{"added": {}}]	11	1
71	2021-01-25 18:35:33.193549+00	43	WEG Schlüssel- / Zylinderbestellung	3		22	1
72	2021-01-25 18:35:33.198968+00	42	Wohnungsgeberbestätigung	3		22	1
73	2021-01-25 18:35:33.201434+00	41	Anpassung Vorauszahlung	3		22	1
74	2021-01-25 18:35:33.203939+00	40	Schlüssel- /Zylinderbestellung	3		22	1
75	2021-01-25 18:35:33.20631+00	39	Ratenzahlungsvereinbarung	3		22	1
76	2021-01-25 18:35:33.208631+00	38	Änderung Stammdaten	3		22	1
77	2021-01-25 18:35:33.211018+00	37	Bankverbindung	3		22	1
78	2021-01-25 18:35:33.213069+00	36	Vorschlag Nachmieter	3		22	1
79	2021-01-25 18:35:33.215181+00	35	Genehmigung	3		22	1
80	2021-01-25 18:35:33.217241+00	34	Genehmigung	3		22	1
81	2021-01-25 18:35:33.219464+00	33	Genehmigung	3		22	1
82	2021-01-25 18:35:33.222877+00	32	Genehmigung	3		22	1
83	2021-01-25 18:35:33.225138+00	31	Auszahlung Guthaben	3		22	1
84	2021-01-25 18:35:33.227429+00	30	Allgemeine Auskünfte	3		22	1
85	2021-01-25 20:37:25.396382+00	6	Test Header	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
86	2021-01-26 00:06:34.723236+00	11	Florians iPhone	3		25	1
87	2021-01-26 00:06:34.729192+00	10	Florians iPhone	3		25	1
88	2021-01-26 00:06:34.731858+00	9	Florians iPhone	3		25	1
89	2021-01-26 00:06:34.734299+00	8	Florians iPhone	3		25	1
90	2021-01-26 00:06:34.73671+00	7	Florians iPhone	3		25	1
91	2021-01-26 00:06:34.739159+00	6	Florians iPhone	3		25	1
92	2021-01-26 00:06:34.741683+00	5	Florians iPhone	3		25	1
93	2021-01-26 00:20:25.504376+00	16	f.stopienski@gmx.de	2	[{"changed": {"fields": ["Staff status"]}}]	11	1
94	2021-01-26 00:21:35.118036+00	16	f.stopienski@gmx.de	2	[{"changed": {"fields": ["User permissions"]}}]	11	1
95	2021-01-26 09:16:40.643609+00	3	Offer object (3)	1	[{"added": {}}]	29	1
96	2021-01-26 09:40:56.650034+00	4	Offer object (4)	1	[{"added": {}}]	29	1
97	2021-01-26 09:41:58.687865+00	8	8 None Test FAQ 2021	1	[{"added": {}}]	14	1
98	2021-01-26 09:49:05.619393+00	11	Test 2021 NEWS	1	[{"added": {}}]	12	1
99	2021-01-26 11:24:59.235111+00	8	TEST123	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
100	2021-01-26 11:25:47.294576+00	8	TEST123	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
101	2021-01-26 11:28:18.619367+00	12	Test 2021 212	1	[{"added": {}}]	12	1
102	2021-01-26 11:53:14.918435+00	9	teute@equity-seven.de	2	[{"changed": {"fields": ["Pers\\u00f6nliche Haupt-Identifikationsnummer"]}}]	11	1
103	2021-01-26 12:08:42.185236+00	15	philipp@litzenberger.engineering	2	[{"changed": {"fields": ["Pers\\u00f6nliche Haupt-Identifikationsnummer"]}}]	11	1
104	2021-01-26 12:10:17.057003+00	12	Florians iPhone	2	[{"changed": {"fields": ["Application ID"]}}]	25	1
105	2021-01-26 19:51:39.975745+00	18	f.stopienski@gmx.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
106	2021-01-26 19:54:48.913641+00	19	f.stopienski@gmx.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
107	2021-01-26 19:58:04.473195+00	20	f.stopienski@gmx.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
108	2021-01-27 09:13:26.666946+00	21	Christoph.Dahlmann@gwg-gruppe.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
109	2021-01-27 09:13:45.588216+00	22	Karen.Raschke@gwg-gruppe.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
110	2021-01-27 11:26:01.672251+00	21	christoph.dahlmann@gwg-gruppe.de	2	[{"changed": {"fields": ["Email address"]}}]	11	1
111	2021-01-27 11:26:56.657097+00	22	karen.raschke@gwg-gruppe.de	2	[{"changed": {"fields": ["Email address"]}}]	11	1
112	2021-01-27 16:23:52.694902+00	23	oliver.schrey@dit-digital.de	1	[{"added": {}}]	11	1
113	2021-01-27 16:26:10.026214+00	23	oliver.schrey@dit-digital.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
114	2021-01-27 16:37:37.923922+00	23	oliver.schrey@dit-digital.de	3		11	1
115	2021-01-27 23:51:22.452546+00	7	f_stop@gmx.de	2	[]	11	1
116	2021-01-29 09:31:48.105182+00	12	Test 2021 212	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
117	2021-01-29 09:32:19.406426+00	12	Test 2021 212	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
118	2021-01-29 09:33:41.389967+00	2	Offer object (2)	2	[{"changed": {"fields": ["Icon"]}}]	29	1
119	2021-01-29 09:37:58.060734+00	2	Offer object (2)	2	[{"changed": {"fields": ["Icon"]}}]	29	1
120	2021-01-29 09:39:19.243249+00	2	Offer object (2)	2	[{"changed": {"fields": ["Icon"]}}]	29	1
121	2021-01-29 09:41:28.558383+00	2	Offer object (2)	2	[{"changed": {"fields": ["Icon"]}}]	29	1
122	2021-01-29 09:47:23.704111+00	2	Offer object (2)	2	[{"changed": {"fields": ["Icon"]}}]	29	1
123	2021-01-29 09:47:59.166657+00	3	Offer object (3)	2	[{"changed": {"fields": ["Icon"]}}]	29	1
124	2021-01-29 09:48:19.495505+00	12	Test 2021 212	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
125	2021-01-29 09:48:52.746524+00	8	8 None Test FAQ 2021	2	[{"changed": {"fields": ["URL"]}}]	14	1
126	2021-01-29 09:49:48.729674+00	8	8 None Test FAQ 2021	2	[{"changed": {"fields": ["Visible role"]}}]	14	1
127	2021-02-01 16:21:51.216338+00	24	karen.raschke@gwg-gruppe.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
128	2021-02-04 13:27:09.000984+00	25	karen.raschke@gwg-gruppe.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
129	2021-02-05 12:55:56.897548+00	26	Andreas.laub@dit-digital.de	1	[{"added": {}}]	11	1
130	2021-02-05 17:26:59.028719+00	2	GWG-GRUPPE TREIBT DIGITALISIERUNG VORAN	2	[{"changed": {"fields": ["Order"]}}]	12	1
131	2021-02-05 17:27:14.60087+00	1	Willkommen in der Mieter-App der GWG	2	[{"changed": {"fields": ["Order"]}}]	12	1
132	2021-02-05 17:27:28.407788+00	10	Neuigkeiten Test	2	[{"changed": {"fields": ["Order"]}}]	12	1
133	2021-02-05 17:27:55.449707+00	5	Test Header	3		12	1
134	2021-02-05 17:28:07.384927+00	7	TEST	3		12	1
135	2021-02-05 17:29:28.056819+00	12	Test 2021 212	2	[{"changed": {"fields": ["Order"]}}]	12	1
136	2021-02-05 17:56:36.195898+00	29	Abbuchung Miete fehlerhaft	3		22	1
137	2021-02-05 17:56:43.644428+00	28	Corona	3		22	1
138	2021-02-10 14:42:30.656859+00	13	Test mit Bild	1	[{"added": {}}]	12	1
139	2021-02-10 14:53:29.815298+00	13	Test mit Bild	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
140	2021-02-10 14:54:55.737465+00	8	TEST123	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
141	2021-02-10 14:55:05.562251+00	6	Test Header	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
142	2021-02-10 14:55:24.529041+00	10	Neuigkeiten Test	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
143	2021-02-11 08:28:06.283257+00	8	TEST123	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
144	2021-02-11 08:30:45.493098+00	6	Test Header	2	[{"changed": {"fields": ["Dokument"]}}]	12	1
145	2021-02-12 09:32:08.23558+00	28	test@gwg-gruppe.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
146	2021-02-12 12:10:01.807741+00	46	Nebenkostenabrechnung erstellen	3		22	1
147	2021-02-12 12:10:01.815217+00	45	Genehmigung	3		22	1
148	2021-02-12 12:10:01.817684+00	44	Mieter App: Einsicht Mietvertrag	3		22	1
149	2021-02-12 12:10:01.820101+00	27	Bankverbindung	3		22	1
150	2021-02-12 12:10:01.822373+00	26	Vorschlag Nachmieter	3		22	1
151	2021-02-12 12:10:01.824589+00	25	Schlüssel- /Zylinderbestellung	3		22	1
152	2021-02-12 12:10:01.827029+00	24	Genehmigung	3		22	1
153	2021-02-12 12:10:01.829067+00	23	Genehmigung	3		22	1
154	2021-02-12 12:10:01.8312+00	22	Ratenzahlungsvereinbarung	3		22	1
155	2021-02-12 12:10:01.833457+00	21	Auszahlung Guthaben	3		22	1
156	2021-02-12 12:10:01.83596+00	20	Änderung Stammdaten	3		22	1
157	2021-02-12 12:10:01.838119+00	19	Anpassung Vorauszahlung	3		22	1
158	2021-02-12 12:10:01.840211+00	18	Wohnungsgeberbestätigung	3		22	1
159	2021-02-12 12:10:01.842362+00	17	Allgemeine Auskünfte	3		22	1
160	2021-02-16 16:08:22.343516+00	29	f.stopienski@gmx.de	3		11	1
161	2021-02-16 16:19:07.964233+00	30	f.stopienski@gmx.de	2	[{"changed": {"fields": ["Verified"]}}]	11	1
162	2021-02-16 16:33:58.847931+00	30	f.stopienski@gmx.de	3		11	1
163	2021-02-16 21:47:09.65446+00	31	f.stopienski@gmx.de	3		11	1
164	2021-02-16 21:53:43.532877+00	33	f.stopienski@gmx.de	3		11	1
165	2021-02-16 21:58:06.545213+00	34	f.stopienski@gmx.de	3		11	1
166	2021-02-16 22:06:10.019771+00	35	f.stopienski@gmx.de	3		11	1
167	2021-02-16 22:07:58.389546+00	36	f.stopienski@gmx.de	3		11	1
168	2021-02-17 08:54:16.363465+00	60	Nebenkostenabrechnung erstellen	3		22	1
169	2021-02-17 08:54:26.736424+00	59	Genehmigung	3		22	1
170	2021-02-17 09:33:26.481946+00	1000.99999.0001.01	Tenant object (1000.99999.0001.01)	2	[{"changed": {"fields": ["Nachname", "Vorname"]}}]	10	1
171	2021-02-18 14:53:57.553199+00	8	8 None Test FAQ 2021	3		14	27
172	2021-02-18 14:53:57.559013+00	7	7 Mieter Test FAQ Titel	3		14	27
173	2021-02-19 08:30:22.053989+00	14	TEST	1	[{"added": {}}]	12	1
174	2021-02-19 08:31:11.499566+00	14	TEST	3		12	1
175	2021-02-19 08:33:37.45841+00	15	TEST	1	[{"added": {}}]	12	1
176	2021-02-19 08:35:29.491978+00	15	TEST	3		12	1
177	2021-02-22 12:55:32.103075+00	9	9 None Test VPN	1	[{"added": {}}]	14	27
178	2021-02-22 12:56:36.185578+00	10	10 None Test NEU	1	[{"added": {}}]	14	1
179	2021-02-22 13:05:01.811332+00	10	10 None Test NEU	2	[{"changed": {"fields": ["Visible role"]}}]	14	1
180	2021-02-22 13:05:14.01476+00	10	10 None Test NEU	2	[]	14	1
181	2021-02-22 13:05:24.836706+00	9	9 Mieter Test VPN	2	[{"changed": {"fields": ["Gruppe"]}}]	14	1
182	2021-02-23 10:20:04.299231+00	4	Offer object (4)	2	[{"changed": {"fields": ["Text"]}}]	29	1
183	2021-05-21 08:05:06.162019+00	54	IssueAnswer object (54)	1	[{"added": {}}]	24	1
184	2021-05-21 08:11:09.648149+00	55	IssueAnswer object (55)	1	[{"added": {}}]	24	1
185	2021-05-21 08:19:40.707791+00	53	Mieter App: Einsicht Mietvertrag	2	[{"changed": {"fields": ["Beschreibung"]}}]	22	1
186	2021-08-09 11:01:40.511352+00	1	test	1	[{"added": {}}]	16	1
187	2021-08-09 11:03:12.3948+00	1	SurveyQuestion object (1)	1	[{"added": {}}]	17	1
188	2021-08-09 11:05:32.450719+00	1	SurveyQuestion object (1)	2	[{"changed": {"fields": ["Antwort 1.", "Antwort 2.", "Typ Frage 2.", "Antwort 2. gew\\u00e4hlt", "Antwort 3.", "Typ Frage 3.", "Antwort 3. gew\\u00e4hlt", "Antwort 4.", "Typ Frage 4."]}}]	17	1
189	2021-08-11 07:02:38.871858+00	52	Ratenzahlungsvereinbarung	2	[{"changed": {"fields": ["Beschreibung", "Postman Beschreibung"]}}]	22	1
190	2021-08-11 07:27:35.608689+00	52	Ratenzahlungsvereinbarung	2	[{"changed": {"fields": ["Beschreibung"]}}]	22	1
191	2021-08-11 07:30:27.818093+00	52	Ratenzahlungsvereinbarung	2	[{"changed": {"fields": ["Beschreibung"]}}]	22	1
192	2021-08-30 07:28:30.337144+00	40	florian.stopienski@gmail.com	3		11	1
193	2021-08-30 13:35:02.257728+00	2	SurveyQuestion object (2)	1	[{"added": {}}]	17	1
194	2021-08-30 15:26:34.680577+00	15	philipp@litzenberger.engineering	3		11	1
195	2021-08-30 16:47:14.530492+00	8	SurveyAnswersText object (8)	3		19	1
196	2021-08-30 16:47:14.535956+00	7	SurveyAnswersText object (7)	3		19	1
197	2021-08-30 16:47:14.538631+00	6	SurveyAnswersText object (6)	3		19	1
198	2021-08-30 16:47:14.541088+00	5	SurveyAnswersText object (5)	3		19	1
199	2021-08-30 16:47:14.543614+00	4	SurveyAnswersText object (4)	3		19	1
200	2021-08-30 16:47:14.546004+00	3	SurveyAnswersText object (3)	3		19	1
201	2021-08-30 16:47:14.548471+00	2	SurveyAnswersText object (2)	3		19	1
202	2021-08-30 16:47:14.550878+00	1	SurveyAnswersText object (1)	3		19	1
203	2021-08-30 17:03:39.530625+00	1	test	2	[{"changed": {"fields": ["Beschreibung"]}}]	16	1
204	2021-08-30 18:42:32.505971+00	1	test	2	[{"changed": {"fields": ["Schlusswort"]}}]	16	1
205	2021-08-30 18:42:34.472581+00	1	test	2	[]	16	1
206	2021-08-30 20:09:52.014868+00	1	Umfrage Test 1.2.0	2	[{"changed": {"fields": ["Umfrage"]}}]	16	1
207	2021-08-30 20:10:59.586887+00	2	SurveyQuestion object (2)	2	[{"changed": {"fields": ["Frage", "Antwort 1.", "Antwort 2."]}}]	17	1
208	2021-08-30 20:11:11.188375+00	2	SurveyQuestion object (2)	2	[]	17	1
209	2021-08-30 20:12:38.725742+00	1	SurveyQuestion object (1)	2	[{"changed": {"fields": ["Frage"]}}]	17	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	authtoken	token
7	authtoken	tokenproxy
8	authentication_local	verificationtoken
9	authentication_local	passwordresettoken
10	gwg_tenant	tenant
11	gwg_tenant	user
12	content	news
13	real_estate	property
14	content	faq
15	real_estate	contract
16	survey	survey
17	survey	surveyquestion
18	survey	surveymembers
19	survey	surveyanswerstext
20	chat	session
21	sites	site
22	issues	issue
23	issues	issuerequested
24	issues	issueanswer
25	push_notifications	apnsdevice
26	push_notifications	gcmdevice
27	push_notifications	wnsdevice
28	push_notifications	webpushdevice
29	content	offer
30	content	page
31	dit_push_notifications	pushnotifications
32	defect	area
33	defect	defect
34	defect	defectresolutionrating
35	defect	defecttype
36	defect	reporteddefect
37	easy_thumbnails	source
38	easy_thumbnails	thumbnail
39	easy_thumbnails	thumbnaildimensions
40	authentication_local	invitationtoken
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-11-30 19:14:36.982996+00
2	contenttypes	0002_remove_content_type_name	2020-11-30 19:14:36.994571+00
3	auth	0001_initial	2020-11-30 19:14:37.024091+00
4	auth	0002_alter_permission_name_max_length	2020-11-30 19:14:37.061665+00
5	auth	0003_alter_user_email_max_length	2020-11-30 19:14:37.078202+00
6	auth	0004_alter_user_username_opts	2020-11-30 19:14:37.091839+00
7	auth	0005_alter_user_last_login_null	2020-11-30 19:14:37.106447+00
8	auth	0006_require_contenttypes_0002	2020-11-30 19:14:37.111483+00
9	auth	0007_alter_validators_add_error_messages	2020-11-30 19:14:37.126513+00
10	auth	0008_alter_user_username_max_length	2020-11-30 19:14:37.144845+00
11	auth	0009_alter_user_last_name_max_length	2020-11-30 19:14:37.16266+00
12	auth	0010_alter_group_name_max_length	2020-11-30 19:14:37.180379+00
13	auth	0011_update_proxy_permissions	2020-11-30 19:14:37.197298+00
14	auth	0012_alter_user_first_name_max_length	2020-11-30 19:14:37.213933+00
15	gwg_tenant	0001_initial	2020-11-30 19:14:37.265565+00
16	admin	0001_initial	2020-11-30 19:14:37.305851+00
17	admin	0002_logentry_remove_auto_add	2020-11-30 19:14:37.320266+00
18	admin	0003_logentry_add_action_flag_choices	2020-11-30 19:14:37.330326+00
19	authentication_local	0001_initial	2020-11-30 19:14:37.335462+00
20	authentication_local	0002_verificationtoken_user	2020-11-30 19:14:37.358235+00
21	authentication_local	0003_passwordresettoken	2020-11-30 19:14:37.3929+00
22	authentication_local	0004_auto_20201119_1330	2020-11-30 19:14:37.438654+00
23	authtoken	0001_initial	2020-11-30 19:14:37.47813+00
24	authtoken	0002_auto_20160226_1747	2020-11-30 19:14:37.599315+00
25	authtoken	0003_tokenproxy	2020-11-30 19:14:37.607784+00
26	gwg_tenant	0002_auto_20201120_0844	2020-11-30 19:14:37.637683+00
27	sessions	0001_initial	2020-11-30 19:14:37.65364+00
28	real_estate	0001_initial	2020-12-02 13:39:04.344345+00
29	real_estate	0002_auto_20201127_1333	2020-12-02 13:39:04.353739+00
30	content	0001_initial	2020-12-02 13:39:04.367814+00
31	content	0002_news_property	2020-12-02 13:39:04.382486+00
32	content	0003_auto_20201201_1444	2020-12-02 13:39:04.440496+00
33	gwg_tenant	0003_auto_20201201_1444	2020-12-02 13:39:04.563871+00
34	content	0004_faq	2020-12-17 08:43:36.045042+00
35	gwg_tenant	0004_auto_20201213_1822	2020-12-17 08:43:36.304565+00
36	gwg_tenant	0005_remove_user_gwg_partner	2020-12-17 08:43:36.362341+00
37	real_estate	0003_contract	2020-12-17 08:43:36.402502+00
38	real_estate	0004_auto_20201213_2027	2020-12-17 08:43:36.482976+00
39	survey	0001_initial	2020-12-17 08:43:36.634534+00
40	authentication_local	0005_create_base_groups	2020-12-23 16:55:24.785251+00
41	chat	0001_initial	2020-12-23 16:55:24.870932+00
42	content	0005_auto_20201221_1149	2020-12-23 16:55:24.946904+00
43	content	0006_auto_20201223_1626	2020-12-29 18:03:47.841512+00
44	issues	0001_initial	2020-12-29 18:03:48.012269+00
45	issues	0002_auto_20201229_1712	2020-12-29 18:03:48.196948+00
46	issues	0003_auto_20201229_1752	2020-12-29 18:03:48.232396+00
47	sites	0001_initial	2020-12-29 18:03:48.248902+00
48	sites	0002_alter_domain_unique	2020-12-29 18:03:48.266391+00
49	issues	0004_issueanswer_code	2020-12-30 14:59:09.668198+00
50	issues	0005_issuerequested_code	2021-01-15 10:35:14.107642+00
51	push_notifications	0001_initial	2021-01-20 20:27:59.04761+00
52	push_notifications	0002_auto_20160106_0850	2021-01-20 20:27:59.11911+00
53	push_notifications	0003_wnsdevice	2021-01-20 20:27:59.182292+00
54	push_notifications	0004_fcm	2021-01-20 20:27:59.231716+00
55	push_notifications	0005_applicationid	2021-01-20 20:27:59.353257+00
56	push_notifications	0006_webpushdevice	2021-01-20 20:27:59.402794+00
57	push_notifications	0007_uniquesetting	2021-01-20 20:27:59.657522+00
58	content	0007_offer	2021-01-20 20:52:35.21212+00
59	content	0008_page	2021-01-20 21:20:28.976679+00
60	real_estate	0005_auto_20210122_1433	2021-01-22 15:17:10.780774+00
61	content	0009_auto_20210129_0924	2021-01-29 09:25:15.575119+00
62	issues	0006_auto_20210212_1138	2021-02-12 11:38:24.952755+00
63	content	0010_auto_20210302_1233	2021-04-07 15:08:58.299946+00
64	content	0011_news_documents	2021-04-07 15:08:58.310649+00
65	content	0012_offer_icons	2021-04-07 15:08:58.325045+00
66	dit_push_notifications	0001_initial	2021-04-07 15:08:58.354737+00
67	gwg_tenant	0006_user_is_data_accepted	2021-04-07 15:08:58.395377+00
68	gwg_tenant	0007_user_code	2021-04-07 15:08:58.42718+00
69	gwg_tenant	0008_user_email_contract	2021-04-07 15:08:58.458358+00
70	gwg_tenant	0009_auto_20210427_1045	2021-04-27 10:45:44.741406+00
71	gwg_tenant	0009_auto_20210428_0704	2021-08-31 07:27:31.025617+00
72	defect	0001_initial	2021-08-31 07:28:16.546922+00
73	defect	0002_auto_20210519_1155	2021-08-31 07:28:28.625992+00
74	easy_thumbnails	0001_initial	2021-08-31 07:29:39.455285+00
75	easy_thumbnails	0002_thumbnaildimensions	2021-08-31 07:29:47.533394+00
76	authentication_local	0002_auto_20210519_1155	2021-08-31 07:36:18.842249+00
77	authentication_local	0003_onetimetoken	2021-08-31 07:36:18.848348+00
78	authentication_local	0004_auto_20210521_1216	2021-08-31 07:36:18.853184+00
81	content	0002_auto_20210519_1155	2021-08-31 10:05:01.293334+00
83	authentication_local	0005_auto_20210831_1030	2021-08-31 10:30:49.629317+00
84	authentication_local	0006_auto_20210831_1043	2021-08-31 10:46:30.195022+00
85	authentication_local	0006_auto_20210831_1109	2021-08-31 11:15:34.053833+00
86	authentication_local	0006_auto_20210831_1117	2021-08-31 11:24:38.391221+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
qbwr240u8x68lgmmorak5j1pqv6lq3ke	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kkNXw:RYrfShT16wtWyLC5JfR4N_d7uY7N5arV_7Y8WLzMAGM	2020-12-16 08:31:32.320048+00
kmamarimdosu0iqpfrczgzek3s9yy28u	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kmHUn:QiOvX1h7INu6EScOJ9PLG2GaBG0br2GEHhWazz5qG7g	2020-12-21 14:28:09.211151+00
lf9poja2bnhmjgwu3xmksdfyx0qkkzot	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kpotj:6WOx3VKnzEO7TG7TU4k_gJ8sSYpVbcmKaucH1VujZpM	2020-12-31 08:44:31.220222+00
f5dhaxl89frh7cfehwu5x9qvqquq6a4c	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1ks7SX:72Rmif2OfVYcRkYGSrq2vpDZ92jwSDwXTi45Ql9RDXs	2021-01-06 16:57:57.353319+00
dchi6eitcsg5yq91oonhr4nz4uhmj5bk	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1ks7Sz:tUhHQzt9SeeTRQgo8RDpk9HNs6jYeaeyeV5dRYirUD8	2021-01-06 16:58:25.457834+00
p8z5siiqvim4o3grihmk98mfzyidu5nn	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1ks7Uy:HSCc1o7e9mXdgCtKad_c8ktGn3UQ8Avxp1F4XtKbHMk	2021-01-06 17:00:28.370108+00
rpx21iykyyqevwlb9j74icsxo3nvyw6w	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1ktsGy:jcE6VJG5iGVUVqiWpCMwFFmSxFuSks4vSslQH5ky7hY	2021-01-11 13:09:16.810267+00
83sgj4zglaf3hbt783y3a09hrzg82t69	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kxu0W:3nKuYz_leBfa0pDAJVTeaEKjC0lALAamh5LWnq1Y9qc	2021-01-22 15:48:56.170698+00
hgld99iu1i3izifet0b8hm1kz7jvdyq3	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1ky1sl:VXGZmfq324pKLBGa2q2-iaXiz0x4aLzoLOJIeu9-Q4c	2021-01-23 00:13:27.485159+00
6boohteyqe5lesy14ne7fjte6inhmu66	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzLiE:vxhPAN-YAYYAuP19l5Qzp9SWVKEa0q5cQReyaFmsrdE	2021-01-26 15:36:02.953978+00
r8myui8oziombq5v0y0pojj5bk83rjgh	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzM6U:UP8L22Z4iSobJ3COXdjlw1aIEeyR1qcvvOfumvSavj8	2021-01-26 16:01:06.73504+00
l436v8of8gw9xu6kzudkh3n7opgxh7yz	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzM8M:5375femJphYj_ApmpNzTioVa7acoh7q-CeWu52f2I-0	2021-01-26 16:03:02.486772+00
oqvig3hgzx6gtujxfuwkr8mnc3g0kgsy	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzM9i:gC0UeIUyfATvIHTm00cakqKDlsvGQdiqWbZxzw4fDN4	2021-01-26 16:04:26.494986+00
yytoemu16ptqiuzieah4k73z7sw3mgge	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzMCH:NvLusZoP557EufslXPduIW7r3ayTC_JatrkhG4dLogY	2021-01-26 16:07:05.984052+00
oy9rle1q4bjgrnuxd84lcbzn4vyebcf9	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzbxl:5DJfZ4_qmEY-S7VgEg-zOINDEn8l22HkppibuBfk9vY	2021-01-27 08:57:09.857656+00
19eu6gr5t209mwsqkqtxxthlzwv9f4c1	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzfnu:T82IGL36dQqcQkSf0M4UBQucgizbENKQwvPTbgAc2Bo	2021-01-27 13:03:14.180156+00
ea7yx26vcgj53j66p0o2fnkoace3yv65	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzfwe:DEKbUAAc-quOPLj-WvQoWZ6EjiZAg5g2t9tQrh2AP4g	2021-01-27 13:12:16.799191+00
gcls722t0wm1s9lj3ag1qcxydbizt2uj	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1kzrbr:7nYiegrnLORG_g7C5OwROXxPZaLLHxBS_MVjcIcuT-8	2021-01-28 01:39:35.860239+00
fqy5is48xmyqngjbd3qvbdmm6ipzdr7q	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l04Uj:WUa4Te-J_CVH4HkJOURORh_7mD_CoIRck46yejgORbw	2021-01-28 15:25:05.125242+00
nzhmdrpjgn5wsgmr23rk9ccadsj8xfu1	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l0MTY:ycKHQQkopJz1ALMBlOLKkIGQOeBGdcoBnP0TKMxk8K4	2021-01-29 10:37:04.776828+00
sgpvmgig6g2xlzjozwgge6uc44dfv28p	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l0OVG:2pAi3icxftT_LaeqoL2h-Uj-xK19I0kMinkhCT04Ay0	2021-01-29 12:46:58.523535+00
hnvy92qw98svjz9pjgm874squ6x0xgci	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l1rjv:8C6u4fsGQ1oSa1AqARuV6loZvsEIG43QNjUlfq6qJgI	2021-02-02 14:12:11.707623+00
o56xle9kt9uomdhv9gedf3twsqhnragh	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l1rjv:8C6u4fsGQ1oSa1AqARuV6loZvsEIG43QNjUlfq6qJgI	2021-02-02 14:12:11.897103+00
j3r3v6wt5kj8tpz05frxetb6c9uvp4oh	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l1tC5:YvFjcBrEkEMXP5ZMKyUh-KGyKOhPhYBDJuFK7wosFTk	2021-02-02 15:45:21.943135+00
uv6xmgyvol0vf7qgc8lza82xz6f0bjyr	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l1tf6:2SPVaUUIwz3qWfd91CGSqj_6IAi_QZ8R28mjj4JSQP8	2021-02-02 16:15:20.146087+00
g1qoc7grl4pvk6asrrmvpunzu2xrds8s	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4KYR:r90ygeKAizcV4K9iqymd30DX2PoJz9t5K-jGXoLs14U	2021-02-09 09:22:31.636024+00
ubci2kffj0ebq4btoyhb837wccgcjfrp	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lEDmp:odeXg2bTVPyaCy3LmBP0eNv5hU0HIgIVNS1s-TJ6A68	2021-03-08 16:10:15.505249+00
o8kqgx0izvebqerekz7wxr6cspvlm3pg	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l28nn:ChwtI3_TMmTiPZZzl7fjX9MjAm1IQ7JoliMWMdITIo0	2021-02-03 08:25:19.026113+00
qdlttbngbusnm1go535x9fziljjzxxl0	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2GVW:CC3CvqF5rPEur5zQuaA9Urb5HjEy9I9SJEudcViGtms	2021-02-03 16:38:58.11988+00
wnofcyg0eyj5nbe1c5j80iy7fcejoloy	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2K6U:rTZ_9edCLnGx0GCAg_3XJiMs6Z5gfOyVF1pF-BkTNEE	2021-02-03 20:29:22.997897+00
zfiilxbg5vl57d8w4apw2nan2qu6h9au	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2KVb:9-UKOKEH-McjKhEQVCrw3QQSDjz-hkiC7IcZCWd0bv8	2021-02-03 20:55:19.147305+00
lauh6h3piklp712jdmqwrabfrh11npbq	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2KzG:l8JPEaWm_8R8ilHxhqo6XUP9Zm3iYI0h4gyuM0sA91M	2021-02-03 21:25:58.84194+00
ifmba6bf15tb222qax011jrel1g0y6c7	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2tRX:AMPk06r9JqIRcBnDHQTIK_WsvXkG2bvyDDkdXvXtfNs	2021-02-05 10:13:27.006377+00
j2s6ld48kp2wiip6rqwcbwhr7f842t4e	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2uTU:e6ujOSojL6vrWy0cqaAWQt3hgsGaDR7nQQu7GoAlw3Q	2021-02-05 11:19:32.863818+00
4duj0sp14f47u1ciw15bbei9mmqd0b2m	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2yIP:517erQpuc7ZZ2uPBD5FxN9z9TvVkJuRzmyytj5U4SvM	2021-02-05 15:24:21.349221+00
4xb7empzp8wtbq13cspq8fstgr9uezlh	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2yWS:ee1iGcHMggO1kwVITwLCMRjibpe0MaecA85I-b3aNZ8	2021-02-05 15:38:52.491862+00
cj5ncl0sz35h07tpz98uai9u4y4qqe64	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l2yZw:fXMOVBPGWLApI6ZrJwqWzJUNbQBOD-vOdGyuCzohlg0	2021-02-05 15:42:28.367027+00
3s7majlldd2zb1pf3p4r3ojlnaiv5rj0	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l3G3V:A6DYFaIMkZsWVj0OSn8t-mCyOCBjmT6iFMH7cbpD3Ec	2021-02-06 10:22:09.520036+00
8g5tmla2c3ceb4jmb8xyl0je603ram5f	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l3G57:fqjjFYycyfgVE5WPbt218oX3yLjwokoo0iuF6HNCALw	2021-02-06 10:23:49.746107+00
eby1xnt9tlefgr8crq10er8stjm8n8el	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l3yJ7:QBG4jiHe0XEw-FEbhhvaCyD34Y1By28m76tK0Z3q26E	2021-02-08 09:37:13.295939+00
mp0f7vf03nrponpa5n8b7ta4phti8mu6	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l3yXF:2_WjGxG-73D7ViO6wX-blPoapfjGfhJR7zEUaH7RvbI	2021-02-08 09:51:49.079458+00
663pcpe90hlh3v99i33f7qenw2pw0z9j	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l3zH9:ULuCSGEIOZXPSB8iD8IlTG3eOk0cb_M14XXWkHDetZ8	2021-02-08 10:39:15.778425+00
koprupkcp8ytwwkwb1e2hzlf75uuwhxv	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l44nt:PVw2sxuJXzjT_zgV9rQQYxmV5XdOXGNXoMV6s498k9I	2021-02-08 16:33:25.579907+00
yhru5s7szoyrrvih7zsyxa6smdaj670p	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l46cP:t2REtrRsfNQY3U2i0rkJVycadcpZagaYBeCuIaO8tqo	2021-02-08 18:29:41.142567+00
az0truthvi43q4i1omctr8dtelejk1qy	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l46h8:mh_y_s_gfzyZibFSt_pRgIjIpmVuvlpOByjja1GtCqA	2021-02-08 18:34:34.642591+00
c58uqolx8w7jv9qi8gtaj9jj2sqylxac	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l46iW:oD664SqhQDYIj9Aru67B_dE7t1saajmix-BNQ1piixc	2021-02-08 18:36:00.382182+00
o81vnvjpl7t50khpg6q2abluv3yvjpbi	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4AJd:aGbwbOF9wsfFYk3SmLFBQLt6_OI6sKV0qIT4mhEtEVA	2021-02-08 22:26:33.376729+00
ju8xbj7xpbe28c6qz05mo3t0tv0ghe54	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4Bsa:rdr-ALrMTrpAZzd5QB0ItSlXwCKiPlLxhrjyicDRggQ	2021-02-09 00:06:44.277244+00
tnmj07kbftdaxj3ckv13fxqwb67jps71	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4C61:SL3_LOVmWG_LVYic8N8se6QJw-l2AssUJs_EliLVw6k	2021-02-09 00:20:37.455626+00
ztsaq9sldyaxiipjivp5dyo068pdci58	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4C75:iHDQJJ7N0c7I1LbNMJsoA3QNjsUDqsXW1I4Igwb616k	2021-02-09 00:21:43.198279+00
54a25cb07w91td6ap2d9b195ul175cho	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4KMy:kRzNW_S8UH8OpDzqwLIhDHREWMigM3RVnohRooIflnk	2021-02-09 09:10:40.320245+00
lka9srk1proe2rwyu0e8g1607i1vj265	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4KjE:xuEvTQlUjYFWZ6T8QneRsT4YU1b2soqPQclEqU1UM50	2021-02-09 09:33:40.919177+00
s8kxdz0dvfwboz47ppoujd0rb5n69mg3	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lEUn4:2h_qPGP5cWPsgrOR4_SyVnHi0FVpVOMSL57PlmSD_5Q	2021-03-09 10:19:38.701395+00
cksx7150ko4crwlu2ys5h48kuafeiixg	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1ljztA:P7__PZPGi2oXCnDZrfFQ_zowNOW3jCO80WfduGO7PaY	2021-06-04 07:48:08.016505+00
w42tt6liw1sxfh4me0myc9ex57ohv3rw	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4Le5:32AUYCkdvkMzy50U55HU25n6kNuE0OMXT8GXoZZr8lU	2021-02-09 10:32:25.531291+00
7m3teycragvm3p57g4336l50i0c4xuuy	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lFCWO:esqy0QI2huK6FIE2H6SNgOlZPwFPXt-qv8pby5HUL9M	2021-03-11 09:01:20.524151+00
ge0yx5sdhq7bnvmxlbm1b3fg1i8go2ku	.eJxVjDEOwjAMRe-SGUVgx3HKyM4ZKidOSQG1UtNOiLtDpA6w_vfef5letrX0W81LP6o5G2Bz-B2jpEeeGtG7TLfZpnlalzHaptidVnudNT8vu_t3UKSWVmNCPsboT-wH9BKI2TEGJgegBB1hSAxfIxORxwwaBGXoUAE1OvP-AN3VNyQ:1lUrId:LH9Sil_5CrTFXzf1sqEsm30diRQPvmX8lYQxuKxPErk	2021-04-23 13:35:51.935363+00
0ur9h0o8yq8fh9lx5pvggzb7b17g92j6	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lk0Ng:abKVsaDzEKF1Ed2f3RRrd7AZHYj0VpoDBM3AIDl3vP4	2021-06-04 08:19:40.970618+00
hx5hxgfsrlz1g5558zfomal2dl4utrxu	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4MuP:89mS18IvtOPcNz1Nsh2whnvd1MOw8Hv4xkkv46GYQ1c	2021-02-09 11:53:21.790685+00
oaxpdf41wz01lclbtsb2kglfh9py0fct	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lGeDB:op0vMe-2c_uBnylALUi5nuu8vpVBYRXURpsGuDELN8Q	2021-03-15 08:47:29.489389+00
7pyd3oa443yxrdwl2dt3k9zffux1fegc	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1m2yAu:-SX8u8r6oES8qdDPuNwT7LcAhqhbw4beVszJBPFXaaY	2021-07-26 15:48:52.914379+00
69k6t9o1m9tcki870cg3rd6hklp05osl	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4N6E:g5ChuzhLjeqIBBBFLGEakaCwT_YKV5wh4XbbZ-X4aso	2021-02-09 12:05:34.728401+00
98xxjsp6c2jwqmsnshwp5nxmmrr4m6r9	.eJxVjDEOwjAMRe-SGUVgx3HKyM4ZKidOSQG1UtNOiLtDpA6w_vfef5letrX0W81LP6o5G2Bz-B2jpEeeGtG7TLfZpnlalzHaptidVnudNT8vu_t3UKSWVmNCPsboT-wH9BKI2TEGJgegBB1hSAxfIxORxwwaBGXoUAE1OvP-AN3VNyQ:1lWzTa:ncPYHUYDWWE21b72CKxXdq55Ph3CD00bhMrcxEH4hdQ	2021-04-29 10:43:58.14589+00
fbl6ofydu3pq225sdc2kp35mm9ppyn9z	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1m2yCr:2gLnjZLsqOMefA2VvPOhyKTqWViB7yG-i1DzUYiCxeA	2021-07-26 15:50:53.715284+00
shpudcphy2m8rmlzghdc3sr7doaaeg01	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4N73:mqEx-jIvCY8m-Y8iRLNOsMSmvXuZwEuERA2a3zYBnvo	2021-02-09 12:06:25.430788+00
bmv58nr08a2bx8kyj0nxhqr2k9kdp1ux	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1mD364:Gf2301Ngzb1_6GOyZ2FOCwQ4KjqldZQe_bsBDa0VlPM	2021-08-23 11:05:32.704465+00
q8dfve5c4pzgjmov1wwcvux3ipm41r0m	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4NAV:rfAevEa8OSt1f3bUKrqhPwdzL-hnWTAMKRRRjaA8gHc	2021-02-09 12:09:59.420267+00
f7kmvw69k71znfds5vptxzx843v0xjg0	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1mDiEs:r53rOTaoytvtfoWA4IpUMuZt636WngN3_AAibKh8KI4	2021-08-25 07:01:22.703046+00
0kp2uhfwwfl2owhg9xri5pr2v7p8bq38	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4NAu:TKNN_Ulmx3to58gK8P7GLE1XJY3m0mw1XU3kEL1VN54	2021-02-09 12:10:24.192419+00
f6in2wp2mkjc9o21mxbibvknjewbpm2v	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1mDih2:JlDNG8NEzdgqUHKoW3vpcX5YXiPpVrhLSQkAnH5x4Ec	2021-08-25 07:30:28.111638+00
skh0ltxbt6rno6oznrn17w5mqhze7l5q	.eJxVjDEOwjAMRe-SGUVgx3HKyM4ZKidOSQG1UtNOiLtDpA6w_vfef5letrX0W81LP6o5G2Bz-B2jpEeeGtG7TLfZpnlalzHaptidVnudNT8vu_t3UKSWVmNCPsboT-wH9BKI2TEGJgegBB1hSAxfIxORxwwaBGXoUAE1OvP-AN3VNyQ:1mERaZ:k7BKwuUKBNU6-Rwm5E6uSNobhRscGogVpduKA23KG38	2021-08-27 07:26:47.593776+00
h5xm24n17jhklc1ke80xge565o8u68yx	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4UNO:1GBxa3xHWNYgc_SSmcLLFe4keymBzEiVRN4VXSnWEKY	2021-02-09 19:51:46.517861+00
hqdal9f5mbpbqu34t92d777on7phuvi3	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1mKbT1:8bp3_YBSkwl-BZyL55Y155pA0hfRQw8Y7D6Is6-Y4Q4	2021-09-13 07:12:27.597685+00
w919iz8p2e6ishtto0sptpclhygindan	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4URo:Yawq0buxoTyPbUZ0S1q0SqSDQ7rBOKLAC9VSkwm-Lpw	2021-02-09 19:56:20.502536+00
61cgcp5jnlv36a41qwvafefehrn1dbmf	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1mKbiY:whbOAtwtbmxRFc2Adt5n1aurcUUg-xXF-hOfBoJbcYY	2021-09-13 07:28:30.649743+00
2npfyjjbp623wzemltf9se0oeo5wm1bc	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4UTI:99rqBu6Z54tkBzpvsJ0BXPfed7DsG9Xe7gtfwSusKqk	2021-02-09 19:57:52.910811+00
8s3o54ebs4rju0cbmx5frkpv6odw4alr	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1mKne2:PYe41YTBYlvKe1c59grLOJuDrhmRWenwiFQpF_SjA_Q	2021-09-13 20:12:38.990191+00
q3mmk3zxjyz4absedproypc28p5f9lmb	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4gsk:I2orSFGHW7VlGKRmNRSeJGjApNzvAdYwAtbxfwNsRCI	2021-02-10 09:12:58.78438+00
i3gd4q76g5gtqkpfpt15sac1w0lecxoc	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1mKjBD:8DnTF5kEdjixxQurLZcOfd4D28uJtROv3XePwX03yoA	2021-09-13 15:26:35.007997+00
wod1ky0jr3t5i4d65s52cxdbtaeb9zg3	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4gsy:3KtC_H9X_GHt9eCSazNK8uz6-e7P7EaK6g8o9wlNsys	2021-02-10 09:13:12.377445+00
5o62bhurg5aeanaf13v3yznd3nggjdi5	.eJxVjDsOwyAQBe9CHSEDyy9lep8BAbsOTiKQjF1FuXtsyUXSvpl5bxbitpawdVrCjOzKlGWX3zHF_KR6EHzEem88t7ouc-KHwk_a-diQXrfT_TsosZe93k1y2VDEyakswSuTBIKlAYwXTnk3JelsxEFLBCGtcaRtylILCQDIPl8cKje0:1mKjBw:pxQbty0VN4q-oP9Ofsq-VQerjCdCWG6buI7mYySMGRA	2021-09-13 15:27:20.643214+00
y67xfhxpx2483xvjr6xkj4ytiiib1gkz	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4gtM:9DVlKWBRHLuhyKN8vsSU-L4SG_3UU1lbRD9iHMcKPJo	2021-02-10 09:13:36.788823+00
r5zfzcoo8zsgoacbldrl9ek32hx0uoni	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4gtd:vRq077qOwPZ7lJGQTe1ItkB-4cel4oQ0GA5m3-4wPDE	2021-02-10 09:13:53.916571+00
zmylgq699rht03pftfoj1lz2hasxdl2c	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4iyA:m2JtWh2_dgVT23gci3WsfuMTWKU6K4p4pKLx8Ni4FRQ	2021-02-10 11:26:42.343416+00
oedhnxa5gaxku2e3cvlb8o74rk2tc82j	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4iya:Y7Z8U3whu6r1zOG3_IwhMNEnSeCSPTDqTgQQKgASc5c	2021-02-10 11:27:08.976711+00
pdkwudaoyz7uvb0k64acl1qwckr9jymx	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4nSd:qqRN_0c_xx7Sf-EVjG_Ld0TPb63X9A7qOnVVYy5pVuY	2021-02-10 16:14:27.558458+00
k52ry1inj4btw5nz8i0h716ibzzdcor4	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4nje:ollUMuvM8LRbtfxBgGaAxMbUDJZCagDeG9Qyd7Nb--E	2021-02-10 16:32:02.977949+00
waqpgwv1zd6ejhc6jwik53g8vk5tu7iw	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l4uag:1Ps_BZPPYAKktENsFK3bFdW88nBKUDORD21lCI6wgmQ	2021-02-10 23:51:14.777733+00
v1yu7z190wqsaxvmep9jhir5gc737o3x	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l52ln:d4muJzz1tKB9uohvTxLH6pwimorFBQsNR2KJrVHJt70	2021-02-11 08:35:15.613636+00
yj5n30jdrnr5t1xqachnagc92gld0utt	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l5PdM:Ee1c1EILHWdRKX8KsbbjIMyh5Njj7tPfPMB-5iVo0m4	2021-02-12 09:00:04.542792+00
do6o1d5o7ju6shjp6ycp3j6z0yx6s49s	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l5Q8Q:jK8x1VXzblTPEspbwmFEzmY27Mi6-jyUdKA5xSOfWUw	2021-02-12 09:32:10.45684+00
lkxbmgfm4m3x8ees6gg5r4c4014kbrwu	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l5Q9D:vIBOxLgKEn8hDDAnsf2KFz00dY5gisMbVaA71QwMqzs	2021-02-12 09:32:59.450808+00
cf25sqeta4g8wngubukleyt3w7x6u3pd	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l5QA8:vKrgiaeCJipdE2umVduqRf_lNUxDDZT7kvWptN7l6DI	2021-02-12 09:33:56.694217+00
39wkis8e8l3b3f7t9hf6gtkw70zwzhh9	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l5QF2:kGRJlFzh0xLlXFeX34urXKyRgf6HgH3Vj3S586jbqRk	2021-02-12 09:39:00.712194+00
imevlvs1gl613qm0d8ks7puz4oogsr9t	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l5QFn:MWhd16wgfHhA1fXbKl7nfyiYhKhvYNpVWlbaajStQws	2021-02-12 09:39:47.686805+00
8csnbk2v88vfboyl4qpz4r7y17h4nrmn	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l5QHE:JXPwBrxI3E6LYPwrFOjD8r79jItaeSbVtEI3t-LIOTU	2021-02-12 09:41:16.230003+00
2aowx3hlxcre12gns39hr7dv432yckrh	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l5QhH:Rlq8VrVNNBsJ8QvTfZ5JKSPPCAoUmKe4S130fSOOZHU	2021-02-12 10:08:11.507905+00
vdtnzpt03zqxugrdgsuo8kaiy2t000n9	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l6rBT:fC6Rvz_6jwI1KnLb1jideVe5U2o8Sr3X9TLCxEppBt0	2021-02-16 08:37:15.622779+00
sm6x1pmemib1w45j0cwzp7rgp9yd69tv	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l7eep:RCWvg969lKSxpu-A2ERVCr4KAiul-PvMNyjBlsgg60A	2021-02-18 13:26:51.758028+00
g24hydogh5jj3jugnx6s36k613za75v3	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l80ca:jsV7wg3rtkyboqfm3Z5N2osAPKtlFWNhWzRvHtqg4rE	2021-02-19 12:54:00.020981+00
h7c47pk4dxmzwkzm2wz56wbfdsalv7ki	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l84sE:Znx-G6dZL4AKVv1MLqpwLcVWWc5mZirv8CfstZb-3eg	2021-02-19 17:26:26.933051+00
ku39ynlommv433zjmjek0t50lt5yob09	.eJxVjMsOwiAUBf-FtSFgebp0328g3EekaiAp7cr470rShS7Pmcm8RMr7VtLeeU0LiYvw4vT7QcYH1wHonuutSWx1WxeQQ5EH7XJuxM_r4f4FSu5lZC1gsJNy6myVUd9BFDACaeM1Oh0tIxAHZYFBO8XeetBxQuPIeULx_gDXrjfV:1l98g1:-sBsj5QmkmPN43_c0Tb-G_NUTd3svfcJLPMSzJCQKGo	2021-02-22 15:42:13.473654+00
emymfxgd78qoe7h0jq3l87p26kdbqu7z	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l9jra:zjO0kTqIOhDxaLvLXJUQbmjWb-1n5q9gyK4tQRcNRfA	2021-02-24 07:24:38.404104+00
k22c7kug40cv0h0wl0a41kn4wcuf388w	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l9k1k:pfNdb_lI5fStVmIhSoKOFown_HwUCHjuyal50RzjZig	2021-02-24 07:35:08.042946+00
wg3netwqlkhr0hhed58gevq3v0i8bwvx	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1l9qrN:Hd8kLymD-nLTDzmDW96nxBXX0bZf02RFlkZH97BAPXw	2021-02-24 14:52:53.229651+00
cpev5luvnzkorx41qk7v02d0k4hih15k	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lAD8n:xKAdAfBS7ocdRti_WVpLQ5EoVKIEeNwgfFFW87QKxcU	2021-02-25 14:40:21.806539+00
swdg2hmk4663k9q2lu69whs5fn1jg3bm	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lAEgx:4q-7ywDqu0IVXWIR33Xj2gGu5Ke9gy_8jopBYQr4DdQ	2021-02-25 16:19:43.907993+00
56ihuzy78ey8suhviup23auugjhuzd3d	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lAUeB:wlMsIiTVcvcankVgbj_oVXfUghYWgKPnZnvBWAMngUs	2021-02-26 09:21:55.017056+00
z8t6mfrhzytkzjsydckk1n0kys8viyq1	.eJxVjDEOwjAMRe-SGUVgx3HKyM4ZKidOSQG1UtNOiLtDpA6w_vfef5letrX0W81LP6o5G2Bz-B2jpEeeGtG7TLfZpnlalzHaptidVnudNT8vu_t3UKSWVmNCPsboT-wH9BKI2TEGJgegBB1hSAxfIxORxwwaBGXoUAE1OvP-AN3VNyQ:1lAVBv:lQEdUDy7QHDm7_m3Cq7KOJgEHFSIQ6FqxQPdYZERGAQ	2021-02-26 09:56:47.559068+00
39bx3k1g4reqf8i96aznacbhl6cjlno6	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lBi8v:mW5tk1F4lsbcgtc4BiVDYFyYNu-rxljVxhe1cud7KKI	2021-03-01 17:58:41.525181+00
sllq4l31in0hx58lgehp6aiq6ie77fzj	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lC2tO:yBRLMTT99EAXMf_ARh8yFI_HqBQO4gPXKgd52ZaM4gU	2021-03-02 16:08:02.307722+00
thou47j6b4klcgj1km2a2wf6fn82wwt8	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lCICY:aO7pgn8gOU3_FTTLzvyqXq0C8cxPOVGYS3mzysFpRm4	2021-03-03 08:28:50.666566+00
uz9zl8tl4gz7nd5huldnssg941e6vv2h	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lCJSh:WIxSHIQRtVXPSbImOedWU8n1CYHfvpB_PwOh67FpWec	2021-03-03 09:49:35.926971+00
y207yxxvwlunf5xepu1nscz5z1xx1h5w	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lCKuP:PxQ8ovnfb-axFsD9kOLK2Eo5n2fNIYIXk9nrKFWEJpA	2021-03-03 11:22:17.086462+00
okv5lmhxid90svtfjuspz6woqy5fm892	.eJxVjDEOwjAMRe-SGUVgx3HKyM4ZKidOSQG1UtNOiLtDpA6w_vfef5letrX0W81LP6o5G2Bz-B2jpEeeGtG7TLfZpnlalzHaptidVnudNT8vu_t3UKSWVmNCPsboT-wH9BKI2TEGJgegBB1hSAxfIxORxwwaBGXoUAE1OvP-AN3VNyQ:1lCkgA:IdyBgH0ouXMROh1SdXybs7h4QQlR3iRAd9weHIvjVYs	2021-03-04 14:53:18.123056+00
4pqpzqb1vjjirrdjmzrv0g5antve62d0	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lD19o:68QOM66AHAj5c-Tt-jw_0ciVaGrMAZsBmXRBZOeqL7M	2021-03-05 08:29:00.152864+00
n6ro2hs9drn792hfs62w5zu49s7fa8cv	.eJxVjDEOwjAMRe-SGUVgx3HKyM4ZKidOSQG1UtNOiLtDpA6w_vfef5letrX0W81LP6o5G2Bz-B2jpEeeGtG7TLfZpnlalzHaptidVnudNT8vu_t3UKSWVmNCPsboT-wH9BKI2TEGJgegBB1hSAxfIxORxwwaBGXoUAE1OvP-AN3VNyQ:1lD2hk:3PCrWo1muyFKPesXhmZXo4nGWLPn6_BCY145QxDGie0	2021-03-05 10:08:08.907443+00
w0zy0123ihm2op9992xh762axxsw5f6l	.eJxVjDEOwjAMRe-SGUVgx3HKyM4ZKidOSQG1UtNOiLtDpA6w_vfef5letrX0W81LP6o5G2Bz-B2jpEeeGtG7TLfZpnlalzHaptidVnudNT8vu_t3UKSWVmNCPsboT-wH9BKI2TEGJgegBB1hSAxfIxORxwwaBGXoUAE1OvP-AN3VNyQ:1lEAjv:9-6WYquJdp-hFioUP_i4--lSZaCqhZWmGyfdgiIZu4M	2021-03-08 12:55:03.577658+00
9tsg8dmlkv3ybgh09i18u7a7amp5imc5	.eJxVjEEOwiAQRe_C2hCmIFCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5VtHzikBe0fkjSEYUOkIHjOPUWnW0QM65RSyBlIGTfY4uDNZ6y2PYMX7Awc6OCM:1lEAwb:sUr3oIUm3We5CVh4ojjW98HHe__os-MM9biaaOCYKr0	2021-03-08 13:08:09.576621+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	dwapp-0064-test.datasec.de	dwapp-0064-test.datasec.de
\.


--
-- Data for Name: easy_thumbnails_source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.easy_thumbnails_source (id, storage_hash, name, modified) FROM stdin;
\.


--
-- Data for Name: easy_thumbnails_thumbnail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.easy_thumbnails_thumbnail (id, storage_hash, name, modified, source_id) FROM stdin;
\.


--
-- Data for Name: easy_thumbnails_thumbnaildimensions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.easy_thumbnails_thumbnaildimensions (id, thumbnail_id, width, height) FROM stdin;
\.


--
-- Data for Name: gwg_tenant_tenant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gwg_tenant_tenant (bukrs, swenr, sgenr, smenr, recnnr, name_last, name_first, partnerid, mobile, phone) FROM stdin;
2000	00010021	00000004	00000020	10021.0020.05	Raczkowski                              	Franziska                               	2000.10021.0020.05	\N	\N
2000	00010021	00000007	00000039	10021.0039.03	Dödderer                                	Jochen                                  	2000.10021.0039.03	\N	\N
2000	00010021	00000008	00000047	10021.0047.01	Morcher                                 	Anne                                    	2000.10021.0047.01	\N	\N
2000	00010022	00000002	00000026	10022.0026.01	Röse                                    	Wilfried                                	2000.10022.0026.01	\N	\N
2000	00010022	00000003	00000031	10022.0031.02	Ruf                                     	Maria                                   	2000.10022.0031.02	\N	\N
2000	00010022	00000003	00000033	10022.0033.02	Gharbi                                  	Radhia                                  	2000.10022.0033.02	\N	\N
2000	00010022	00000003	00000036	10022.0036.01	Waibel                                  	Jochen                                  	2000.10022.0036.01	\N	\N
2000	00010026	00000003	00000019	10026.0019.05	Koci                                    	Muharrem                                	2000.10026.0019.05	\N	\N
2000	00010021	00000005	00000026	10021.0026.01	Weingärtner                             	Maria                                   	2000.10021.0026.01	\N	\N
2000	00010021	00000005	00000027	10021.0027.02	Klatt                                   	Waltraut                                	2000.10021.0027.02	\N	\N
2000	00010021	00000006	00000033	10021.0033.01	Reichert                                	Monika                                  	2000.10021.0033.01	\N	\N
2000	00010022	00000001	00000001	10022.0001.03	Seeger                                  	Nelli                                   	2000.10022.0001.03	\N	\N
2000	00010022	00000001	00000009	10022.0009.04	Reinhardt                               	Annika                                  	2000.10022.0009.04	\N	\N
2000	00010022	00000001	00000010	10022.0010.06	Naumann                                 	Irmtraud                                	2000.10022.0010.06	\N	\N
2000	00010022	00000002	00000015	10022.0015.05	Turan                                   	Ayse                                    	2000.10022.0015.05	\N	\N
2000	00010022	00000002	00000016	10022.0016.07	Wiem                                    	Simon                                   	2000.10022.0016.07	\N	\N
2000	00010022	00000002	00000018	10022.0018.02	Herceg                                  	Silvana                                 	2000.10022.0018.02	\N	\N
2000	00010022	00000002	00000020	10022.0020.04	Thi                                     	Bao Chau Do                             	2000.10022.0020.04	\N	\N
2000	00010022	00000002	00000023	10022.0023.03	Morais                                  	Jose Monteiro                           	2000.10022.0023.03	\N	\N
2000	00010022	00000002	00000028	10022.0028.04	Gharbi                                  	Nabil                                   	2000.10022.0028.04	\N	\N
2000	00010022	00000003	00000032	10022.0032.03	Zejneli                                 	Minire                                  	2000.10022.0032.03	\N	\N
2000	00010022	00000003	00000034	10022.0034.03	Bayazit                                 	Yasar                                   	2000.10022.0034.03	\N	\N
2000	00010022	00000903	00000602	10022.0602.02	Yildiz                                  	Hicran                                  	2000.10022.0602.02	\N	\N
2000	00010026	00000003	00000014	10026.0014.04	Makici                                  	Hajriz                                  	2000.10026.0014.04	\N	\N
2000	00010012	00000001	00000101	10012.0101.01	Berger                                  	Joel                                    	2000.10012.0101.01	\N	\N
2000	00010013	00000901	00000613	10013.0613.01	Berger                                  	Joel                                    	2000.10013.0613.01	\N	\N
2000	00010021	00000003	00000013	10021.0013.01	Kleinert                                	Ricarda                                 	2000.10021.0013.01	\N	\N
2000	00010022	00000001	00000008	10022.0008.04	Seifried                                	Stefan                                  	2000.10022.0008.04	\N	\N
2000	00010022	00000003	00000038	10022.0038.03	Cherazinizhad                           	Nasrollah                               	2000.10022.0038.03	\N	\N
2000	00010026	00000901	00000612	10026.0612.01	Makici                                  	Hajriz                                  	2000.10026.0612.01	\N	\N
2000	00010028	00000003	00000014	10028.0014.05	Stelter                                 	Gerda                                   	2000.10028.0014.05	\N	\N
2000	00010021	00000002	00000007	10021.0007.02	Hertel                                  	Volkmar                                 	2000.10021.0007.02	\N	\N
2000	00010021	00000007	00000037	10021.0037.01	Unger                                   	Anna                                    	2000.10021.0037.01	\N	\N
2000	00010021	00000908	00000602	10021.0602.01	Kleinert                                	Ricarda                                 	2000.10021.0602.01	\N	\N
2000	00010022	00000001	00000004	10022.0004.03	Schmid                                  	Ludwig                                  	2000.10022.0004.03	\N	\N
2000	00010022	00000001	00000008	10022.0008.03	Seifried                                	Ursula                                  	2000.10022.0008.03	\N	\N
2000	00010022	00000001	00000010	10022.0010.05	Schill                                  	Corinna                                 	2000.10022.0010.05	\N	\N
2000	00010022	00000001	00000011	10022.0011.04	Schaible                                	Siegfried                               	2000.10022.0011.04	\N	\N
2000	00010022	00000002	00000016	10022.0016.08	Saric                                   	Vanja                                   	2000.10022.0016.08	\N	\N
2000	00010022	00000002	00000027	10022.0027.06	Hupertz                                 	Saskia                                  	2000.10022.0027.06	\N	\N
2000	00010022	00000003	00000035	10022.0035.07	Papadopoulos                            	Stavros                                 	2000.10022.0035.07	\N	\N
2000	00010022	00000003	00000040	10022.0040.04	Yildiz                                  	Hicran                                  	2000.10022.0040.04	\N	\N
2000	00010026	00000003	00000017	10026.0017.02	Puppich                                 	Monika                                  	2000.10026.0017.02	\N	\N
2000	00010028	00000001	00000003	10028.0003.02	Wolf                                    	Jürgen                                  	2000.10028.0003.02	\N	\N
2000	00010028	00000003	00000016	10028.0016.02	Malerba                                 	Pietro                                  	2000.10028.0016.02	\N	\N
2000	00010009	00000005	00000055	10009.0055.04	Berger                                  	Joel                                    	2000.10009.0055.04	\N	\N
2000	00010009	00000006	00000065	10009.0065.02	Tahiri                                  	Elvisa                                  	2000.10009.0065.02	\N	\N
2000	00010021	00000003	00000018	10021.0018.01	Vaque                                   	Ilse                                    	2000.10021.0018.01	\N	\N
2000	00010021	00000006	00000301	10021.0301.01	Cegledi                                 	Ladislav                                	2000.10021.0301.01	\N	\N
2000	00010021	00000008	00000044	10021.0044.03	Mikhalevitch                            	Mikhail                                 	2000.10021.0044.03	\N	\N
2000	00010021	00000908	00000604	10021.0604.01	Hertel                                  	Volkmar                                 	2000.10021.0604.01	\N	\N
2000	00010021	00000908	00000605	10021.0605.01	Weisensee                               	Heidi                                   	2000.10021.0605.01	\N	\N
2000	00010022	00000001	00000007	10022.0007.03	Früholz                                 	Regina                                  	2000.10022.0007.03	\N	\N
2000	00010022	00000001	00000007	10022.0007.04	Hartmann                                	Jenny                                   	2000.10022.0007.04	\N	\N
2000	00010022	00000002	00000019	10022.0019.02	Bellson                                 	Marcel                                  	2000.10022.0019.02	\N	\N
2000	00010022	00000003	00000039	10022.0039.05	Haug                                    	Manuela                                 	2000.10022.0039.05	\N	\N
2000	00010022	00000903	00000501	10022.0501.01	Häntsch                                 	Regina                                  	2000.10022.0501.01	\N	\N
2000	00010028	00000001	00000005	10028.0005.04	Schuh                                   	Lydia                                   	2000.10028.0005.04	\N	\N
2000	00010013	00000901	00000630	10013.0630.01	Berger                                  	Joel                                    	2000.10013.0630.01	\N	\N
2000	00010017	00000001	00000005	10017.0005.01	Weitzer                                 	Sieglinde                               	2000.10017.0005.01	\N	\N
2000	00010021	00000001	00000004	10021.0004.03	Lingnau                                 	Gisela                                  	2000.10021.0004.03	\N	\N
2000	00010021	00000001	00000050	10021.0050.06	Horst                                   	Jonas                                   	2000.10021.0050.06	\N	\N
2000	00010021	00000005	00000025	10021.0025.03	Weisensee                               	Heidi                                   	2000.10021.0025.03	\N	\N
2000	00010022	00000001	00000010	10022.0010.07	Hengelmann                              	Franziska                               	2000.10022.0010.07	\N	\N
2000	00010022	00000001	00000012	10022.0012.06	Basica                                  	Marija                                  	2000.10022.0012.06	\N	\N
2000	00010022	00000001	00000013	10022.0013.04	Strobel                                 	Jens                                    	2000.10022.0013.04	\N	\N
2000	00010022	00000001	00000014	10022.0014.06	Hagel                                   	Martha                                  	2000.10022.0014.06	\N	\N
2000	00010022	00000002	00000019	10022.0019.03	Schröer                                 	Katrin                                  	2000.10022.0019.03	\N	\N
2000	00010022	00000002	00000022	10022.0022.03	Indlekofer                              	Sebastian                               	2000.10022.0022.03	\N	\N
2000	00010022	00000002	00000024	10022.0024.05	Schneider                               	Elmar                                   	2000.10022.0024.05	\N	\N
2000	00010022	00000002	00000025	10022.0025.03	Hermann                                 	Viktor                                  	2000.10022.0025.03	\N	\N
2000	00010022	00000002	00000027	10022.0027.05	Briegel                                 	Saschka                                 	2000.10022.0027.05	\N	\N
2000	00010022	00000903	00000603	10022.0603.02	Cherazinizhad                           	Nasrollah                               	2000.10022.0603.02	\N	\N
2000	00010028	00000003	00000015	10028.0015.02	Santonastaso                            	Marco                                   	2000.10028.0015.02	\N	\N
2000	00010018	00000002	00000007	10018.0007.03	Leirich                                 	Martha                                  	2000.10018.0007.03	\N	\N
2000	00010021	00000005	00000030	10021.0030.03	Zimmat                                  	Iris                                    	2000.10021.0030.03	\N	\N
2000	00010021	00000005	00000049	10021.0049.07	Goldberg                                	Viktoria                                	2000.10021.0049.07	\N	\N
2000	00010021	00000908	00000508	10021.0508.01	Lingnau                                 	Gisela                                  	2000.10021.0508.01	\N	\N
2000	00010022	00000001	00000003	10022.0003.03	Düthmann                                	Luba                                    	2000.10022.0003.03	\N	\N
2000	00010022	00000001	00000005	10022.0005.01	Kieninger                               	Albert                                  	2000.10022.0005.01	\N	\N
2000	00010022	00000001	00000007	10022.0007.05	Hufnagel                                	Pia Marie                               	2000.10022.0007.05	\N	\N
2000	00010022	00000001	00000013	10022.0013.05	Caumanns                                	Sandra                                  	2000.10022.0013.05	\N	\N
2000	00010022	00000003	00000037	10022.0037.06	Marji                                   	Rabab                                   	2000.10022.0037.06	\N	\N
2000	00010022	00000903	00000502	10022.0502.01	Röse                                    	Wilfried                                	2000.10022.0502.01	\N	\N
2000	00010021	00000908	00000511	10021.0511.02	Krumm                                   	Andreas                                 	2000.10021.0511.02	\N	\N
2000	00010021	00000908	00000603	10021.0603.01	Buchholzer                              	Michael                                 	2000.10021.0603.01	\N	\N
2000	00010022	00000001	00000002	10022.0002.03	Buth                                    	Mario                                   	2000.10022.0002.03	\N	\N
2000	00010022	00000001	00000006	10022.0006.06	Heinz                                   	Elisabeth                               	2000.10022.0006.06	\N	\N
2000	00010022	00000001	00000009	10022.0009.03	Schüßler                                	Verena                                  	2000.10022.0009.03	\N	\N
2000	00010022	00000002	00000017	10022.0017.03	Smerty                                  	György                                  	2000.10022.0017.03	\N	\N
2000	00010022	00000002	00000021	10022.0021.03	Indlekofer                              	Mona                                    	2000.10022.0021.03	\N	\N
2000	00010022	00000003	00000029	10022.0029.04	Häntsch                                 	Regina                                  	2000.10022.0029.04	\N	\N
2000	00010022	00000003	00000030	10022.0030.04	Gharbi                                  	Mahmoud                                 	2000.10022.0030.04	\N	\N
2000	00010022	00000003	00000035	10022.0035.06	Jacobi                                  	Susanne                                 	2000.10022.0035.06	\N	\N
2000	00010022	00000003	00000040	10022.0040.03	Mullis                                  	Jürgen                                  	2000.10022.0040.03	\N	\N
2000	00010022	00000903	00000601	10022.0601.01	Gharbi                                  	Mahmoud                                 	2000.10022.0601.01	\N	\N
2000	00010026	00000001	00000004	10026.0004.01	Otte                                    	Margarete                               	2000.10026.0004.01	\N	\N
2000	00010028	00000001	00000001	10028.0001.06	Otto                                    	Kerstin                                 	2000.10028.0001.06	\N	\N
2000	00010028	00000002	00000012	10028.0012.03	Yildirim-Sieber                         	Dorothee                                	2000.10028.0012.03	\N	\N
1000	00099999	00000001	00000001	99999.0001.01	Ostrowski-Kicherer	Angelika	1000.99999.0001.01	\N	\N
\.


--
-- Data for Name: gwg_tenant_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gwg_tenant_user (id, password, last_login, is_superuser, email, is_staff, is_active, date_joined, is_verified, birthdate, city, first_name, last_name, mobile, phone, principal_id, street, street_number, zip_code, is_data_accepted, code, email_contract) FROM stdin;
32	pbkdf2_sha256$216000$EHk1YtO3fDqy$W9vrjmSPsKPhlYWqjlQM6jPyJhowHzL1puyt9MG4CBY=	\N	f	mail@stopienski.de	f	t	2021-02-16 18:01:15.218155+00	f	1974-12-14	Leinf.-Echterdingen	Birgül	Yazici		01628783348	0001032889	Esslinger Str.	3/1	70771	f	\N	\N
22	pbkdf2_sha256$216000$UNLTtlq3Ns7o$IYay4mitIJD/GsFFlaW/ozabghEdDeUIwc9T3m40lD4=	\N	f	apps.gwggruppe@web.de	f	t	2021-01-27 09:12:34+00	t	1974-12-14	Leinf.-Echterdingen	Birgül	Yazici	1234567493	01563785964	0001032889	Esslinger Str.	3/1	70771	f	\N	\N
9	pbkdf2_sha256$216000$mjKo8Rctwdel$hbf2yCSc8ibx/6+noYp0qn5LAu1n2R0hTwFimggLtXI=	\N	f	teute@equity-seven.de	f	t	2021-01-13 16:24:42+00	f	1958-04-19	Stuttgart	Angelika	Ostrowski-Kicherer	015228706421	\N	0001051370_	Heusteigstraße	20	70182	f	\N	\N
25	pbkdf2_sha256$216000$TJjf1hGbU1Kl$zIWBWW/67P8x6bIMcKsPGXF69OeDeR9hUzawghQiplI=	\N	f	karen.raschke@gwg-gruppe.de	f	t	2021-02-04 13:26:19+00	t	1974-12-14	Leinf.-Echterdingen	Birgül	Yazici	——y	01628783348	0001032889	Esslinger Str.	3/1	70771	f	\N	\N
13		\N	f	Andreas.laub@diimt.de	f	t	2021-01-20 16:41:22+00	f	2021-01-21	rewrwere	Andreas	Laub	243234	1243	12345	sdfsdf	232	23232	f	\N	\N
17		\N	f	clarissa.jass@dit-digital.de	f	t	2021-01-25 18:30:11+00	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N
26		\N	t	Andreas.laub@dit-digital.de	t	t	2021-02-05 12:55:30+00	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N
27	pbkdf2_sha256$216000$lgxPzZTzl2Qr$0lSaAfyKkIZnA/3LMTjF3gJpx/EJeImnAKg9PkKctaY=	2021-08-13 07:26:47.591491+00	t	gwgadmin@test.de	t	t	2021-02-10 17:03:36.584648+00	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N
7	pbkdf2_sha256$216000$EcsdNXl2QXq0$Kdrh+F3udDp3tn4zflhallxidB5ilpBaJZDT3CxXqgE=	2021-02-16 18:21:05.485569+00	f	f_stop@gmx.de	f	t	2020-12-23 16:51:55+00	t	1958-04-19	Stuttgart	Angelika	Ostrowski-Kicherer	999999999999	045133t3g	0001051370	Heusteigstraße	20	70182	f	\N	\N
1	pbkdf2_sha256$216000$f79xhbWbX5eC$i+rIxZSXlFLCtwrbd81HVlOJa80mZpI3c/qQ42eKwws=	2021-08-30 15:26:02.733958+00	t	ditadm@dit-digital.de	t	t	2020-11-30 19:15:28.569347+00	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N
37	pbkdf2_sha256$216000$C5l4HEFAqRno$rq6N/WUaBcHDut38OVeIv2f9PTLt8ml8LrPZ1PL6yVA=	2021-08-30 15:27:20.64042+00	f	f.stopienski@gmx.de	f	t	2021-02-16 22:08:49.786512+00	f	1974-12-14	Leinf.-Echterdingen	Birgül	Yazici		01628783348	0001032889	Esslinger Str.	3/1	70771	f	\N	\N
21	pbkdf2_sha256$216000$1uonZaTJs6Pw$XiMULJKVlWLR+p1KHiSLH3rbmCQSGzhrJX4yN/GHXh8=	\N	f	christoph.dahlmann@gwg-gruppe.de	f	t	2021-01-27 09:10:44+00	t	1958-04-19	Stuttgart	Angelika	Ostrowski-Kicherer	015228706421	12347488684	0001051370	Heusteigstraße	20	70182	f	\N	\N
28	pbkdf2_sha256$216000$g303X77OA2Di$7YDHEnf8a8jQyHm29AwEhJ7wNlumk6W8Dzpd2c2NINg=	2021-04-12 13:14:26.129071+00	f	test@gwg-gruppe.de	f	t	2021-02-12 09:31:16+00	t	1900-12-14	Stuttgart	Sybille	Heintz	999999999	0711/6574040	0002021682	Bauernwaldstrasse	5	70195	f	\N	\N
38	pbkdf2_sha256$216000$taXe7FG2CPUQ$95HwA/TZMTBaV/jM4lKHPe+JK/cieyRf8gHd4ePhdDc=	\N	f	dustin.nowosad@dit-digital.de	f	t	2021-04-27 10:46:47.629876+00	f	\N	Stuttgart	Inna	Henning	01520767211		0004006987	Rostocker Str.	51/396	70376	f	\N	\N
39	pbkdf2_sha256$216000$9YF2zqQWqtlr$6laniFPusqKjnBnIsqvSgmteQo8sqD58NwcUL40pUHA=	\N	f	nowosad@gmx.net	f	t	2021-04-27 12:52:28.951157+00	f	\N	Stuttgart	Christian	Schokker	0177 3883490	0711-541588	0002025518	Rostocker Str.	53/477	70376	f	\N	\N
\.


--
-- Data for Name: gwg_tenant_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gwg_tenant_user_groups (id, user_id, group_id) FROM stdin;
2	9	1
6	13	1
13	21	1
14	22	1
17	25	1
18	28	1
22	32	1
27	37	1
28	38	1
29	39	1
\.


--
-- Data for Name: gwg_tenant_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gwg_tenant_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: issues_issue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.issues_issue (id, "group", display_location, title, html, background, background2, attachment, version, signing_type, description, sorting, codegrp, code, type, visible_role_id, category, description_postman) FROM stdin;
54	\N	1	Genehmigung	<html></html>				1.0	\N	<p>Sie m&ouml;chten ein Haustier in Ihrer Wohnung halten? Gerne pr&uuml;fen wir f&uuml;r Sie eine Genehmigung, die Sie hier beantragen k&ouml;nnen.&nbsp;</p><p>Hinweis: F&uuml;r Kleintiere (Meerschweinchen, Hamster, Kaninchen etc.) ben&ouml;tigen Sie keine Genehmigung von uns.&nbsp;</p><p>Bitte geben Sie an, um welche Art von Tier es sich handelt und wie viele Tiere Sie in Ihren Haushalt aufnehmen m&ouml;chten. &nbsp;</p>	1	\N	Mieter App: Genehmigung zur Tierhaltung	PROCESS	\N	Genehmigung zur Tierhaltung	Vielen Dank für Ihre Anfrage!\n\nWir werden Ihr Anliegen umgehend bearbeiten und informieren Sie, sobald Ihr Dokument verfügbar ist.
48	\N	1	Wohnungsgeberbestätigung	<html></html>				1.0	\N	<p>Sie m&ouml;chten Ihren Wohnsitz ummelden, oder ben&ouml;tigen f&uuml;r andere Zwecke eine Wohnungsgeberbest&auml;tigung? Hier k&ouml;nnen Sie diese anfordern:</p>	1	\N	Mieter App: Anforderung einer Wohnungsgeberbestätigung	PROCESS	\N	Anforderung einer Wohnungsgeberbestätigung	Vielen Dank für Ihre Anfrage!\n\nWir werden Ihr Anliegen umgehend bearbeiten und informieren Sie, sobald Ihr Dokument verfügbar ist.
49	\N	1	Anpassung Vorauszahlung	<html></html>				1.0	\N	<p>Sie m&ouml;chten die H&ouml;he der Nebenkostenvorauszahlung anpassen? Gerne pr&uuml;fen wir im individuellen Fall, ob eine Senkung der Vorauszahlung m&ouml;glich ist. Eine Erh&ouml;hung nehmen wir auf Wunsch automatisch vor.</p>	1	\N	Mieter App: Anpassung Ihrer Nebenkostenvorauszahlung	PROCESS	\N	Anpassung Ihrer Nebenkostenvorauszahlungen	Vielen Dank für Ihre Anfrage!\n\nWir werden diese schnellstmöglich bearbeiten und uns per E-Mail mit Ihnen in Verbindung setzen.
50	\N	1	Änderung Stammdaten	<html></html>				1.0	\N	<p>Sie m&ouml;chten eine weitere Person in Ihren Mietvertrag mit aufnehmen? Hierzu ist eine Zustimmung aller Vertragspartner in Form eines Nachtrags zum Mietvertrag erforderlich. Gerne nehmen wir Ihr Anliegen entgegen und senden Ihnen nach erfolgreicher Pr&uuml;fung die erforderlichen Unterlagen zu. Ihr Kundenbetreuer wird sich f&uuml;r weitere Informationen mit Ihnen in Verbindung setzen, sobald die Anfrage abgeschickt wurde.</p>	1	\N	Mieter App: Aufnahme weiterer Personen in Ihren Mietvertrag	PROCESS	\N	Aufnahme weiterer Personen in Ihren Mietvertrag	Vielen Dank für Ihre Anfrage!\n\nWir werden diese schnellstmöglich bearbeiten und uns per E-Mail mit Ihnen in Verbindung setzen.
51	\N	1	Auszahlung Guthaben	<html></html>				1.0	\N	<p>Gerne zahlen wir Ihnen Ihr Guthaben auf dem Mieterkonto aus. Sofern uns ein SEPA-Mandat f&uuml;r Ihren Mietvertrag vorliegt, wird Ihr Guthaben mit der n&auml;chsten Mietzahlung verrechnet.&nbsp;</p><p>Sie haben keinen automatischen Bankeinzug erteilt? Geben Sie bitte im untenstehenden Feld Ihre Bankdaten an, damit wir Ihr Guthaben schnellstm&ouml;glich &uuml;berweisen k&ouml;nnen.</p>	1	\N	Mieter App: Auszahlung Guthaben	PROCESS	\N	Auszahlung Ihres Guthabens	Vielen Dank für Ihre Anfrage!\n\nWir werden Ihr Anliegen umgehend bearbeiten und Informieren Sie, sobald Ihr Dokument verfügbar ist.
53	\N	1	Mieter App: Einsicht Mietvertrag	<html></html>				1.0	\N	<p>Gerne gew&auml;hren wir Ihnen Einsicht in Ihren Mietvertrag. Ihr Kundenbetreuer wird Ihnen diesen unter &quot;Mein Mietvertrag&quot; in der Service &Uuml;bersicht bereitstellen, sobald Sie diesen angefordert haben. Wir bitten um Geduld.&nbsp;</p>	1	\N	Mieter App: Einsicht in Ihren Mietvertrag	PROCESS	\N	Einsicht in Ihren Mietvertrag	
55	\N	1	Genehmigung	<html></html>				1.0	\N	<p>Um Ihre Mietwohnung und/ oder Stellplatz unterzuvermieten, ben&ouml;tigen Sie eine Genehmigung Ihres Vermieters. Bitte beachten Sie, dass wir f&uuml;r den erh&ouml;hten Aufwand im Zusammenhang mit der Verwaltung von Untermietverh&auml;ltnissen einen monatlichen Untermietzuschlag von 25 Euro berechnen.&nbsp;</p>	1	\N	Mieter App: Genehmigung zur Untervermietung	PROCESS	\N	Genehmigung zur Untervermietung	Vielen Dank für Ihre Anfrage!\n\nWir werden diese schnellstmöglich bearbeiten und uns per E-Mail mit Ihnen in Verbindung setzen.
56	\N	1	Schlüssel- /Zylinderbestellung	<html></html>				1.0	\N	<p>M&ouml;chten Sie zus&auml;tzliche Schl&uuml;ssel bestellen oder haben Sie einen Schl&uuml;ssel verloren? Bitte geben Sie hier den Grund Ihrer Bestellung und die notwendigen Informationen zu dem neuen Schl&uuml;ssel an. Beachten Sie, dass eine Bestellung zu Lasten der Mieterin/ des Mieters erfolgt.</p>	1	\N	Mieter App: Schlüsselbestellung	PROCESS	\N	Schlüsselbestellung	Vielen Dank für Ihre Anfrage!\n\nWir werden diese schnellstmöglich bearbeiten und uns per E-Mail mit Ihnen in Verbindung setzen.
58	\N	1	Bankverbindung	<html></html>				1.0	\N	<p>Ihre Bankverbindung hat sich ge&aumlndert?&nbsp</p><p>F&uumlr den Bankeinzug Ihrer Miete ben&oumltigen wir immer ein aktuelles SEPA-Lastschriftmandat, damit der Mieteinzug ohne Probleme funktioniert. Sofern Sie Ihre Miete selbst &uumlberweisen, ben&oumltigen wir keine Auskunft von Ihnen.&nbsp</p><p><br></p><p>Hier k&oumlnnen Sie das SEPA-Lastschriftmandat anfordern:</p>	1	\N	Mieter App: Änderung Ihrer Bankverbindung	PROCESS	\N	Änderung Ihrer Bankverbindung	Vielen Dank für Ihre Anfrage!\n\nWir werden Ihr Anliegen umgehend bearbeiten und informieren Sie, sobald Ihr Dokument verfügbar ist.
57	\N	1	Vorschlag Nachmieter	<html></html>				1.0	\N	<p>Sie haben Ihren Mietvertrag gek&uuml;ndigt und m&ouml;chten einen potentiellen Nachmieter vorschlagen? Gerne k&ouml;nnen Sie uns im Kontaktfeld Ihr Anliegen n&auml;her beschreiben. </p>	1	\N	Mieter App: Vorschlag eines Nachmieters	PROCESS	\N	Einen Nachmieter vorschlagen	Vielen Dank für Ihre Anfrage!\n\nWir werden diese schnellstmöglich bearbeiten und uns per E-Mail mit Ihnen in Verbindung setzen.
47	\N	1	Allgemeine Auskünfte	<html></html>				1.0	\N	<p>Sie ben&ouml;tigen eine Mietbescheinigung zur Vorlage bei unterschiedlichen Beh&ouml;rden?&nbsp;</p><p><br></p><p>Hier k&ouml;nnen Sie diese anfordern:&nbsp;</p><p><br></p><p>TEST Nachricht</p>	1	\N	Mieter App: Anforderung einer Mietbescheinigung	PROCESS	\N	Anforderung einer Mietbescheinigung	Vielen Dank für Ihre Anfrage!\n\nWir werden Ihr Anliegen umgehend bearbeiten und informieren Sie, sobald Ihr Dokument verfügbar ist.
61	\N	1	Mieter App: Profil bearbeiten	<html></html>				1.0	\N	<p><strong>Anliegen aus der Mieter App:</strong></p><p><br></p><p>Der Mieter hat seine hinterlegte Telefonnummer angepasst. Bitte &auml;ndern Sie die Stammdaten in SAP und schlie&szlig;en Sie das Ticket ab. Es ist keine Best&auml;tigung f&uuml;r den Mieter notwendig.</p>	1	\N	Mieter App: Neue E-Mail-Adresse	PROCESS	\N	Profil bearbeiten	
62	\N	1	Mieter App: Profil bearbeiten	<html></html>				1.0	\N	<p><strong>Anliegen aus der Mieter App:</strong></p><p><br></p><p>Der Mieter hat seine hinterlegte Telefonnummer angepasst. Bitte &auml;ndern Sie die Stammdaten in SAP und schlie&szlig;en Sie das Ticket ab. Es ist keine Best&auml;tigung f&uuml;r den Mieter notwendig.</p>	1	\N	Mieter App: Neue Handynummer	PROCESS	\N	Profil bearbeiten	
63	\N	1	Mieter App: Profil bearbeiten	<html></html>				1.0	\N	<p><strong>Anliegen aus der Mieter App:</strong></p><p><br></p><p>Der Mieter hat seine hinterlegte Telefonnummer angepasst. Bitte &auml;ndern Sie die Stammdaten in SAP und schlie&szlig;en Sie das Ticket ab. Es ist keine Best&auml;tigung f&uuml;r den Mieter notwendig.</p>	1	\N	Mieter App: Neue Telefonnummer	PROCESS	\N	Profil bearbeiten	
52	\N	1	Ratenzahlungsvereinbarung	<html></html>				1.0	\N	<p>Sie haben Schwierigkeiten mit der Mietzahlung? Gerne pr&uuml;fen wir im individuellen Fall eine Ratenzahlung oder tempor&auml;re Stundung der aktuellen Miete. Bitte beachten Sie unsere Kriterien f&uuml;r den Abschluss einer Ratenzahlungsvereinbarung:&nbsp;</p><p>- Mindesth&ouml;he von 30 Euro pro Rate&nbsp;</p><p>- Mindestens 6 Monate Mietvertragslaufzeit</p><p>- Maximal 6 Raten&nbsp;</p><p>- Keine offenen Kautionsforderungen</p><p>- Keine Zahlungs- und Verhaltensauff&auml;lligkeiten&nbsp;</p><p>Hinweis: Wir sind gesetzlich nicht verpflichtet, einer Ratenzahlungsvereinbarung zuzustimmen.&nbsp;</p><p><br></p>	1	\N	Mieter App: Beantragung einer Ratenzahlungsvereinbarung	PROCESS	\N	Beantragung einer Ratenzahlungsvereinbarung	Vielen Dank für Ihre Anfrage!\r\nTest Test\r\nWir werden diese schnellstmöglich bearbeiten und uns per E-Mail mit Ihnen in Verbindung setzen.
\.


--
-- Data for Name: issues_issueanswer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.issues_issueanswer (id, question, type, multi, marker, answers, sorting, required, issue_id, code) FROM stdin;
38	Gewünschte Höhe der monatlichen Vorauszahlung: (EUR)	8	f		\N	1	f	49	NUMBER_Gew_nschte_H_
39	Ihre Bankdaten:	1	f		\N	1	f	51	TEXT_Bankdaten_
54	Rasse:	1	f	<html><html>	\N	1	t	54	TEXT_Rasse_
55	Wunschtermin: Start der neuen Vorauszahlung am	2	f	<html><html>	\N	1	f	49	DATE_Wunschtermin__S
41	Art des Haustieres:	5	f		Hund;Katze	1	t	54	SEFCOMBO_Art_des_Hau
42	Anzahl der Haustiere:	1	f		\N	1	t	54	TEXT_Anzahl_der_Haus
47	Neue Telefonnummer:	1	f		\N	1	f	61	TEXT_Neue_Telefonnum
48	Telefonnummer in SAP geändert?	4	f		\N	1	f	61	CHECKBOX_Telefonnumm
49	Neue Telefonnummer:	1	f		\N	1	f	62	TEXT_Neue_Telefonnum
50	Telefonnummer in SAP geändert?	4	f		\N	1	f	62	CHECKBOX_Telefonnumm
51	Neue Telefonnummer:	1	f		\N	1	f	63	TEXT_Neue_Telefonnum
52	Telefonnummer in SAP geändert?	4	f		\N	1	f	63	CHECKBOX_Telefonnumm
43	Grund der Bestellung:	5	f		Alter Schlüssel defekt;Schlüssel verloren;Sonstiges;Zusätzlicher Schlüssel	1	f	56	SEFCOMBO_Grund_der_B
44	Schlüsselnummer (falls bekannt):	1	f		\N	1	f	56	TEXT_Schl_sselnumme1
53	Kontaktfeld:	1	f		\N	1	f	57	TEXT_Vorschlag_Nachm
40	Mietvertrag freigegeben?	4	f		\N	1	f	53	CHECKBOX_Mietvertrag
45	Vorschlag Nachmieter:	1	f		\N	1	t	57	TEXT_Vorschlag_Nachm
\.


--
-- Data for Name: issues_issuerequested; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.issues_issuerequested (id, created_at, updated_at, answers, status, issue_id, user_id, code) FROM stdin;
126	2021-02-15 15:34:29.949441+00	2021-02-15 15:34:32.548651+00	{}	ticket created	47	7	64-210215-Q0003
127	2021-02-15 16:07:51.953892+00	2021-02-15 16:07:53.571668+00	{}	ticket created	48	7	64-210215-Q0004
129	2021-02-15 17:18:31.294457+00	2021-02-15 17:18:32.878993+00	{"41":"Hund"}	ticket created	54	7	64-210215-Q0006
132	2021-02-15 17:26:27.789073+00	2021-02-15 17:26:29.161725+00	{}	ticket created	57	28	64-210215-Q0009
135	2021-02-15 17:33:53.068019+00	2021-02-15 17:33:54.558475+00	{"41":"Katze"}	ticket created	54	7	64-210215-Q0012
138	2021-02-15 17:37:48.706909+00	2021-02-15 17:37:49.825915+00	{}	ticket created	47	7	64-210215-Q0015
141	2021-02-16 07:16:49.163517+00	2021-02-16 07:16:52.321685+00	{}	ticket created	47	7	64-210216-Q0002
144	2021-02-16 12:56:50.605852+00	2021-02-16 12:56:53.851102+00	{}	ticket created	47	7	64-210216-Q0006
105	2021-02-08 13:01:44.743136+00	2021-02-08 13:01:47.45849+00	{}	ticket created	\N	25	64-210208-Q0003
107	2021-02-08 13:13:36.221457+00	2021-02-08 13:13:41.592236+00	{}	ticket created	\N	25	64-210208-Q0005
109	2021-02-10 15:37:17.571403+00	2021-02-10 15:37:19.093428+00	{}	ticket created	\N	25	64-210210-Q0003
111	2021-02-10 17:17:32.628878+00	2021-02-10 17:17:34.281646+00	{}	ticket created	\N	25	64-210210-Q0006
113	2021-02-10 18:30:53.703899+00	2021-02-10 18:30:55.194794+00	{}	ticket created	\N	7	64-210210-Q0008
115	2021-02-11 09:18:57.617891+00	2021-02-11 09:18:59.579257+00	{}	ticket created	\N	25	64-210211-Q0003
117	2021-02-11 09:21:05.154091+00	2021-02-11 09:21:09.186896+00	{}	ticket created	\N	25	64-210211-Q0006
119	2021-02-11 10:36:41.396879+00	2021-02-11 10:36:51.090842+00	{}	ticket created	\N	25	64-210211-Q0008
121	2021-02-11 16:54:24.216671+00	2021-02-11 16:54:24.216721+00	"Name": Test User	true	\N	1	\N
59	2021-01-25 18:59:37.007669+00	2021-01-25 18:59:39.320874+00	{}	ticket created	\N	\N	64-210125-Q0001
60	2021-01-26 14:29:42.129993+00	2021-01-26 14:29:44.758972+00	{"16":"Katze"}	ticket created	\N	\N	64-210126-Q0001
61	2021-01-26 14:29:43.555988+00	2021-01-26 14:29:44.775872+00	{"16":"Katze"}	ticket created	\N	\N	64-210126-Q0002
62	2021-01-26 14:29:44.489957+00	2021-01-26 14:29:45.711826+00	{"16":"Katze"}	ticket created	\N	\N	64-210126-Q0003
63	2021-01-26 14:30:07.817142+00	2021-01-26 14:30:08.879252+00	{}	ticket created	\N	\N	64-210126-Q0004
64	2021-01-26 14:30:48.87285+00	2021-01-26 14:30:55.404289+00	{}	ticket created	\N	\N	64-210126-Q0005
65	2021-01-26 14:30:49.942309+00	2021-01-26 14:30:55.422727+00	{}	ticket created	\N	\N	64-210126-Q0006
66	2021-01-26 14:30:51.120768+00	2021-01-26 14:30:55.436656+00	{}	ticket created	\N	\N	64-210126-Q0007
145	2021-02-16 14:05:58.005633+00	2021-02-16 14:06:27.706695+00	{}	ticket created	47	7	64-210216-Q0007
148	2021-02-16 14:17:09.538296+00	2021-02-16 14:17:11.006182+00	{}	ticket created	47	7	64-210216-Q0010
151	2021-02-16 14:30:26.735748+00	2021-02-16 14:30:28.386156+00	{"43":"Sonstiges"}	ticket created	56	7	64-210216-Q0013
154	2021-02-16 14:49:36.359502+00	2021-02-16 14:49:37.708112+00	{}	ticket created	47	21	64-210216-Q0016
56	2021-01-23 14:17:46.205852+00	2021-01-23 14:17:47.967222+00	{}	ticket created	\N	7	64-210123-Q0006
157	2021-02-16 15:10:13.128834+00	2021-02-16 15:10:14.911322+00	{"41":"Hund"}	ticket created	54	7	64-210216-Q0019
1	2021-01-06 08:21:20.698989+00	2021-01-06 08:21:20.699034+00		pending	\N	1	\N
2	2021-01-07 15:53:22.712496+00	2021-01-07 15:53:22.712539+00			\N	1	\N
3	2021-01-07 16:00:05.955941+00	2021-01-07 16:00:05.955985+00			\N	7	\N
4	2021-01-07 16:04:32.666108+00	2021-01-07 16:04:32.666155+00			\N	7	\N
5	2021-01-07 16:05:55.70354+00	2021-01-07 16:05:55.703636+00			\N	7	\N
6	2021-01-07 16:27:28.131065+00	2021-01-07 16:27:28.131141+00	\N	\N	\N	7	\N
7	2021-01-07 16:28:59.379717+00	2021-01-07 16:28:59.379771+00	\N	\N	\N	7	\N
8	2021-01-07 19:43:27.881226+00	2021-01-07 19:43:27.881348+00	\N	\N	\N	7	\N
9	2021-01-07 19:46:10.203994+00	2021-01-07 19:46:10.204047+00	\N	\N	\N	7	\N
10	2021-01-07 19:48:05.761759+00	2021-01-07 19:48:05.761911+00	\N	\N	\N	7	\N
11	2021-01-07 19:48:55.450201+00	2021-01-07 19:48:55.450253+00	\N	\N	\N	7	\N
12	2021-01-07 19:52:20.672656+00	2021-01-07 19:52:20.672734+00	\N	\N	\N	7	\N
13	2021-01-07 20:04:32.748975+00	2021-01-07 20:04:32.749074+00	\N	\N	\N	7	\N
14	2021-01-07 20:10:02.48548+00	2021-01-07 20:10:02.485549+00	\N	\N	\N	7	\N
15	2021-01-07 20:13:55.53607+00	2021-01-07 20:13:55.536145+00	\N	\N	\N	7	\N
16	2021-01-07 20:25:12.375537+00	2021-01-07 20:25:12.375623+00	\N	\N	\N	7	\N
17	2021-01-07 20:28:21.91894+00	2021-01-07 20:28:21.918995+00	\N	\N	\N	7	\N
18	2021-01-07 20:29:03.418156+00	2021-01-07 20:29:03.418207+00	\N	\N	\N	7	\N
19	2021-01-07 20:29:13.969968+00	2021-01-07 20:29:13.970022+00	\N	\N	\N	7	\N
20	2021-01-08 15:47:08.955871+00	2021-01-08 15:47:08.955933+00	\N	\N	\N	7	\N
21	2021-01-08 16:51:50.212587+00	2021-01-08 16:51:50.212638+00	\N	\N	\N	7	\N
22	2021-01-08 16:52:24.161064+00	2021-01-08 16:52:24.161116+00	\N	\N	\N	7	\N
23	2021-01-11 20:43:56.777374+00	2021-01-11 20:43:56.777492+00	\N	\N	\N	7	\N
24	2021-01-11 20:45:03.919079+00	2021-01-11 20:45:03.919174+00	\N	\N	\N	7	\N
25	2021-01-12 09:02:19.392826+00	2021-01-12 09:02:19.392912+00	{"2":1,"4":"Test"}	\N	\N	7	\N
26	2021-01-12 11:03:10.364169+00	2021-01-12 11:03:10.3643+00	{}	\N	\N	7	\N
27	2021-01-12 13:38:33.139262+00	2021-01-12 13:38:33.139336+00	{}	\N	\N	7	\N
28	2021-01-12 16:59:09.262399+00	2021-01-12 16:59:09.262515+00	{"7":"Carlo "}	\N	\N	7	\N
29	2021-01-12 17:57:56.215721+00	2021-01-12 17:57:56.215871+00	{}	\N	\N	7	\N
30	2021-01-13 16:30:45.449213+00	2021-01-13 16:30:45.449315+00	{}	\N	\N	7	\N
31	2021-01-13 18:58:03.418697+00	2021-01-13 18:58:03.418755+00	{}	\N	\N	7	\N
32	2021-01-13 19:01:37.020697+00	2021-01-13 19:01:37.020782+00	{}	\N	\N	7	\N
33	2021-01-14 16:09:53.395638+00	2021-01-14 16:09:53.39574+00	{"2":0,"3":"Anwaltskosten  Kosten für Miet- und Räumungsklagen","4":"Test"}	\N	\N	7	\N
34	2021-01-14 16:10:37.009912+00	2021-01-14 16:10:37.009967+00	{}	\N	\N	7	\N
35	2021-01-14 18:38:56.559358+00	2021-01-14 18:38:56.559498+00	{}	\N	\N	7	\N
36	2021-01-14 18:52:54.635128+00	2021-01-14 18:52:54.635186+00	{}	\N	\N	7	\N
37	2021-01-14 18:53:39.637166+00	2021-01-14 18:53:39.637237+00	{"2":0,"3":"Anwaltskosten Gebäudehaftpflicht"}	\N	\N	7	\N
38	2021-01-14 18:53:49.585645+00	2021-01-14 18:53:49.585752+00	{}	\N	\N	7	\N
39	2021-01-14 18:55:09.448327+00	2021-01-14 18:55:09.448408+00	{}	\N	\N	7	\N
40	2021-01-14 19:30:15.983186+00	2021-01-14 19:30:15.983247+00	{}	\N	\N	7	\N
41	2021-01-14 21:49:44.030997+00	2021-01-14 21:49:44.031139+00	{}	\N	\N	7	\N
42	2021-01-14 21:53:35.146178+00	2021-01-14 21:53:35.146284+00	{}	\N	\N	7	\N
43	2021-01-14 22:03:37.52493+00	2021-01-14 22:03:37.524992+00	{"8":"Schlüssel verloren","9":"1234567"}	\N	\N	7	\N
44	2021-01-14 22:05:49.579827+00	2021-01-14 22:05:49.579879+00	{"2":0,"3":"Anwaltskosten Gebäudehaftpflicht"}	\N	\N	7	\N
45	2021-01-15 09:06:17.223719+00	2021-01-15 09:06:17.223849+00	{}	\N	\N	7	\N
46	2021-01-15 09:36:33.102709+00	2021-01-15 09:36:33.102854+00	{"7":"Test"}	\N	\N	7	\N
158	2021-02-17 07:55:03.934228+00	2021-02-17 07:55:05.816597+00	{}	ticket created	47	7	64-210217-Q0001
161	2021-02-17 08:03:31.216425+00	2021-02-17 08:03:33.61691+00	{"41":"Hund"}	ticket created	54	7	64-210217-Q0004
162	2021-02-17 08:17:34.915939+00	2021-02-17 08:17:36.221159+00	{}	ticket created	47	7	64-210217-Q0005
164	2021-02-17 08:22:49.435407+00	2021-02-17 08:22:50.845574+00	{"41":"Hund"}	ticket created	54	7	64-210217-Q0007
167	2021-02-17 08:30:03.455713+00	2021-02-17 08:30:04.841971+00	{"41":"Katze"}	ticket created	54	7	64-210217-Q0010
123	2021-02-12 12:45:47.095439+00	2021-02-12 12:45:47.095483+00	Test	In Bearbeitung	\N	1	\N
170	2021-02-17 09:59:21.616151+00	2021-02-17 09:59:25.997125+00	{"41":"Katze"}	ticket created	54	7	64-210217-Q0013
173	2021-02-17 12:36:11.987316+00	2021-02-17 12:36:14.381423+00	{}	ticket created	58	25	64-210217-Q0017
176	2021-02-17 12:55:51.94466+00	2021-02-17 12:55:53.67829+00	{"43":"Schlüssel verloren"}	ticket created	56	25	64-210217-Q0020
179	2021-02-17 13:08:10.083248+00	2021-02-17 13:08:11.255359+00	{}	ticket created	48	25	64-210217-Q0023
47	2021-01-22 10:16:35.538432+00	2021-01-22 10:16:35.538486+00	{"1": "test"}		\N	\N	\N
48	2021-01-23 13:55:36.912956+00	2021-01-23 13:55:36.913101+00	{"26": "Hund"}		\N	7	\N
49	2021-01-23 13:56:26.02307+00	2021-01-23 13:56:26.023148+00	{"26": "Hund"}		\N	7	\N
50	2021-01-23 13:56:57.736772+00	2021-01-23 13:56:57.736854+00	{"26": "Hund"}		\N	7	\N
51	2021-01-23 14:00:13.778161+00	2021-01-23 14:00:13.778221+00	{"26": "Hund"}		\N	7	\N
52	2021-01-23 14:01:32.658808+00	2021-01-23 14:01:33.915005+00	{"26": "Hund"}	ticket created	\N	7	64-210123-Q0002
53	2021-01-23 14:09:36.160479+00	2021-01-23 14:09:37.673673+00	{"26": "Hund"}	ticket created	\N	7	64-210123-Q0003
54	2021-01-23 14:10:41.608943+00	2021-01-23 14:10:42.875871+00	{"26": "Katze"}	ticket created	\N	7	64-210123-Q0004
57	2021-01-23 14:18:02.031571+00	2021-01-23 14:18:03.221362+00	{}	ticket created	\N	7	64-210123-Q0008
58	2021-01-23 14:23:42.229484+00	2021-01-23 14:23:43.654014+00	{"26": "Katze"}	ticket created	\N	7	64-210123-Q0009
124	2021-02-12 13:07:24.865186+00	2021-02-12 13:07:26.900089+00	{"38":"25"}	ticket created	49	7	64-210212-Q0006
128	2021-02-15 16:10:36.081779+00	2021-02-15 16:10:37.594367+00	{"41":"Katze"}	ticket created	54	7	64-210215-Q0005
130	2021-02-15 17:25:43.816208+00	2021-02-15 17:25:45.273096+00	{"41":"Katze"}	ticket created	54	7	64-210215-Q0007
133	2021-02-15 17:29:51.1806+00	2021-02-15 17:29:52.651507+00	{"41":"Katze"}	ticket created	54	7	64-210215-Q0010
136	2021-02-15 17:37:05.529243+00	2021-02-15 17:37:07.040485+00	{"41":"Katze"}	ticket created	54	7	64-210215-Q0013
139	2021-02-15 17:48:34.077444+00	2021-02-15 17:48:35.409796+00	{}	ticket created	48	28	64-210215-Q0016
142	2021-02-16 07:22:16.442714+00	2021-02-16 07:22:17.991052+00	{}	ticket created	48	7	64-210216-Q0003
146	2021-02-16 14:15:12.889394+00	2021-02-16 14:15:15.155899+00	{}	ticket created	47	28	64-210216-Q0008
149	2021-02-16 14:22:53.318125+00	2021-02-16 14:22:55.113323+00	{"41":"Katze"}	ticket created	54	7	64-210216-Q0011
152	2021-02-16 14:35:01.358799+00	2021-02-16 14:35:02.803271+00	{"43":"Schlüssel verloren"}	ticket created	56	7	64-210216-Q0014
155	2021-02-16 14:52:29.625499+00	2021-02-16 14:52:30.973025+00	{}	ticket created	47	7	64-210216-Q0017
159	2021-02-17 07:58:41.994629+00	2021-02-17 07:58:43.496864+00	{"41":"Katze"}	ticket created	54	7	64-210217-Q0002
163	2021-02-17 08:17:59.368138+00	2021-02-17 08:18:01.061233+00	{"41":"Katze"}	ticket created	54	7	64-210217-Q0006
165	2021-02-17 08:23:41.66424+00	2021-02-17 08:23:42.996981+00	{}	ticket created	47	21	64-210217-Q0008
168	2021-02-17 08:32:47.801074+00	2021-02-17 08:32:49.202157+00	{"43":"Sonstiges"}	ticket created	56	7	64-210217-Q0011
171	2021-02-17 10:01:43.388085+00	2021-02-17 10:01:49.630229+00	{"41":"Hund"}	ticket created	54	25	64-210217-Q0014
174	2021-02-17 12:38:49.608215+00	2021-02-17 12:38:51.438159+00	{}	ticket created	55	25	64-210217-Q0018
177	2021-02-17 13:06:50.787774+00	2021-02-17 13:06:52.366072+00	{"43":"Schlüssel verloren"}	ticket created	56	25	64-210217-Q0021
180	2021-02-17 13:08:30.219307+00	2021-02-17 13:08:31.603506+00	{"38":"100"}	ticket created	49	25	64-210217-Q0024
182	2021-02-17 13:09:10.955793+00	2021-02-17 13:09:12.152601+00	{}	ticket created	51	25	64-210217-Q0026
67	2021-01-26 14:30:52.487695+00	2021-01-26 14:30:55.483762+00	{}	ticket created	\N	\N	64-210126-Q0008
55	2021-01-23 14:17:06.860642+00	2021-01-23 14:17:07.942202+00	{}	ticket created	\N	7	64-210123-Q0005
68	2021-01-26 14:30:55.502664+00	2021-01-26 14:30:56.630038+00	{}	ticket created	\N	\N	64-210126-Q0009
70	2021-01-26 14:31:21.086305+00	2021-01-26 14:31:33.15347+00	{"18":"Sonstiges"}	ticket created	\N	\N	64-210126-Q0012
71	2021-01-26 14:31:25.308055+00	2021-01-26 14:31:33.456672+00	{"18":"Sonstiges"}	ticket created	\N	\N	64-210126-Q0011
69	2021-01-26 14:31:19.942273+00	2021-01-26 14:31:33.522093+00	{"18":"Sonstiges"}	ticket created	\N	\N	64-210126-Q0010
72	2021-01-26 14:31:31.822337+00	2021-01-26 14:31:33.962219+00	{"18":"Sonstiges"}	ticket created	\N	\N	64-210126-Q0013
73	2021-01-26 14:34:32.544314+00	2021-01-26 14:34:33.817216+00	{}	ticket created	\N	\N	64-210126-Q0015
74	2021-01-26 14:41:39.489704+00	2021-01-26 14:41:40.632352+00	{}	ticket created	\N	\N	64-210126-Q0016
75	2021-01-26 14:46:01.420545+00	2021-01-26 14:46:02.457746+00	{}	ticket created	\N	\N	64-210126-Q0017
184	2021-02-17 14:45:55.654891+00	2021-02-17 14:45:57.689287+00	{"38":"9999"}	ticket created	49	7	64-210217-Q0028
76	2021-01-28 08:52:19.992151+00	2021-01-28 08:52:23.186322+00	{"16":0}	ticket created	\N	22	64-210128-Q0002
106	2021-02-08 13:13:29.487229+00	2021-02-08 13:13:41.639965+00	{}	ticket created	\N	25	64-210208-Q0004
77	2021-01-28 08:52:23.724972+00	2021-01-28 08:52:24.930752+00	{"16":"Katze"}	ticket created	\N	22	64-210128-Q0003
78	2021-01-28 08:52:34.773176+00	2021-01-28 08:52:36.92216+00	{}	ticket created	\N	22	64-210128-Q0004
108	2021-02-10 15:32:27.639879+00	2021-02-10 15:32:30.980548+00	{}	ticket created	\N	25	64-210210-Q0002
79	2021-01-28 10:22:32.907064+00	2021-01-28 10:22:36.001157+00	{}	ticket created	\N	22	64-210128-Q0005
110	2021-02-10 16:56:51.548468+00	2021-02-10 16:56:52.971295+00	{}	ticket created	\N	25	64-210210-Q0005
80	2021-01-29 11:01:03.850893+00	2021-01-29 11:01:07.125715+00	{}	ticket created	\N	22	64-210129-Q0001
81	2021-01-29 11:09:27.688528+00	2021-01-29 11:09:28.898341+00	{}	ticket created	\N	22	64-210129-Q0002
112	2021-02-10 18:29:46.83895+00	2021-02-10 18:29:48.468439+00	{}	ticket created	\N	7	64-210210-Q0007
82	2021-01-29 11:10:08.407142+00	2021-01-29 11:10:09.501545+00	{}	ticket created	\N	22	64-210129-Q0003
83	2021-01-29 11:10:40.029307+00	2021-01-29 11:10:41.123922+00	{}	ticket created	\N	22	64-210129-Q0004
114	2021-02-10 18:34:28.670291+00	2021-02-10 18:34:30.224128+00	{}	ticket created	\N	7	64-210210-Q0009
84	2021-01-29 11:11:17.080632+00	2021-01-29 11:11:18.13802+00	{}	ticket created	\N	22	64-210129-Q0005
85	2021-01-29 11:11:38.502359+00	2021-01-29 11:11:39.569288+00	{}	ticket created	\N	22	64-210129-Q0006
86	2021-01-29 11:12:36.06751+00	2021-01-29 11:12:37.308855+00	{"16":"Hund"}	ticket created	\N	22	64-210129-Q0007
118	2021-02-11 09:21:06.974281+00	2021-02-11 09:21:09.392991+00	{}	ticket created	\N	25	64-210211-Q0005
87	2021-01-29 11:13:00.225336+00	2021-01-29 11:13:01.264797+00	{}	ticket created	\N	22	64-210129-Q0008
116	2021-02-11 09:21:03.941485+00	2021-02-11 09:21:09.455532+00	{}	ticket created	\N	25	64-210211-Q0004
88	2021-01-29 11:13:45.053103+00	2021-01-29 11:13:46.313736+00	{"18":"Alter Schlüssel defekt"}	ticket created	\N	22	64-210129-Q0009
89	2021-01-29 11:14:46.293194+00	2021-01-29 11:14:47.515649+00	{}	ticket created	\N	22	64-210129-Q0010
122	2021-02-11 16:54:53.628926+00	2021-02-11 16:54:53.628972+00	Test	true	\N	1	\N
120	2021-02-11 10:37:44.132068+00	2021-02-11 10:37:45.538364+00	{}	ticket created	\N	25	64-210211-Q0009
90	2021-02-01 08:30:47.532507+00	2021-02-01 08:30:50.14882+00	{}	ticket created	\N	21	64-210201-Q0001
91	2021-02-01 12:56:34.020625+00	2021-02-01 12:56:37.587404+00	{}	ticket created	\N	21	64-210201-Q0005
96	2021-02-03 12:37:09.117178+00	2021-02-03 12:37:12.263936+00	{"16":"Hund"}	ticket created	\N	21	64-210203-Q0002
97	2021-02-03 12:37:10.530701+00	2021-02-03 12:37:12.290706+00	{"16":"Hund"}	ticket created	\N	21	64-210203-Q0003
98	2021-02-03 12:38:36.352163+00	2021-02-03 12:38:37.869105+00	{}	ticket created	\N	21	64-210203-Q0004
99	2021-02-03 12:38:48.694213+00	2021-02-03 12:38:49.976467+00	{}	ticket created	\N	21	64-210203-Q0005
100	2021-02-03 13:04:23.219724+00	2021-02-03 13:04:24.91212+00	{"16":"Katze"}	ticket created	\N	21	64-210203-Q0006
92	2021-02-02 08:37:17.058374+00	2021-02-02 08:37:18.926561+00	{"18":"Schlüssel verloren"}	ticket created	\N	\N	64-210202-Q0001
93	2021-02-02 08:37:18.196413+00	2021-02-02 08:37:19.459109+00	{"18":"Schlüssel verloren"}	ticket created	\N	\N	64-210202-Q0002
94	2021-02-02 08:37:50.171102+00	2021-02-02 08:37:51.270517+00	{}	ticket created	\N	\N	64-210202-Q0003
95	2021-02-02 08:38:02.846324+00	2021-02-02 08:38:03.949607+00	{}	ticket created	\N	\N	64-210202-Q0004
101	2021-02-05 12:48:20.57063+00	2021-02-05 12:48:24.599772+00	{}	ticket created	\N	7	64-210205-Q0001
102	2021-02-05 12:48:22.986416+00	2021-02-05 12:48:24.633587+00	{}	ticket created	\N	7	64-210205-Q0002
103	2021-02-08 07:51:34.519158+00	2021-02-08 07:51:39.285723+00	{}	ticket created	\N	25	64-210208-Q0001
104	2021-02-08 07:52:37.919832+00	2021-02-08 07:52:39.544408+00	{"16":"Hund"}	ticket created	\N	25	64-210208-Q0002
131	2021-02-15 17:25:48.441007+00	2021-02-15 17:25:49.790541+00	{}	ticket created	47	28	64-210215-Q0008
134	2021-02-15 17:31:54.293591+00	2021-02-15 17:31:55.820031+00	{"41":"Katze"}	ticket created	54	7	64-210215-Q0011
137	2021-02-15 17:37:37.037765+00	2021-02-15 17:37:38.337024+00	{"40":0}	ticket created	53	7	64-210215-Q0014
140	2021-02-16 06:12:04.362828+00	2021-02-16 06:12:07.315406+00	{}	ticket created	47	7	64-210216-Q0001
143	2021-02-16 10:07:55.603023+00	2021-02-16 10:07:59.19325+00	{}	ticket created	49	28	64-210216-Q0004
147	2021-02-16 14:16:55.90241+00	2021-02-16 14:16:58.210178+00	{}	ticket created	47	7	64-210216-Q0009
150	2021-02-16 14:27:28.642138+00	2021-02-16 14:27:29.937968+00	{}	ticket created	54	25	64-210216-Q0012
153	2021-02-16 14:44:56.680588+00	2021-02-16 14:44:57.831279+00	{}	ticket created	47	28	64-210216-Q0015
156	2021-02-16 14:53:20.352322+00	2021-02-16 14:53:21.510082+00	{}	ticket created	47	7	64-210216-Q0018
160	2021-02-17 08:00:45.375078+00	2021-02-17 08:00:46.651972+00	{}	ticket created	47	21	64-210217-Q0003
166	2021-02-17 08:24:37.001435+00	2021-02-17 08:24:38.787833+00	{"41":"Katze"}	ticket created	54	7	64-210217-Q0009
125	2021-02-12 13:08:33.401637+00	2021-02-12 13:08:34.554454+00	{}	ticket created	\N	7	64-210212-Q0007
169	2021-02-17 09:58:42.25099+00	2021-02-17 09:58:44.842833+00	{"41":"Katze"}	ticket created	54	7	64-210217-Q0012
172	2021-02-17 10:17:40.17828+00	2021-02-17 10:17:41.728178+00	{}	ticket created	57	25	64-210217-Q0015
175	2021-02-17 12:54:45.424979+00	2021-02-17 12:54:47.153952+00	{"40":1}	ticket created	53	25	64-210217-Q0019
178	2021-02-17 13:07:33.188979+00	2021-02-17 13:07:34.543621+00	{}	ticket created	47	25	64-210217-Q0022
181	2021-02-17 13:08:38.851824+00	2021-02-17 13:08:40.102247+00	{}	ticket created	50	25	64-210217-Q0025
183	2021-02-17 13:09:26.082374+00	2021-02-17 13:09:26.949769+00	{}	ticket created	52	25	64-210217-Q0027
\.


--
-- Data for Name: push_notifications_apnsdevice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.push_notifications_apnsdevice (id, name, active, date_created, device_id, registration_id, user_id, application_id) FROM stdin;
3	Apple iPhone 6+	t	2021-01-22 12:48:15.390158+00	ffffffff-ffff-ffff-ffff-ffffffffffff	AEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAE	7	\N
4	Apple iPhone 6+	t	2021-01-22 12:48:33.826282+00	ffffffff-ffff-ffff-ffff-ffffffffffff	AEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAE	7	\N
13	iPhone	t	2021-01-26 13:09:33.932685+00	4763b11d-c0d4-4f10-9154-66d7348b8e02	0f5c91e224ba6d29aec8c518a7a2dffc5e48109bfc4afc895b0a9ea6e3d78b3a	7	4763B11D-C0D4-4F10-9154-66D7348B8E02
\.


--
-- Data for Name: push_notifications_gcmdevice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.push_notifications_gcmdevice (id, name, active, date_created, device_id, registration_id, user_id, cloud_message_type, application_id) FROM stdin;
\.


--
-- Data for Name: push_notifications_webpushdevice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.push_notifications_webpushdevice (id, name, active, date_created, application_id, registration_id, p256dh, auth, browser, user_id) FROM stdin;
\.


--
-- Data for Name: push_notifications_wnsdevice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.push_notifications_wnsdevice (id, name, active, date_created, device_id, registration_id, user_id, application_id) FROM stdin;
\.


--
-- Data for Name: real_estate_contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.real_estate_contract (id, code, number, company_code, economic_unit, building, type, type_name, description, city, city_district, date_from, date_to, is_active, rental_contract, rental_unit, street, street_number, zip_code) FROM stdin;
13	2000.10171.0028.05	\N	\N	\N	\N	\N	Mietvertrag Wohnung	Birgül Yazici-Esslinger Straße 3/1-3. Obergeschoss rechts	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
15	2000.10171.0028.05	\N	\N	\N	\N	\N	Mietvertrag Wohnung	Birgül Yazici-Esslinger Straße 3/1-3. Obergeschoss rechts	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
35	8590.87310.0120.01	8590.87310.0120.01	8590	87310	0002	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Bauernwaldstraße 5	Stuttgart-Botnang		2005-05-20	9999-12-31	t	87310.0120.01	0120	Bauernwaldstraße	5	70195
8	8590.87310.0120.01	8590.87310.0120.01	8590	87310	0002	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Bauernwaldstraße 5	Stuttgart-Botnang	\N	2005-05-20	9999-12-31	t	87310.0120.01	0120	Bauernwaldstraße	5	70195
19	8590.87310.0120.01	\N	\N	\N	\N	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Bauernwaldstraße 5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
20	8590.87310.0507.01	\N	\N	\N	\N	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Tiefgarage	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
41	8590.87310.0507.01	\N	\N	\N	\N	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Tiefgarage	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
21	8590.87310.0506.01	\N	\N	\N	\N	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Tiefgarage	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	8590.87310.0506.01	\N	\N	\N	\N	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Tiefgarage	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
18	2000.10171.0028.05	\N	\N	\N	\N	\N	Mietvertrag Wohnung	Birgül Yazici-Esslinger Straße 3/1-3. Obergeschoss rechts	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
28	2000.10171.0028.05	\N	\N	\N	\N	\N	Mietvertrag Wohnung	Birgül Yazici-Esslinger Straße 3/1-3. Obergeschoss rechts	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
34	2000.10171.0028.05	\N	\N	\N	\N	\N	Mietvertrag Wohnung	Birgül Yazici-Esslinger Straße 3/1-3. Obergeschoss rechts	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	2500.16004.0396.04	2500.16004.0396.04	2500	16004	0010	\N	\N	\N	Stuttgart		2018-10-16	9999-12-31	t	16004.0396.04	0396	Rostocker Straße	51	70376
23	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
1	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
2	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
12	2000.10171.0610.01	\N	\N	\N	\N	\N	Mietvertrag Garage/Stellplatz	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	2000.10171.0610.01	\N	\N	\N	\N	\N	Mietvertrag Garage/Stellplatz	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
17	2000.10171.0610.01	\N	\N	\N	\N	\N	Mietvertrag Garage/Stellplatz	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
27	2000.10171.0610.01	\N	\N	\N	\N	\N	Mietvertrag Garage/Stellplatz	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
33	2000.10171.0610.01	\N	\N	\N	\N	\N	Mietvertrag Garage/Stellplatz	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
29	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
9	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
31	2000.10171.0028.05	\N	\N	\N	\N	\N	Mietvertrag Wohnung	Birgül Yazici-Esslinger Straße 3/1-3. Obergeschoss rechts	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
37	8590.87310.0506.01	\N	\N	\N	\N	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Tiefgarage	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	2500.16004.0477.01	2500.16004.0477.01	2500	16004	0011	\N	\N	\N	Stuttgart		1989-05-01	9999-12-31	t	16004.0477.01	0477	Rostocker Straße	53	70376
4	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
5	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
6	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
30	2000.10171.0610.01	\N	\N	\N	\N	\N	Mietvertrag Garage/Stellplatz	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
26	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
16	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
40	8590.87310.0120.01	8590.87310.0120.01	8590	87310	0002	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Bauernwaldstraße 5	Stuttgart-Botnang		2005-05-20	9999-12-31	t	87310.0120.01	0120	Bauernwaldstraße	5	70195
45	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
38	8590.87310.0120.01	8590.87310.0120.01	8590	87310	0002	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Bauernwaldstraße 5	Stuttgart-Botnang		2005-05-20	9999-12-31	t	87310.0120.01	0120	Bauernwaldstraße	5	70195
39	8590.87310.0120.01	8590.87310.0120.01	8590	87310	0002	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Bauernwaldstraße 5	Stuttgart-Botnang		2005-05-20	9999-12-31	t	87310.0120.01	0120	Bauernwaldstraße	5	70195
36	8590.87310.0507.01	\N	\N	\N	\N	\N	Hausgeldvertrag (WEG)	Sybille Heintz / Stuttgart-Botnang, Tiefgarage	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
11	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
48	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
3	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
22	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
24	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
25	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
32	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
43	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
46	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
51	2500.16004.0166.03	2500.16004.0166.03	2500	16004	0002	\N	\N	\N	Stuttgart		2016-08-16	9999-12-31	t	16004.0166.03	0166	Rostocker Straße	52	70376
7	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
10	2050.10847.0135.02	2050.10847.0135.02	2050	10847	0017	\N	Mietvertrag Wohnung	Angelika Ostrowski-Kicherer / Stuttgart, Rostocker Str. 41	Stuttgart		2012-11-01	2018-04-30	f	10847.0135.02	0135	Rostocker Straße	41	70376
47	2000.10171.0026.04	2000.10171.0026.04	2000	10171	0002	\N	Mietvertrag Wohnung	Birgül Yazici / Leinf.-Echterdingen, Esslinger Str. 3/1	Leinf.-Echterdingen		2007-02-05	2020-08-15	f	10171.0026.04	0026	Esslinger Straße	3/1	70771
\.


--
-- Data for Name: real_estate_contract_partners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.real_estate_contract_partners (id, contract_id, user_id) FROM stdin;
4	4	7
6	6	9
26	25	21
27	26	22
28	27	22
29	28	22
33	32	25
34	33	25
35	34	25
36	35	28
37	36	28
38	37	28
44	43	32
49	48	37
50	49	38
51	50	39
\.


--
-- Data for Name: real_estate_property; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.real_estate_property (id, company_code, entity, object, street, number, zip, city, center) FROM stdin;
\.


--
-- Data for Name: survey_survey; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.survey_survey (id, title, text, text2, dialog, visible_object, date_from, date_to, is_active, member) FROM stdin;
1	Umfrage Test 1.2.0	das ist eine Testumfrage	Vielen Dank für Ihre Teilnahme an der Umfrage bitte senden sie die Umfrage ab.	Test MSG	\N	\N	\N	t	0
\.


--
-- Data for Name: survey_surveyanswerstext; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.survey_surveyanswerstext (id, answer1, answer2, answer3, answer4, answer5, answer6, question_id, user_id) FROM stdin;
9	True	False	False				1	7
10	False	True	False				2	7
11	True	False	False				1	7
12	False	False	True				2	7
13	True	False	False				1	7
14	False	True	False				2	7
15	True	False	False				1	7
16	False	True	False				2	7
17	False	False	False				1	7
18	False	False	False				2	7
\.


--
-- Data for Name: survey_surveymembers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.survey_surveymembers (id, survey_id, user_id) FROM stdin;
\.


--
-- Data for Name: survey_surveyquestion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.survey_surveyquestion (id, question, multi, sorting, answer1, type1, count1, answer2, type2, count2, answer3, type3, count3, answer4, type4, count4, answer5, type5, count5, answer6, type6, count6, survey_id) FROM stdin;
2	Frage 2: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,	f	0	Lorem ipsum dolor sit amet, consetetur sadipscing	1	0	et, consetetur sadipscing	1	7	nein	1	3	\N	\N	0	\N	\N	0	\N	\N	0	1
1	Frage 1: am erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,	f	0	1	1	8	2	1	2	3	1	3	\N	\N	0	\N	\N	0	\N	\N	0	1
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 160, true);


--
-- Name: chat_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_session_id_seq', 9, true);


--
-- Name: content_faq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_faq_id_seq', 10, true);


--
-- Name: content_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_news_id_seq', 15, true);


--
-- Name: content_news_property_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_news_property_id_seq', 1, false);


--
-- Name: content_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_offer_id_seq', 4, true);


--
-- Name: content_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_page_id_seq', 2, true);


--
-- Name: defect_area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_area_id_seq', 1, false);


--
-- Name: defect_area_visible_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_area_visible_groups_id_seq', 1, false);


--
-- Name: defect_defect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_defect_id_seq', 1, false);


--
-- Name: defect_defect_visible_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_defect_visible_groups_id_seq', 1, false);


--
-- Name: defect_defectresolutionrating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_defectresolutionrating_id_seq', 1, false);


--
-- Name: defect_defecttype_areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_defecttype_areas_id_seq', 1, false);


--
-- Name: defect_defecttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_defecttype_id_seq', 1, false);


--
-- Name: defect_defecttype_visible_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_defecttype_visible_groups_id_seq', 1, false);


--
-- Name: defect_reporteddefect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_reporteddefect_id_seq', 1, false);


--
-- Name: dit_push_notifications_pushnotifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dit_push_notifications_pushnotifications_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 209, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 40, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 86, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.easy_thumbnails_source_id_seq', 1, false);


--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.easy_thumbnails_thumbnail_id_seq', 1, false);


--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.easy_thumbnails_thumbnaildimensions_id_seq', 1, false);


--
-- Name: gwg_tenant_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gwg_tenant_user_groups_id_seq', 30, true);


--
-- Name: gwg_tenant_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gwg_tenant_user_id_seq', 40, true);


--
-- Name: gwg_tenant_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gwg_tenant_user_user_permissions_id_seq', 240, true);


--
-- Name: issues_issue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.issues_issue_id_seq', 63, true);


--
-- Name: issues_issueanswer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.issues_issueanswer_id_seq', 55, true);


--
-- Name: issues_issuerequested_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.issues_issuerequested_id_seq', 184, true);


--
-- Name: push_notifications_apnsdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.push_notifications_apnsdevice_id_seq', 14, true);


--
-- Name: push_notifications_gcmdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.push_notifications_gcmdevice_id_seq', 2, true);


--
-- Name: push_notifications_webpushdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.push_notifications_webpushdevice_id_seq', 1, false);


--
-- Name: push_notifications_wnsdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.push_notifications_wnsdevice_id_seq', 1, false);


--
-- Name: real_estate_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.real_estate_contract_id_seq', 51, true);


--
-- Name: real_estate_contract_partners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.real_estate_contract_partners_id_seq', 52, true);


--
-- Name: survey_survey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.survey_survey_id_seq', 1, true);


--
-- Name: survey_surveyanswerstext_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.survey_surveyanswerstext_id_seq', 18, true);


--
-- Name: survey_surveymembers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.survey_surveymembers_id_seq', 1, false);


--
-- Name: survey_surveyquestion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.survey_surveyquestion_id_seq', 2, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authentication_local_invitationtoken authentication_local_invitationtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_local_invitationtoken
    ADD CONSTRAINT authentication_local_invitationtoken_pkey PRIMARY KEY (token);


--
-- Name: authentication_local_passwordresettoken authentication_local_passwordresettoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_local_passwordresettoken
    ADD CONSTRAINT authentication_local_passwordresettoken_pkey PRIMARY KEY (token);


--
-- Name: authentication_local_verificationtoken authentication_local_verificationtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_local_verificationtoken
    ADD CONSTRAINT authentication_local_verificationtoken_pkey PRIMARY KEY (token);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: chat_session chat_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_session
    ADD CONSTRAINT chat_session_pkey PRIMARY KEY (id);


--
-- Name: content_faq content_faq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_faq
    ADD CONSTRAINT content_faq_pkey PRIMARY KEY (id);


--
-- Name: content_news content_news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_news
    ADD CONSTRAINT content_news_pkey PRIMARY KEY (id);


--
-- Name: content_news_property content_news_property_news_id_property_id_fcbafa75_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_news_property
    ADD CONSTRAINT content_news_property_news_id_property_id_fcbafa75_uniq UNIQUE (news_id, property_id);


--
-- Name: content_news_property content_news_property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_news_property
    ADD CONSTRAINT content_news_property_pkey PRIMARY KEY (id);


--
-- Name: content_offer content_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_offer
    ADD CONSTRAINT content_offer_pkey PRIMARY KEY (id);


--
-- Name: content_page content_page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_page
    ADD CONSTRAINT content_page_pkey PRIMARY KEY (id);


--
-- Name: defect_area defect_area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_area
    ADD CONSTRAINT defect_area_pkey PRIMARY KEY (id);


--
-- Name: defect_area_visible_groups defect_area_visible_groups_area_id_group_id_b4f9cbc3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_area_visible_groups
    ADD CONSTRAINT defect_area_visible_groups_area_id_group_id_b4f9cbc3_uniq UNIQUE (area_id, group_id);


--
-- Name: defect_area_visible_groups defect_area_visible_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_area_visible_groups
    ADD CONSTRAINT defect_area_visible_groups_pkey PRIMARY KEY (id);


--
-- Name: defect_defect defect_defect_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect
    ADD CONSTRAINT defect_defect_pkey PRIMARY KEY (id);


--
-- Name: defect_defect_visible_groups defect_defect_visible_groups_defect_id_group_id_7cdcb29e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect_visible_groups
    ADD CONSTRAINT defect_defect_visible_groups_defect_id_group_id_7cdcb29e_uniq UNIQUE (defect_id, group_id);


--
-- Name: defect_defect_visible_groups defect_defect_visible_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect_visible_groups
    ADD CONSTRAINT defect_defect_visible_groups_pkey PRIMARY KEY (id);


--
-- Name: defect_defectresolutionrating defect_defectresolutionrating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defectresolutionrating
    ADD CONSTRAINT defect_defectresolutionrating_pkey PRIMARY KEY (id);


--
-- Name: defect_defecttype_areas defect_defecttype_areas_defecttype_id_area_id_0201629e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_areas
    ADD CONSTRAINT defect_defecttype_areas_defecttype_id_area_id_0201629e_uniq UNIQUE (defecttype_id, area_id);


--
-- Name: defect_defecttype_areas defect_defecttype_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_areas
    ADD CONSTRAINT defect_defecttype_areas_pkey PRIMARY KEY (id);


--
-- Name: defect_defecttype defect_defecttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype
    ADD CONSTRAINT defect_defecttype_pkey PRIMARY KEY (id);


--
-- Name: defect_defecttype_visible_groups defect_defecttype_visibl_defecttype_id_group_id_2572c4aa_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_visible_groups
    ADD CONSTRAINT defect_defecttype_visibl_defecttype_id_group_id_2572c4aa_uniq UNIQUE (defecttype_id, group_id);


--
-- Name: defect_defecttype_visible_groups defect_defecttype_visible_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_visible_groups
    ADD CONSTRAINT defect_defecttype_visible_groups_pkey PRIMARY KEY (id);


--
-- Name: defect_reporteddefect defect_reporteddefect_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_reporteddefect
    ADD CONSTRAINT defect_reporteddefect_pkey PRIMARY KEY (id);


--
-- Name: dit_push_notifications_pushnotifications dit_push_notifications_pushnotifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dit_push_notifications_pushnotifications
    ADD CONSTRAINT dit_push_notifications_pushnotifications_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source easy_thumbnails_source_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source easy_thumbnails_source_storage_hash_name_481ce32d_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_storage_hash_name_481ce32d_uniq UNIQUE (storage_hash, name);


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thumbnai_storage_hash_name_source_fb375270_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnai_storage_hash_name_source_fb375270_uniq UNIQUE (storage_hash, name, source_id);


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thumbnail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thumbnaildimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thumbnaildimensions_thumbnail_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_thumbnail_id_key UNIQUE (thumbnail_id);


--
-- Name: gwg_tenant_tenant gwg_tenant_tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_tenant
    ADD CONSTRAINT gwg_tenant_tenant_pkey PRIMARY KEY (partnerid);


--
-- Name: gwg_tenant_user gwg_tenant_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user
    ADD CONSTRAINT gwg_tenant_user_email_key UNIQUE (email);


--
-- Name: gwg_tenant_user_groups gwg_tenant_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_groups
    ADD CONSTRAINT gwg_tenant_user_groups_pkey PRIMARY KEY (id);


--
-- Name: gwg_tenant_user_groups gwg_tenant_user_groups_user_id_group_id_02b29e66_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_groups
    ADD CONSTRAINT gwg_tenant_user_groups_user_id_group_id_02b29e66_uniq UNIQUE (user_id, group_id);


--
-- Name: gwg_tenant_user gwg_tenant_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user
    ADD CONSTRAINT gwg_tenant_user_pkey PRIMARY KEY (id);


--
-- Name: gwg_tenant_user_user_permissions gwg_tenant_user_user_per_user_id_permission_id_044e78ba_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_user_permissions
    ADD CONSTRAINT gwg_tenant_user_user_per_user_id_permission_id_044e78ba_uniq UNIQUE (user_id, permission_id);


--
-- Name: gwg_tenant_user_user_permissions gwg_tenant_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_user_permissions
    ADD CONSTRAINT gwg_tenant_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: issues_issue issues_issue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issue
    ADD CONSTRAINT issues_issue_pkey PRIMARY KEY (id);


--
-- Name: issues_issueanswer issues_issueanswer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issueanswer
    ADD CONSTRAINT issues_issueanswer_pkey PRIMARY KEY (id);


--
-- Name: issues_issuerequested issues_issuerequested_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issuerequested
    ADD CONSTRAINT issues_issuerequested_pkey PRIMARY KEY (id);


--
-- Name: push_notifications_apnsdevice push_notifications_apnsdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_apnsdevice
    ADD CONSTRAINT push_notifications_apnsdevice_pkey PRIMARY KEY (id);


--
-- Name: push_notifications_gcmdevice push_notifications_gcmdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_gcmdevice
    ADD CONSTRAINT push_notifications_gcmdevice_pkey PRIMARY KEY (id);


--
-- Name: push_notifications_webpushdevice push_notifications_webpushdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_webpushdevice
    ADD CONSTRAINT push_notifications_webpushdevice_pkey PRIMARY KEY (id);


--
-- Name: push_notifications_wnsdevice push_notifications_wnsdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_wnsdevice
    ADD CONSTRAINT push_notifications_wnsdevice_pkey PRIMARY KEY (id);


--
-- Name: real_estate_contract_partners real_estate_contract_partners_contract_id_user_id_eb9562c6_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_contract_partners
    ADD CONSTRAINT real_estate_contract_partners_contract_id_user_id_eb9562c6_uniq UNIQUE (contract_id, user_id);


--
-- Name: real_estate_contract_partners real_estate_contract_partners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_contract_partners
    ADD CONSTRAINT real_estate_contract_partners_pkey PRIMARY KEY (id);


--
-- Name: real_estate_contract real_estate_contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_contract
    ADD CONSTRAINT real_estate_contract_pkey PRIMARY KEY (id);


--
-- Name: real_estate_property real_estate_property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_property
    ADD CONSTRAINT real_estate_property_pkey PRIMARY KEY (id);


--
-- Name: survey_survey survey_survey_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_survey
    ADD CONSTRAINT survey_survey_pkey PRIMARY KEY (id);


--
-- Name: survey_surveyanswerstext survey_surveyanswerstext_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveyanswerstext
    ADD CONSTRAINT survey_surveyanswerstext_pkey PRIMARY KEY (id);


--
-- Name: survey_surveymembers survey_surveymembers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveymembers
    ADD CONSTRAINT survey_surveymembers_pkey PRIMARY KEY (id);


--
-- Name: survey_surveyquestion survey_surveyquestion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveyquestion
    ADD CONSTRAINT survey_surveyquestion_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authentication_local_invitationtoken_token_8cb0265a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authentication_local_invitationtoken_token_8cb0265a_like ON public.authentication_local_invitationtoken USING btree (token varchar_pattern_ops);


--
-- Name: authentication_local_invitationtoken_user_id_09c7f9ab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authentication_local_invitationtoken_user_id_09c7f9ab ON public.authentication_local_invitationtoken USING btree (user_id);


--
-- Name: authentication_local_passwordresettoken_token_21683723_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authentication_local_passwordresettoken_token_21683723_like ON public.authentication_local_passwordresettoken USING btree (token varchar_pattern_ops);


--
-- Name: authentication_local_passwordresettoken_user_id_3d02bdc8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authentication_local_passwordresettoken_user_id_3d02bdc8 ON public.authentication_local_passwordresettoken USING btree (user_id);


--
-- Name: authentication_local_verificationtoken_token_c7cd18b5_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authentication_local_verificationtoken_token_c7cd18b5_like ON public.authentication_local_verificationtoken USING btree (token varchar_pattern_ops);


--
-- Name: authentication_local_verificationtoken_user_id_e4765647; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authentication_local_verificationtoken_user_id_e4765647 ON public.authentication_local_verificationtoken USING btree (user_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: content_faq_visible_role_id_3d129739; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_faq_visible_role_id_3d129739 ON public.content_faq USING btree (visible_role_id);


--
-- Name: content_news_kind_b5d9199a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_news_kind_b5d9199a ON public.content_news USING btree (kind);


--
-- Name: content_news_kind_b5d9199a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_news_kind_b5d9199a_like ON public.content_news USING btree (kind varchar_pattern_ops);


--
-- Name: content_news_property_news_id_16e2674d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_news_property_news_id_16e2674d ON public.content_news_property USING btree (news_id);


--
-- Name: content_news_property_property_id_ed5b98eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_news_property_property_id_ed5b98eb ON public.content_news_property USING btree (property_id);


--
-- Name: content_news_property_property_id_ed5b98eb_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_news_property_property_id_ed5b98eb_like ON public.content_news_property USING btree (property_id varchar_pattern_ops);


--
-- Name: content_offer_visible_role_id_d4892d38; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_offer_visible_role_id_d4892d38 ON public.content_offer USING btree (visible_role_id);


--
-- Name: defect_area_visible_groups_area_id_08a0661d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_area_visible_groups_area_id_08a0661d ON public.defect_area_visible_groups USING btree (area_id);


--
-- Name: defect_area_visible_groups_group_id_94866242; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_area_visible_groups_group_id_94866242 ON public.defect_area_visible_groups USING btree (group_id);


--
-- Name: defect_defect_area_id_dca4a156; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defect_area_id_dca4a156 ON public.defect_defect USING btree (area_id);


--
-- Name: defect_defect_defect_type_id_91d6f8af; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defect_defect_type_id_91d6f8af ON public.defect_defect USING btree (defect_type_id);


--
-- Name: defect_defect_visible_groups_defect_id_aef95951; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defect_visible_groups_defect_id_aef95951 ON public.defect_defect_visible_groups USING btree (defect_id);


--
-- Name: defect_defect_visible_groups_group_id_8d504cbb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defect_visible_groups_group_id_8d504cbb ON public.defect_defect_visible_groups USING btree (group_id);


--
-- Name: defect_defectresolutionrating_reported_defect_id_68c8583e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defectresolutionrating_reported_defect_id_68c8583e ON public.defect_defectresolutionrating USING btree (reported_defect_id);


--
-- Name: defect_defecttype_areas_area_id_49d98954; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defecttype_areas_area_id_49d98954 ON public.defect_defecttype_areas USING btree (area_id);


--
-- Name: defect_defecttype_areas_defecttype_id_e02b94ea; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defecttype_areas_defecttype_id_e02b94ea ON public.defect_defecttype_areas USING btree (defecttype_id);


--
-- Name: defect_defecttype_visible_groups_defecttype_id_3eb0c02c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defecttype_visible_groups_defecttype_id_3eb0c02c ON public.defect_defecttype_visible_groups USING btree (defecttype_id);


--
-- Name: defect_defecttype_visible_groups_group_id_b5ce4af7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_defecttype_visible_groups_group_id_b5ce4af7 ON public.defect_defecttype_visible_groups USING btree (group_id);


--
-- Name: defect_reporteddefect_contract_id_e0ed59c8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_reporteddefect_contract_id_e0ed59c8 ON public.defect_reporteddefect USING btree (contract_id);


--
-- Name: defect_reporteddefect_defect_id_1c225796; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_reporteddefect_defect_id_1c225796 ON public.defect_reporteddefect USING btree (defect_id);


--
-- Name: defect_reporteddefect_reported_by_id_1bf45a1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX defect_reporteddefect_reported_by_id_1bf45a1c ON public.defect_reporteddefect USING btree (reported_by_id);


--
-- Name: dit_push_notifications_pushnotifications_created_at_4b03ee57; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dit_push_notifications_pushnotifications_created_at_4b03ee57 ON public.dit_push_notifications_pushnotifications USING btree (created_at);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_name_5fe0edc6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_source_name_5fe0edc6 ON public.easy_thumbnails_source USING btree (name);


--
-- Name: easy_thumbnails_source_name_5fe0edc6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_source_name_5fe0edc6_like ON public.easy_thumbnails_source USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_storage_hash_946cbcc9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_source_storage_hash_946cbcc9 ON public.easy_thumbnails_source USING btree (storage_hash);


--
-- Name: easy_thumbnails_source_storage_hash_946cbcc9_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_source_storage_hash_946cbcc9_like ON public.easy_thumbnails_source USING btree (storage_hash varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_name_b5882c31; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_name_b5882c31 ON public.easy_thumbnails_thumbnail USING btree (name);


--
-- Name: easy_thumbnails_thumbnail_name_b5882c31_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_name_b5882c31_like ON public.easy_thumbnails_thumbnail USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_source_id_5b57bc77; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_source_id_5b57bc77 ON public.easy_thumbnails_thumbnail USING btree (source_id);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_f1435f49; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49 ON public.easy_thumbnails_thumbnail USING btree (storage_hash);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_f1435f49_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49_like ON public.easy_thumbnails_thumbnail USING btree (storage_hash varchar_pattern_ops);


--
-- Name: gwg_tenant_tenant_partnerid_3c2b8a89_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gwg_tenant_tenant_partnerid_3c2b8a89_like ON public.gwg_tenant_tenant USING btree (partnerid varchar_pattern_ops);


--
-- Name: gwg_tenant_user_email_5350ba23_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gwg_tenant_user_email_5350ba23_like ON public.gwg_tenant_user USING btree (email varchar_pattern_ops);


--
-- Name: gwg_tenant_user_groups_group_id_f6a5d2af; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gwg_tenant_user_groups_group_id_f6a5d2af ON public.gwg_tenant_user_groups USING btree (group_id);


--
-- Name: gwg_tenant_user_groups_user_id_7e66ccb1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gwg_tenant_user_groups_user_id_7e66ccb1 ON public.gwg_tenant_user_groups USING btree (user_id);


--
-- Name: gwg_tenant_user_user_permissions_permission_id_1903f98f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gwg_tenant_user_user_permissions_permission_id_1903f98f ON public.gwg_tenant_user_user_permissions USING btree (permission_id);


--
-- Name: gwg_tenant_user_user_permissions_user_id_3ffe6266; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gwg_tenant_user_user_permissions_user_id_3ffe6266 ON public.gwg_tenant_user_user_permissions USING btree (user_id);


--
-- Name: issues_issue_code_50c9a403; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_code_50c9a403 ON public.issues_issue USING btree (code);


--
-- Name: issues_issue_code_50c9a403_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_code_50c9a403_like ON public.issues_issue USING btree (code varchar_pattern_ops);


--
-- Name: issues_issue_codegrp_c440aa60; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_codegrp_c440aa60 ON public.issues_issue USING btree (codegrp);


--
-- Name: issues_issue_codegrp_c440aa60_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_codegrp_c440aa60_like ON public.issues_issue USING btree (codegrp varchar_pattern_ops);


--
-- Name: issues_issue_group_fc3894fa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_group_fc3894fa ON public.issues_issue USING btree ("group");


--
-- Name: issues_issue_group_fc3894fa_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_group_fc3894fa_like ON public.issues_issue USING btree ("group" varchar_pattern_ops);


--
-- Name: issues_issue_sapkind_0bbd7f49; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_sapkind_0bbd7f49 ON public.issues_issue USING btree (type);


--
-- Name: issues_issue_sapkind_0bbd7f49_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_sapkind_0bbd7f49_like ON public.issues_issue USING btree (type varchar_pattern_ops);


--
-- Name: issues_issue_title_7ad2642a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_title_7ad2642a ON public.issues_issue USING btree (title);


--
-- Name: issues_issue_title_7ad2642a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_title_7ad2642a_like ON public.issues_issue USING btree (title varchar_pattern_ops);


--
-- Name: issues_issue_version_0d51fd65; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_version_0d51fd65 ON public.issues_issue USING btree (version);


--
-- Name: issues_issue_version_0d51fd65_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_version_0d51fd65_like ON public.issues_issue USING btree (version varchar_pattern_ops);


--
-- Name: issues_issue_visible_role_id_bd86bdf3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issue_visible_role_id_bd86bdf3 ON public.issues_issue USING btree (visible_role_id);


--
-- Name: issues_issueanswer_answers_120e31fc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_answers_120e31fc ON public.issues_issueanswer USING btree (answers);


--
-- Name: issues_issueanswer_answers_120e31fc_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_answers_120e31fc_like ON public.issues_issueanswer USING btree (answers varchar_pattern_ops);


--
-- Name: issues_issueanswer_code_c677c498; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_code_c677c498 ON public.issues_issueanswer USING btree (code);


--
-- Name: issues_issueanswer_code_c677c498_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_code_c677c498_like ON public.issues_issueanswer USING btree (code varchar_pattern_ops);


--
-- Name: issues_issueanswer_issue_id_af152b16; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_issue_id_af152b16 ON public.issues_issueanswer USING btree (issue_id);


--
-- Name: issues_issueanswer_marker_d3cbf23a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_marker_d3cbf23a ON public.issues_issueanswer USING btree (marker);


--
-- Name: issues_issueanswer_marker_d3cbf23a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_marker_d3cbf23a_like ON public.issues_issueanswer USING btree (marker varchar_pattern_ops);


--
-- Name: issues_issueanswer_question_ae7416a2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_question_ae7416a2 ON public.issues_issueanswer USING btree (question);


--
-- Name: issues_issueanswer_question_ae7416a2_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_question_ae7416a2_like ON public.issues_issueanswer USING btree (question varchar_pattern_ops);


--
-- Name: issues_issueanswer_type_7b6f2781; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_type_7b6f2781 ON public.issues_issueanswer USING btree (type);


--
-- Name: issues_issueanswer_type_7b6f2781_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issueanswer_type_7b6f2781_like ON public.issues_issueanswer USING btree (type varchar_pattern_ops);


--
-- Name: issues_issuerequested_created_at_b25ed736; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issuerequested_created_at_b25ed736 ON public.issues_issuerequested USING btree (created_at);


--
-- Name: issues_issuerequested_issue_id_7e91830d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issuerequested_issue_id_7e91830d ON public.issues_issuerequested USING btree (issue_id);


--
-- Name: issues_issuerequested_updated_at_ec8b4663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issuerequested_updated_at_ec8b4663 ON public.issues_issuerequested USING btree (updated_at);


--
-- Name: issues_issuerequested_user_id_8cf3a08d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX issues_issuerequested_user_id_8cf3a08d ON public.issues_issuerequested USING btree (user_id);


--
-- Name: push_notifications_apnsdevice_device_id_0ac3cde3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_notifications_apnsdevice_device_id_0ac3cde3 ON public.push_notifications_apnsdevice USING btree (device_id);


--
-- Name: push_notifications_apnsdevice_user_id_44cc44d2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_notifications_apnsdevice_user_id_44cc44d2 ON public.push_notifications_apnsdevice USING btree (user_id);


--
-- Name: push_notifications_gcmdevice_device_id_0b22a9c4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_notifications_gcmdevice_device_id_0b22a9c4 ON public.push_notifications_gcmdevice USING btree (device_id);


--
-- Name: push_notifications_gcmdevice_user_id_f3752f1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_notifications_gcmdevice_user_id_f3752f1b ON public.push_notifications_gcmdevice USING btree (user_id);


--
-- Name: push_notifications_webpushdevice_user_id_e867e0a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_notifications_webpushdevice_user_id_e867e0a1 ON public.push_notifications_webpushdevice USING btree (user_id);


--
-- Name: push_notifications_wnsdevice_device_id_7e1c24c4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_notifications_wnsdevice_device_id_7e1c24c4 ON public.push_notifications_wnsdevice USING btree (device_id);


--
-- Name: push_notifications_wnsdevice_user_id_670eff0d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_notifications_wnsdevice_user_id_670eff0d ON public.push_notifications_wnsdevice USING btree (user_id);


--
-- Name: real_estate_contract_partners_contract_id_e480df5f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX real_estate_contract_partners_contract_id_e480df5f ON public.real_estate_contract_partners USING btree (contract_id);


--
-- Name: real_estate_contract_partners_user_id_b2cc0367; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX real_estate_contract_partners_user_id_b2cc0367 ON public.real_estate_contract_partners USING btree (user_id);


--
-- Name: real_estate_property_id_fdc74131_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX real_estate_property_id_fdc74131_like ON public.real_estate_property USING btree (id varchar_pattern_ops);


--
-- Name: survey_surveyanswerstext_question_id_c0bb76ed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyanswerstext_question_id_c0bb76ed ON public.survey_surveyanswerstext USING btree (question_id);


--
-- Name: survey_surveyanswerstext_user_id_6fdce769; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyanswerstext_user_id_6fdce769 ON public.survey_surveyanswerstext USING btree (user_id);


--
-- Name: survey_surveymembers_survey_id_51df8599; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveymembers_survey_id_51df8599 ON public.survey_surveymembers USING btree (survey_id);


--
-- Name: survey_surveymembers_user_id_8d6078b5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveymembers_user_id_8d6078b5 ON public.survey_surveymembers USING btree (user_id);


--
-- Name: survey_surveyquestion_survey_id_4d6b492c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_survey_id_4d6b492c ON public.survey_surveyquestion USING btree (survey_id);


--
-- Name: survey_surveyquestion_type1_d6a9365d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type1_d6a9365d ON public.survey_surveyquestion USING btree (type1);


--
-- Name: survey_surveyquestion_type1_d6a9365d_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type1_d6a9365d_like ON public.survey_surveyquestion USING btree (type1 varchar_pattern_ops);


--
-- Name: survey_surveyquestion_type2_f543b111; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type2_f543b111 ON public.survey_surveyquestion USING btree (type2);


--
-- Name: survey_surveyquestion_type2_f543b111_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type2_f543b111_like ON public.survey_surveyquestion USING btree (type2 varchar_pattern_ops);


--
-- Name: survey_surveyquestion_type3_45d91dec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type3_45d91dec ON public.survey_surveyquestion USING btree (type3);


--
-- Name: survey_surveyquestion_type3_45d91dec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type3_45d91dec_like ON public.survey_surveyquestion USING btree (type3 varchar_pattern_ops);


--
-- Name: survey_surveyquestion_type4_ad385e9d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type4_ad385e9d ON public.survey_surveyquestion USING btree (type4);


--
-- Name: survey_surveyquestion_type4_ad385e9d_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type4_ad385e9d_like ON public.survey_surveyquestion USING btree (type4 varchar_pattern_ops);


--
-- Name: survey_surveyquestion_type5_cc751667; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type5_cc751667 ON public.survey_surveyquestion USING btree (type5);


--
-- Name: survey_surveyquestion_type5_cc751667_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type5_cc751667_like ON public.survey_surveyquestion USING btree (type5 varchar_pattern_ops);


--
-- Name: survey_surveyquestion_type6_4cfc3996; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type6_4cfc3996 ON public.survey_surveyquestion USING btree (type6);


--
-- Name: survey_surveyquestion_type6_4cfc3996_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX survey_surveyquestion_type6_4cfc3996_like ON public.survey_surveyquestion USING btree (type6 varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authentication_local_invitationtoken authentication_local_user_id_09c7f9ab_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_local_invitationtoken
    ADD CONSTRAINT authentication_local_user_id_09c7f9ab_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authentication_local_passwordresettoken authentication_local_user_id_3d02bdc8_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_local_passwordresettoken
    ADD CONSTRAINT authentication_local_user_id_3d02bdc8_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authentication_local_verificationtoken authentication_local_user_id_e4765647_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_local_verificationtoken
    ADD CONSTRAINT authentication_local_user_id_e4765647_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_gwg_tenant_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_gwg_tenant_user_id FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_faq content_faq_visible_role_id_3d129739_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_faq
    ADD CONSTRAINT content_faq_visible_role_id_3d129739_fk_auth_group_id FOREIGN KEY (visible_role_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_news_property content_news_propert_property_id_ed5b98eb_fk_real_esta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_news_property
    ADD CONSTRAINT content_news_propert_property_id_ed5b98eb_fk_real_esta FOREIGN KEY (property_id) REFERENCES public.real_estate_property(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_news_property content_news_property_news_id_16e2674d_fk_content_news_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_news_property
    ADD CONSTRAINT content_news_property_news_id_16e2674d_fk_content_news_id FOREIGN KEY (news_id) REFERENCES public.content_news(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_offer content_offer_visible_role_id_d4892d38_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_offer
    ADD CONSTRAINT content_offer_visible_role_id_d4892d38_fk_auth_group_id FOREIGN KEY (visible_role_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_area_visible_groups defect_area_visible_groups_area_id_08a0661d_fk_defect_area_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_area_visible_groups
    ADD CONSTRAINT defect_area_visible_groups_area_id_08a0661d_fk_defect_area_id FOREIGN KEY (area_id) REFERENCES public.defect_area(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_area_visible_groups defect_area_visible_groups_group_id_94866242_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_area_visible_groups
    ADD CONSTRAINT defect_area_visible_groups_group_id_94866242_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defect defect_defect_area_id_dca4a156_fk_defect_area_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect
    ADD CONSTRAINT defect_defect_area_id_dca4a156_fk_defect_area_id FOREIGN KEY (area_id) REFERENCES public.defect_area(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defect defect_defect_defect_type_id_91d6f8af_fk_defect_defecttype_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect
    ADD CONSTRAINT defect_defect_defect_type_id_91d6f8af_fk_defect_defecttype_id FOREIGN KEY (defect_type_id) REFERENCES public.defect_defecttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defect_visible_groups defect_defect_visibl_defect_id_aef95951_fk_defect_de; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect_visible_groups
    ADD CONSTRAINT defect_defect_visibl_defect_id_aef95951_fk_defect_de FOREIGN KEY (defect_id) REFERENCES public.defect_defect(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defect_visible_groups defect_defect_visible_groups_group_id_8d504cbb_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defect_visible_groups
    ADD CONSTRAINT defect_defect_visible_groups_group_id_8d504cbb_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defectresolutionrating defect_defectresolut_reported_defect_id_68c8583e_fk_defect_re; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defectresolutionrating
    ADD CONSTRAINT defect_defectresolut_reported_defect_id_68c8583e_fk_defect_re FOREIGN KEY (reported_defect_id) REFERENCES public.defect_reporteddefect(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defecttype_areas defect_defecttype_ar_defecttype_id_e02b94ea_fk_defect_de; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_areas
    ADD CONSTRAINT defect_defecttype_ar_defecttype_id_e02b94ea_fk_defect_de FOREIGN KEY (defecttype_id) REFERENCES public.defect_defecttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defecttype_areas defect_defecttype_areas_area_id_49d98954_fk_defect_area_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_areas
    ADD CONSTRAINT defect_defecttype_areas_area_id_49d98954_fk_defect_area_id FOREIGN KEY (area_id) REFERENCES public.defect_area(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defecttype_visible_groups defect_defecttype_vi_defecttype_id_3eb0c02c_fk_defect_de; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_visible_groups
    ADD CONSTRAINT defect_defecttype_vi_defecttype_id_3eb0c02c_fk_defect_de FOREIGN KEY (defecttype_id) REFERENCES public.defect_defecttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_defecttype_visible_groups defect_defecttype_vi_group_id_b5ce4af7_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_defecttype_visible_groups
    ADD CONSTRAINT defect_defecttype_vi_group_id_b5ce4af7_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_reporteddefect defect_reporteddefec_contract_id_e0ed59c8_fk_real_esta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_reporteddefect
    ADD CONSTRAINT defect_reporteddefec_contract_id_e0ed59c8_fk_real_esta FOREIGN KEY (contract_id) REFERENCES public.real_estate_contract(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_reporteddefect defect_reporteddefec_reported_by_id_1bf45a1c_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_reporteddefect
    ADD CONSTRAINT defect_reporteddefec_reported_by_id_1bf45a1c_fk_gwg_tenan FOREIGN KEY (reported_by_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: defect_reporteddefect defect_reporteddefect_defect_id_1c225796_fk_defect_defect_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect_reporteddefect
    ADD CONSTRAINT defect_reporteddefect_defect_id_1c225796_fk_defect_defect_id FOREIGN KEY (defect_id) REFERENCES public.defect_defect(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_gwg_tenant_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_gwg_tenant_user_id FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thum_source_id_5b57bc77_fk_easy_thum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thum_source_id_5b57bc77_fk_easy_thum FOREIGN KEY (source_id) REFERENCES public.easy_thumbnails_source(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thum_thumbnail_id_c3a0c549_fk_easy_thum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thum_thumbnail_id_c3a0c549_fk_easy_thum FOREIGN KEY (thumbnail_id) REFERENCES public.easy_thumbnails_thumbnail(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gwg_tenant_user_groups gwg_tenant_user_groups_group_id_f6a5d2af_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_groups
    ADD CONSTRAINT gwg_tenant_user_groups_group_id_f6a5d2af_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gwg_tenant_user_groups gwg_tenant_user_groups_user_id_7e66ccb1_fk_gwg_tenant_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_groups
    ADD CONSTRAINT gwg_tenant_user_groups_user_id_7e66ccb1_fk_gwg_tenant_user_id FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gwg_tenant_user_user_permissions gwg_tenant_user_user_permission_id_1903f98f_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_user_permissions
    ADD CONSTRAINT gwg_tenant_user_user_permission_id_1903f98f_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gwg_tenant_user_user_permissions gwg_tenant_user_user_user_id_3ffe6266_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gwg_tenant_user_user_permissions
    ADD CONSTRAINT gwg_tenant_user_user_user_id_3ffe6266_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: issues_issue issues_issue_visible_role_id_bd86bdf3_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issue
    ADD CONSTRAINT issues_issue_visible_role_id_bd86bdf3_fk_auth_group_id FOREIGN KEY (visible_role_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: issues_issueanswer issues_issueanswer_issue_id_af152b16_fk_issues_issue_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issueanswer
    ADD CONSTRAINT issues_issueanswer_issue_id_af152b16_fk_issues_issue_id FOREIGN KEY (issue_id) REFERENCES public.issues_issue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: issues_issuerequested issues_issuerequested_issue_id_7e91830d_fk_issues_issue_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issuerequested
    ADD CONSTRAINT issues_issuerequested_issue_id_7e91830d_fk_issues_issue_id FOREIGN KEY (issue_id) REFERENCES public.issues_issue(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: issues_issuerequested issues_issuerequested_user_id_8cf3a08d_fk_gwg_tenant_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues_issuerequested
    ADD CONSTRAINT issues_issuerequested_user_id_8cf3a08d_fk_gwg_tenant_user_id FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: push_notifications_apnsdevice push_notifications_a_user_id_44cc44d2_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_apnsdevice
    ADD CONSTRAINT push_notifications_a_user_id_44cc44d2_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: push_notifications_gcmdevice push_notifications_g_user_id_f3752f1b_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_gcmdevice
    ADD CONSTRAINT push_notifications_g_user_id_f3752f1b_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: push_notifications_wnsdevice push_notifications_w_user_id_670eff0d_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_wnsdevice
    ADD CONSTRAINT push_notifications_w_user_id_670eff0d_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: push_notifications_webpushdevice push_notifications_w_user_id_e867e0a1_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_notifications_webpushdevice
    ADD CONSTRAINT push_notifications_w_user_id_e867e0a1_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: real_estate_contract_partners real_estate_contract_contract_id_e480df5f_fk_real_esta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_contract_partners
    ADD CONSTRAINT real_estate_contract_contract_id_e480df5f_fk_real_esta FOREIGN KEY (contract_id) REFERENCES public.real_estate_contract(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: real_estate_contract_partners real_estate_contract_user_id_b2cc0367_fk_gwg_tenan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_contract_partners
    ADD CONSTRAINT real_estate_contract_user_id_b2cc0367_fk_gwg_tenan FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: survey_surveyanswerstext survey_surveyanswers_question_id_c0bb76ed_fk_survey_su; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveyanswerstext
    ADD CONSTRAINT survey_surveyanswers_question_id_c0bb76ed_fk_survey_su FOREIGN KEY (question_id) REFERENCES public.survey_surveyquestion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: survey_surveyanswerstext survey_surveyanswerstext_user_id_6fdce769_fk_gwg_tenant_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveyanswerstext
    ADD CONSTRAINT survey_surveyanswerstext_user_id_6fdce769_fk_gwg_tenant_user_id FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: survey_surveymembers survey_surveymembers_survey_id_51df8599_fk_survey_survey_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveymembers
    ADD CONSTRAINT survey_surveymembers_survey_id_51df8599_fk_survey_survey_id FOREIGN KEY (survey_id) REFERENCES public.survey_survey(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: survey_surveymembers survey_surveymembers_user_id_8d6078b5_fk_gwg_tenant_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveymembers
    ADD CONSTRAINT survey_surveymembers_user_id_8d6078b5_fk_gwg_tenant_user_id FOREIGN KEY (user_id) REFERENCES public.gwg_tenant_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: survey_surveyquestion survey_surveyquestion_survey_id_4d6b492c_fk_survey_survey_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.survey_surveyquestion
    ADD CONSTRAINT survey_surveyquestion_survey_id_4d6b492c_fk_survey_survey_id FOREIGN KEY (survey_id) REFERENCES public.survey_survey(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

