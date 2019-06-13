--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.8
-- Dumped by pg_dump version 9.6.8

-- Started on 2018-06-17 20:00:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 199 (class 1259 OID 24665)
-- Name: card_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.card_options (
    card_option_id character(36) NOT NULL,
    card_id integer NOT NULL,
    vendor_branch_id character(36) NOT NULL
);


ALTER TABLE public.card_options OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 24626)
-- Name: cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cards (
    card_id integer NOT NULL,
    name character varying(255) DEFAULT 'Nome Cartão'::character varying NOT NULL,
    flag_id character varying(255) DEFAULT 'Flag ID'::character varying NOT NULL
);


ALTER TABLE public.cards OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 24624)
-- Name: cards_card_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cards_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cards_card_id_seq OWNER TO postgres;

--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 194
-- Name: cards_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cards_card_id_seq OWNED BY public.cards.card_id;


--
-- TOC entry 188 (class 1259 OID 24589)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    city_id integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    estado_id integer NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 24587)
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_city_id_seq OWNER TO postgres;

--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 187
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;


--
-- TOC entry 186 (class 1259 OID 24579)
-- Name: estados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados (
    estado_id integer NOT NULL,
    nome character varying(255) DEFAULT ''::character varying NOT NULL,
    uf character(2) DEFAULT ''::bpchar NOT NULL
);


ALTER TABLE public.estados OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 24577)
-- Name: estados_estado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estados_estado_id_seq OWNER TO postgres;

--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 185
-- Name: estados_estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_estado_id_seq OWNED BY public.estados.estado_id;


--
-- TOC entry 193 (class 1259 OID 24614)
-- Name: indications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.indications (
    indication_id character(36) NOT NULL,
    vendor_name character varying(255) DEFAULT 'Vendor Name'::character varying NOT NULL,
    city_id integer DEFAULT 0 NOT NULL,
    phone character varying(14),
    comment text,
    email character varying(255)
);


ALTER TABLE public.indications OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 24598)
-- Name: industry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.industry (
    industry_id integer NOT NULL,
    name character varying(255) DEFAULT 'Market'::character varying NOT NULL
);


ALTER TABLE public.industry OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 24596)
-- Name: industry_industry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.industry_industry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.industry_industry_id_seq OWNER TO postgres;

--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 189
-- Name: industry_industry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.industry_industry_id_seq OWNED BY public.industry.industry_id;


--
-- TOC entry 192 (class 1259 OID 24607)
-- Name: market_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.market_types (
    market_type_id integer NOT NULL,
    industry_id integer NOT NULL,
    name character varying(255) DEFAULT 'Market Type'::character varying NOT NULL
);


ALTER TABLE public.market_types OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 24605)
-- Name: market_types_market_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.market_types_market_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.market_types_market_type_id_seq OWNER TO postgres;

--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 191
-- Name: market_types_market_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.market_types_market_type_id_seq OWNED BY public.market_types.market_type_id;


--
-- TOC entry 209 (class 1259 OID 24750)
-- Name: order_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_products (
    order_product_id character(36) NOT NULL,
    order_id character(36) NOT NULL,
    product_id character(36) NOT NULL,
    comments text,
    quantity integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.order_products OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 24694)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id character(36) NOT NULL,
    order_schedule timestamp without time zone NOT NULL,
    delivery_address character varying(255),
    conclude_schedule timestamp without time zone,
    total_price numeric(8,2) NOT NULL,
    address character varying(255),
    user_id character(36) NOT NULL,
    vendor_branch_id character(36) NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24888)
-- Name: phones_vendor_branchs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phones_vendor_branchs (
    phone_vendor_branch_id character(36) NOT NULL,
    vendor_branch_id character(36) NOT NULL,
    phone character varying(14) DEFAULT 'no phone'::character varying NOT NULL,
    whatsapp boolean DEFAULT false NOT NULL
);


ALTER TABLE public.phones_vendor_branchs OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 24711)
-- Name: product_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_categories (
    category_id character(36) NOT NULL,
    name character varying(255) NOT NULL,
    image character varying(255) DEFAULT 'uploads/no-pic.jpg'::character varying NOT NULL,
    description text,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.product_categories OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 24721)
-- Name: product_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_types (
    type_id character(36) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    image character varying(255) DEFAULT 'uploads/no-pic.jpg'::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    category_id character(36) NOT NULL
);


ALTER TABLE public.product_types OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 24731)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id character(36) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    type_id character(36) NOT NULL,
    image character varying(255) DEFAULT 'uploads/no-pic.jpg'::character varying NOT NULL,
    price numeric(8,2) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    vendor_branch_id character(36) NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 33245)
-- Name: products_extras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_extras (
    product_extra_id character varying(36) NOT NULL,
    name character varying(255) DEFAULT 'Extra'::character varying NOT NULL,
    description text,
    active boolean DEFAULT true NOT NULL,
    price numeric(8,2) NOT NULL,
    image character varying(255),
    product_id character(36) NOT NULL
);


ALTER TABLE public.products_extras OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 24741)
-- Name: promotions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotions (
    promotion_id character(36) NOT NULL,
    description text,
    price numeric(8,2) DEFAULT 0.0 NOT NULL,
    product_id character(36) NOT NULL,
    vendor_branch_id character(36) NOT NULL
);


ALTER TABLE public.promotions OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 24702)
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating (
    rating_id character(36) NOT NULL,
    note integer DEFAULT 5 NOT NULL,
    comment text,
    order_id character(36) NOT NULL,
    user_id character(36) NOT NULL,
    schedule date NOT NULL,
    vendor_branch_id character(36) NOT NULL
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 24684)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id character(36) NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    city_id integer DEFAULT 0 NOT NULL,
    phone character(14) NOT NULL,
    address character varying(255),
    image character varying(255) DEFAULT 'uploads/no-pic.jpg'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 24649)
-- Name: vendor_branchs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_branchs (
    vendor_branch_id character(36) NOT NULL,
    address character varying(255) NOT NULL,
    coordinates character varying(255),
    minimum_value integer NOT NULL,
    delivery_time_min integer,
    close character varying(5) DEFAULT '22:00:00'::time without time zone NOT NULL,
    open character varying(5) DEFAULT '08:00:00'::time without time zone NOT NULL,
    delivery_time_max integer,
    vendor_id character(36) NOT NULL,
    city_id integer DEFAULT 0 NOT NULL,
    temp_closed boolean DEFAULT false NOT NULL,
    cnpj character(18) DEFAULT ''::bpchar NOT NULL,
    email character varying(255) DEFAULT 'Email'::character varying NOT NULL,
    name character varying(255) DEFAULT 'Loja'::character varying NOT NULL,
    banner character varying(255) DEFAULT 'uploads/no-pic.jpg'::character varying NOT NULL,
    cep character varying(9) DEFAULT ''::character varying NOT NULL,
    avatar character varying(255) DEFAULT 'uploads/no-pic.jpg'::character varying NOT NULL
);


ALTER TABLE public.vendor_branchs OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 24678)
-- Name: vendor_fees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_fees (
    vendor_fee_id character(36) NOT NULL,
    fee numeric(8,2) DEFAULT 0 NOT NULL,
    time_min integer,
    time_max integer,
    vendor_branch_id character(36) NOT NULL
);


ALTER TABLE public.vendor_fees OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 24660)
-- Name: vendor_market_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_market_types (
    vendor_market_type_id character(36) NOT NULL,
    market_type_id integer NOT NULL,
    vendor_branch_id character(36) NOT NULL
);


ALTER TABLE public.vendor_market_types OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 24637)
-- Name: vendors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendors (
    vendor_id character(36) NOT NULL,
    name character varying(255) NOT NULL,
    cnpj character(18) NOT NULL,
    email character varying(255) NOT NULL,
    cpf character(14) DEFAULT '000.000.000-00'::bpchar NOT NULL,
    phone character varying(14) DEFAULT 'no phone'::character varying NOT NULL,
    address character varying(255) DEFAULT ''::character varying NOT NULL,
    cep character varying(9) DEFAULT ''::character varying NOT NULL,
    city_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.vendors OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 24670)
-- Name: vendors_operation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendors_operation (
    vendor_operation_id character(36) NOT NULL,
    day_week integer DEFAULT 0 NOT NULL,
    open time without time zone DEFAULT '12:00:00'::time without time zone NOT NULL,
    close time without time zone DEFAULT '18:00:00'::time without time zone NOT NULL,
    vendor_branch_id character(36) NOT NULL
);


ALTER TABLE public.vendors_operation OWNER TO postgres;

--
-- TOC entry 2117 (class 2604 OID 24629)
-- Name: cards card_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards ALTER COLUMN card_id SET DEFAULT nextval('public.cards_card_id_seq'::regclass);


--
-- TOC entry 2109 (class 2604 OID 24592)
-- Name: cities city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.cities_city_id_seq'::regclass);


--
-- TOC entry 2106 (class 2604 OID 24582)
-- Name: estados estado_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados ALTER COLUMN estado_id SET DEFAULT nextval('public.estados_estado_id_seq'::regclass);


--
-- TOC entry 2111 (class 2604 OID 24601)
-- Name: industry industry_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.industry ALTER COLUMN industry_id SET DEFAULT nextval('public.industry_industry_id_seq'::regclass);


--
-- TOC entry 2113 (class 2604 OID 24610)
-- Name: market_types market_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.market_types ALTER COLUMN market_type_id SET DEFAULT nextval('public.market_types_market_type_id_seq'::regclass);


--
-- TOC entry 2352 (class 0 OID 24665)
-- Dependencies: 199
-- Data for Name: card_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.card_options (card_option_id, card_id, vendor_branch_id) FROM stdin;
\.


--
-- TOC entry 2348 (class 0 OID 24626)
-- Dependencies: 195
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards (card_id, name, flag_id) FROM stdin;
1	Visa	visa
2	Mastercard	mastercard
3	Elo	elo
\.


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 194
-- Name: cards_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_card_id_seq', 1, false);


--
-- TOC entry 2341 (class 0 OID 24589)
-- Dependencies: 188
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (city_id, name, estado_id) FROM stdin;
\.


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 187
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_city_id_seq', 1, false);


--
-- TOC entry 2339 (class 0 OID 24579)
-- Dependencies: 186
-- Data for Name: estados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estados (estado_id, nome, uf) FROM stdin;
\.


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 185
-- Name: estados_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_estado_id_seq', 1, false);


--
-- TOC entry 2346 (class 0 OID 24614)
-- Dependencies: 193
-- Data for Name: indications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indications (indication_id, vendor_name, city_id, phone, comment, email) FROM stdin;
\.


--
-- TOC entry 2343 (class 0 OID 24598)
-- Dependencies: 190
-- Data for Name: industry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.industry (industry_id, name) FROM stdin;
\.


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 189
-- Name: industry_industry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.industry_industry_id_seq', 1, false);


--
-- TOC entry 2345 (class 0 OID 24607)
-- Dependencies: 192
-- Data for Name: market_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.market_types (market_type_id, industry_id, name) FROM stdin;
\.


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 191
-- Name: market_types_market_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.market_types_market_type_id_seq', 1, false);


--
-- TOC entry 2362 (class 0 OID 24750)
-- Dependencies: 209
-- Data for Name: order_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_products (order_product_id, order_id, product_id, comments, quantity) FROM stdin;
\.


--
-- TOC entry 2356 (class 0 OID 24694)
-- Dependencies: 203
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, order_schedule, delivery_address, conclude_schedule, total_price, address, user_id, vendor_branch_id) FROM stdin;
\.


--
-- TOC entry 2363 (class 0 OID 24888)
-- Dependencies: 210
-- Data for Name: phones_vendor_branchs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phones_vendor_branchs (phone_vendor_branch_id, vendor_branch_id, phone, whatsapp) FROM stdin;
\.


--
-- TOC entry 2358 (class 0 OID 24711)
-- Dependencies: 205
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_categories (category_id, name, image, description, active) FROM stdin;
b7ca02a8-f66a-4383-aa51-faef1e839b60	Alimentos	uploads/no-pic.jpg	Comestíveis	t
\.


--
-- TOC entry 2359 (class 0 OID 24721)
-- Dependencies: 206
-- Data for Name: product_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_types (type_id, name, description, image, active, category_id) FROM stdin;
8869d062-5e3e-4240-a213-defc00be8b49	Pizzas	Pizzas Redondas Vários Diversos Sabores	uploads/no-pic.jpg	t	b7ca02a8-f66a-4383-aa51-faef1e839b60
f9acd86d-fefc-4e92-b34d-169054a6f399	Sanduíches	Sanduíches Diversos	uploads/no-pic.jpg	t	b7ca02a8-f66a-4383-aa51-faef1e839b60
\.


--
-- TOC entry 2360 (class 0 OID 24731)
-- Dependencies: 207
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, name, description, type_id, image, price, active, vendor_branch_id) FROM stdin;
3465a544-833f-42ce-befc-d0f47c85ca48	Pizza à Moda	Pizza muito gostosa	8869d062-5e3e-4240-a213-defc00be8b49	uploads/no-pic.jpg	30.00	t	f12f41f8-7a67-42cf-a378-d3a11daa3cf9
3be27a3a-59b8-4c83-a801-4e1c39955480	X-Tudo	Sanduíche muito gostoso	f9acd86d-fefc-4e92-b34d-169054a6f399	uploads/no-pic.jpg	10.00	t	f12f41f8-7a67-42cf-a378-d3a11daa3cf9
\.


--
-- TOC entry 2364 (class 0 OID 33245)
-- Dependencies: 211
-- Data for Name: products_extras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_extras (product_extra_id, name, description, active, price, image, product_id) FROM stdin;
\.


--
-- TOC entry 2361 (class 0 OID 24741)
-- Dependencies: 208
-- Data for Name: promotions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotions (promotion_id, description, price, product_id, vendor_branch_id) FROM stdin;
\.


--
-- TOC entry 2357 (class 0 OID 24702)
-- Dependencies: 204
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rating (rating_id, note, comment, order_id, user_id, schedule, vendor_branch_id) FROM stdin;
\.


--
-- TOC entry 2355 (class 0 OID 24684)
-- Dependencies: 202
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, email, city_id, phone, address, image) FROM stdin;
\.


--
-- TOC entry 2350 (class 0 OID 24649)
-- Dependencies: 197
-- Data for Name: vendor_branchs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_branchs (vendor_branch_id, address, coordinates, minimum_value, delivery_time_min, close, open, delivery_time_max, vendor_id, city_id, temp_closed, cnpj, email, name, banner, cep, avatar) FROM stdin;
f12f41f8-7a67-42cf-a378-d3a11daa3cf9	Rua do Caralho	\N	20	20	00:00	15:00	40	b6dc6500-ee15-4290-8683-77944216e699	3665	f	15.622.828/0001-59	Email	Erótico Soft Goiânia	uploads\\upload_fefed0f93c37c2f771ff52891c825b06.jpg		uploads\\upload_0b7dc0abd01ad946e45cede0ec48d25d.jpg
\.


--
-- TOC entry 2354 (class 0 OID 24678)
-- Dependencies: 201
-- Data for Name: vendor_fees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_fees (vendor_fee_id, fee, time_min, time_max, vendor_branch_id) FROM stdin;
\.


--
-- TOC entry 2351 (class 0 OID 24660)
-- Dependencies: 198
-- Data for Name: vendor_market_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_market_types (vendor_market_type_id, market_type_id, vendor_branch_id) FROM stdin;
\.


--
-- TOC entry 2349 (class 0 OID 24637)
-- Dependencies: 196
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendors (vendor_id, name, cnpj, email, cpf, phone, address, cep, city_id) FROM stdin;
b6dc6500-ee15-4290-8683-77944216e699	Eron Soft	15.622.828/0001-59	eroslindo@gaymail.com	348.202.040-09	no phone	Rua 666	74666666	3665
\.


--
-- TOC entry 2353 (class 0 OID 24670)
-- Dependencies: 200
-- Data for Name: vendors_operation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendors_operation (vendor_operation_id, day_week, open, close, vendor_branch_id) FROM stdin;
\.


--
-- TOC entry 2165 (class 2606 OID 24636)
-- Name: cards card_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT card_id PRIMARY KEY (card_id);


--
-- TOC entry 2173 (class 2606 OID 24669)
-- Name: card_options card_option_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_options
    ADD CONSTRAINT card_option_id PRIMARY KEY (card_option_id);


--
-- TOC entry 2185 (class 2606 OID 24720)
-- Name: product_categories category_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT category_id PRIMARY KEY (category_id);


--
-- TOC entry 2157 (class 2606 OID 24595)
-- Name: cities city_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT city_id PRIMARY KEY (city_id);


--
-- TOC entry 2155 (class 2606 OID 24586)
-- Name: estados estado_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados
    ADD CONSTRAINT estado_id PRIMARY KEY (estado_id);


--
-- TOC entry 2163 (class 2606 OID 24623)
-- Name: indications indication_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.indications
    ADD CONSTRAINT indication_id PRIMARY KEY (indication_id);


--
-- TOC entry 2159 (class 2606 OID 24604)
-- Name: industry industry_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.industry
    ADD CONSTRAINT industry_id PRIMARY KEY (industry_id);


--
-- TOC entry 2161 (class 2606 OID 24613)
-- Name: market_types market_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.market_types
    ADD CONSTRAINT market_type_id PRIMARY KEY (market_type_id);


--
-- TOC entry 2181 (class 2606 OID 24701)
-- Name: orders order_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_id PRIMARY KEY (order_id);


--
-- TOC entry 2193 (class 2606 OID 24758)
-- Name: order_products order_product_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_products
    ADD CONSTRAINT order_product_id PRIMARY KEY (order_product_id);


--
-- TOC entry 2195 (class 2606 OID 24894)
-- Name: phones_vendor_branchs phone_vendor_branch_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones_vendor_branchs
    ADD CONSTRAINT phone_vendor_branch_id PRIMARY KEY (phone_vendor_branch_id);


--
-- TOC entry 2197 (class 2606 OID 33254)
-- Name: products_extras product_extra_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_extras
    ADD CONSTRAINT product_extra_id PRIMARY KEY (product_extra_id);


--
-- TOC entry 2189 (class 2606 OID 24740)
-- Name: products product_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT product_id PRIMARY KEY (product_id);


--
-- TOC entry 2191 (class 2606 OID 24749)
-- Name: promotions promotion_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotion_id PRIMARY KEY (promotion_id);


--
-- TOC entry 2183 (class 2606 OID 24710)
-- Name: rating rating_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_id PRIMARY KEY (rating_id);


--
-- TOC entry 2187 (class 2606 OID 24730)
-- Name: product_types type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_types
    ADD CONSTRAINT type_id PRIMARY KEY (type_id);


--
-- TOC entry 2179 (class 2606 OID 24693)
-- Name: users user_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_id PRIMARY KEY (user_id);


--
-- TOC entry 2169 (class 2606 OID 24659)
-- Name: vendor_branchs vendor_branch_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_branchs
    ADD CONSTRAINT vendor_branch_id PRIMARY KEY (vendor_branch_id);


--
-- TOC entry 2177 (class 2606 OID 24683)
-- Name: vendor_fees vendor_fee_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_fees
    ADD CONSTRAINT vendor_fee_id PRIMARY KEY (vendor_fee_id);


--
-- TOC entry 2171 (class 2606 OID 24664)
-- Name: vendor_market_types vendor_market_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_market_types
    ADD CONSTRAINT vendor_market_type_id PRIMARY KEY (vendor_market_type_id);


--
-- TOC entry 2175 (class 2606 OID 24677)
-- Name: vendors_operation vendor_operation_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors_operation
    ADD CONSTRAINT vendor_operation_id PRIMARY KEY (vendor_operation_id);


--
-- TOC entry 2167 (class 2606 OID 24648)
-- Name: vendors vendorid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendorid PRIMARY KEY (vendor_id);


--
-- TOC entry 2203 (class 2606 OID 24774)
-- Name: card_options cards_payment_options_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_options
    ADD CONSTRAINT cards_payment_options_fk FOREIGN KEY (card_id) REFERENCES public.cards(card_id);


--
-- TOC entry 2198 (class 2606 OID 24759)
-- Name: cities estados_cities_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT estados_cities_fk FOREIGN KEY (estado_id) REFERENCES public.estados(estado_id);


--
-- TOC entry 2201 (class 2606 OID 24769)
-- Name: vendor_market_types market_types_vendor_market_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_market_types
    ADD CONSTRAINT market_types_vendor_market_types_fk FOREIGN KEY (market_type_id) REFERENCES public.market_types(market_type_id);


--
-- TOC entry 2199 (class 2606 OID 24764)
-- Name: market_types markets_market_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.market_types
    ADD CONSTRAINT markets_market_types_fk FOREIGN KEY (industry_id) REFERENCES public.industry(industry_id);


--
-- TOC entry 2217 (class 2606 OID 24834)
-- Name: order_products orders_order_itens_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_products
    ADD CONSTRAINT orders_order_itens_fk FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 2211 (class 2606 OID 24839)
-- Name: rating orders_rating_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT orders_rating_fk FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 2212 (class 2606 OID 24844)
-- Name: product_types product_categories_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_types
    ADD CONSTRAINT product_categories_products_fk FOREIGN KEY (category_id) REFERENCES public.product_categories(category_id);


--
-- TOC entry 2218 (class 2606 OID 24854)
-- Name: order_products product_types_order_itens_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_products
    ADD CONSTRAINT product_types_order_itens_fk FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 2214 (class 2606 OID 24849)
-- Name: products products_product_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_types_fk FOREIGN KEY (type_id) REFERENCES public.product_types(type_id);


--
-- TOC entry 2220 (class 2606 OID 33255)
-- Name: products_extras products_products_extras_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_extras
    ADD CONSTRAINT products_products_extras_fk FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 2216 (class 2606 OID 24859)
-- Name: promotions products_promotions_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT products_promotions_fk FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 2208 (class 2606 OID 24824)
-- Name: orders users_orders_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT users_orders_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 2210 (class 2606 OID 24829)
-- Name: rating users_rating_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT users_rating_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 2204 (class 2606 OID 24794)
-- Name: card_options vendor_branchs_card_options_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_options
    ADD CONSTRAINT vendor_branchs_card_options_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2207 (class 2606 OID 24799)
-- Name: orders vendor_branchs_orders_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT vendor_branchs_orders_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2219 (class 2606 OID 24903)
-- Name: phones_vendor_branchs vendor_branchs_phones_vendor_branchs_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones_vendor_branchs
    ADD CONSTRAINT vendor_branchs_phones_vendor_branchs_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2213 (class 2606 OID 24804)
-- Name: products vendor_branchs_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT vendor_branchs_products_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2215 (class 2606 OID 24809)
-- Name: promotions vendor_branchs_promotions_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT vendor_branchs_promotions_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2209 (class 2606 OID 24814)
-- Name: rating vendor_branchs_rating_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT vendor_branchs_rating_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2202 (class 2606 OID 24819)
-- Name: vendor_market_types vendor_branchs_vendor_market_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_market_types
    ADD CONSTRAINT vendor_branchs_vendor_market_types_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2206 (class 2606 OID 24784)
-- Name: vendor_fees vendor_cities_vendor_fees_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_fees
    ADD CONSTRAINT vendor_cities_vendor_fees_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2205 (class 2606 OID 24789)
-- Name: vendors_operation vendor_cities_vendors_operation_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors_operation
    ADD CONSTRAINT vendor_cities_vendors_operation_fk FOREIGN KEY (vendor_branch_id) REFERENCES public.vendor_branchs(vendor_branch_id);


--
-- TOC entry 2200 (class 2606 OID 24779)
-- Name: vendor_branchs vendors_vendor_cities_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_branchs
    ADD CONSTRAINT vendors_vendor_cities_fk FOREIGN KEY (vendor_id) REFERENCES public.vendors(vendor_id);


-- Completed on 2018-06-17 20:00:43

--
-- PostgreSQL database dump complete
--

