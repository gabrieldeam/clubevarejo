--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-04-21 21:57:16

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
-- TOC entry 5010 (class 1262 OID 24592)
-- Name: nilrow_teste; Type: DATABASE; Schema: -; Owner: postgres
--

-- CREATE DATABASE nilrow_teste WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE nilrow_teste OWNER TO postgres;

-- \connect nilrow_teste

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
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

-- CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 256 (class 1255 OID 25110)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    existe integer;
BEGIN
    -- Verifica se o ID da pessoa existe na tabela pessoa_fisica
    SELECT count(1) INTO existe FROM pessoa_fisica WHERE id = NEW.pessoa_id;
    
    -- Se não encontrou na pessoa_fisica, verifica na pessoa_juridica
    IF (existe <= 0) THEN
        SELECT count(1) INTO existe FROM pessoa_juridica WHERE id = NEW.pessoa_id;
        IF (existe <= 0) THEN
            RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 25126)
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    existe integer;
BEGIN
    -- Verifica se o ID da pessoa existe na tabela pessoa_fisica
    SELECT count(1) INTO existe FROM pessoa_fisica WHERE id = NEW.pessoa_forn_id;
    
    -- Se não encontrou na pessoa_fisica, verifica na pessoa_juridica
    IF (existe <= 0) THEN
        SELECT count(1) INTO existe FROM pessoa_juridica WHERE id = NEW.pessoa_forn_id;
        IF (existe <= 0) THEN
            RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.validachavepessoa2() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 24617)
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acesso (
    id uuid NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24616)
-- Name: acesso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acesso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.acesso_seq OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 24938)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacao_produto (
    id uuid NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL,
    pessoa_id uuid NOT NULL,
    produto_id uuid NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 24922)
-- Name: avaliacao_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avaliacao_produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avaliacao_produto_seq OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 24949)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria_produto (
    id uuid NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.categoria_produto OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24610)
-- Name: categoria_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_produto_seq OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 24954)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_pagar (
    id uuid NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_total numeric(38,2) NOT NULL,
    pessoa_id uuid NOT NULL,
    pessoa_forn_id uuid NOT NULL,
    CONSTRAINT conta_pagar_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying])::text[])))
);


ALTER TABLE public.conta_pagar OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24725)
-- Name: conta_pagar_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conta_pagar_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conta_pagar_seq OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 24989)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_receber (
    id uuid NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_total numeric(38,2) NOT NULL,
    pessoa_id uuid NOT NULL,
    CONSTRAINT conta_receber_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying])::text[])))
);


ALTER TABLE public.conta_receber OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24714)
-- Name: conta_receber_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conta_receber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conta_receber_seq OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24732)
-- Name: cupom_desconto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cupom_desconto (
    id uuid NOT NULL,
    valor_porcent_desc numeric(38,2),
    valor_real_desc numeric(38,2),
    cod_desc character varying(255) NOT NULL,
    dt_validade_cupom date NOT NULL
);


ALTER TABLE public.cupom_desconto OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24731)
-- Name: cupom_desconto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cupom_desconto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cupom_desconto_seq OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 25024)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
    id uuid NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    ponto_ref character varying(255),
    rua character varying(255) NOT NULL,
    tipo_endereco character varying(255),
    uf character varying(255) NOT NULL,
    pessoa_id uuid NOT NULL,
    CONSTRAINT endereco_tipo_endereco_check CHECK (((tipo_endereco)::text = ANY ((ARRAY['CASA'::character varying, 'ESCRITORIO'::character varying])::text[])))
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24647)
-- Name: endereco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endereco_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endereco_seq OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24700)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forma_pagamento (
    id uuid NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.forma_pagamento OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24716)
-- Name: forma_pagamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forma_pagamento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forma_pagamento_seq OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 25042)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imagem_produto (
    id uuid NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id uuid NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 24784)
-- Name: imagem_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.imagem_produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.imagem_produto_seq OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 24997)
-- Name: item_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_venda (
    id uuid NOT NULL,
    produto_id uuid NOT NULL,
    venda_compra_id uuid NOT NULL,
    quantidade double precision NOT NULL
);


ALTER TABLE public.item_venda OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 24906)
-- Name: item_venda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_venda_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_venda_seq OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24622)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca_produto (
    id uuid NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.marca_produto OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24604)
-- Name: marca_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marca_produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marca_produto_seq OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 25054)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_compra (
    id uuid NOT NULL,
    descricao_obs character varying(255),
    dt_compra date NOT NULL,
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valoricms numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    conta_pagar_id uuid NOT NULL,
    pessoa_id uuid NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 24797)
-- Name: nota_fiscal_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nota_fiscal_compra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nota_fiscal_compra_seq OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 25072)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_venda (
    id uuid NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_id uuid NOT NULL
);


ALTER TABLE public.nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 24834)
-- Name: nota_fiscal_venda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nota_fiscal_venda_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nota_fiscal_venda_seq OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 24969)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_item_produto (
    id uuid NOT NULL,
    nota_fiscal_compra_id uuid NOT NULL,
    produto_id uuid NOT NULL,
    quantidade double precision NOT NULL
);


ALTER TABLE public.nota_item_produto OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 24808)
-- Name: nota_item_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nota_item_produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nota_item_produto_seq OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 25091)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_fisica (
    id uuid NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date NOT NULL
);


ALTER TABLE public.pessoa_fisica OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 25098)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_juridica (
    id uuid NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    categoria character varying(255) NOT NULL,
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255),
    insc_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24641)
-- Name: pessoa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pessoa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pessoa_seq OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24770)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id uuid NOT NULL,
    alerta_estoque integer,
    alerta_quant_estoque boolean,
    altura double precision,
    descricao text,
    estoque integer,
    largura double precision,
    link_youtube character varying(255),
    nome character varying(255),
    peso double precision,
    profundidade double precision,
    quant_clique integer,
    status boolean,
    tipo_unidade character varying(255),
    valor_venda numeric(38,2)
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 24768)
-- Name: produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produto_seq OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 25002)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_rastreio (
    id uuid NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_id uuid NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24826)
-- Name: status_rastreio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_rastreio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_rastreio_seq OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24737)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id uuid NOT NULL,
    pessoa_id uuid NOT NULL,
    dt_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24744)
-- Name: usuario_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_acesso (
    usuario_id uuid NOT NULL,
    acesso_id uuid NOT NULL
);


ALTER TABLE public.usuario_acesso OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24679)
-- Name: usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_seq OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24842)
-- Name: venda_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda_compra (
    id uuid NOT NULL,
    endereco_cobranca_id uuid NOT NULL,
    endereco_entrega_id uuid NOT NULL,
    forma_pagamento_id uuid NOT NULL,
    nota_fiscal_venda_id uuid NOT NULL,
    pessoa_id uuid NOT NULL,
    dia_entrega integer NOT NULL,
    dt_entrega date NOT NULL,
    dt_venda date NOT NULL,
    valor_desconto numeric(38,2),
    valor_frete numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    cupom_desconto_id uuid
);


ALTER TABLE public.venda_compra OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 24851)
-- Name: venda_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venda_compra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venda_compra_seq OWNER TO postgres;

--
-- TOC entry 4968 (class 0 OID 24617)
-- Dependencies: 219
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4992 (class 0 OID 24938)
-- Dependencies: 243
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4993 (class 0 OID 24949)
-- Dependencies: 244
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4994 (class 0 OID 24954)
-- Dependencies: 245
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4996 (class 0 OID 24989)
-- Dependencies: 247
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4978 (class 0 OID 24732)
-- Dependencies: 229
-- Data for Name: cupom_desconto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4999 (class 0 OID 25024)
-- Dependencies: 250
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4973 (class 0 OID 24700)
-- Dependencies: 224
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5000 (class 0 OID 25042)
-- Dependencies: 251
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4997 (class 0 OID 24997)
-- Dependencies: 248
-- Data for Name: item_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4969 (class 0 OID 24622)
-- Dependencies: 220
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5001 (class 0 OID 25054)
-- Dependencies: 252
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5002 (class 0 OID 25072)
-- Dependencies: 253
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4995 (class 0 OID 24969)
-- Dependencies: 246
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5003 (class 0 OID 25091)
-- Dependencies: 254
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5004 (class 0 OID 25098)
-- Dependencies: 255
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4982 (class 0 OID 24770)
-- Dependencies: 233
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produto (id, alerta_estoque, alerta_quant_estoque, altura, descricao, estoque, largura, link_youtube, nome, peso, profundidade, quant_clique, status, tipo_unidade, valor_venda) VALUES ('79d5cacd-9799-4846-a283-4a33e082fb8a', 1, true, 10, 'produto teste', 50, 50.1, 'link', 'nome produto teste', 50.1, 50.1, 50, true, 'UN', 50.00);


--
-- TOC entry 4998 (class 0 OID 25002)
-- Dependencies: 249
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4979 (class 0 OID 24737)
-- Dependencies: 230
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4980 (class 0 OID 24744)
-- Dependencies: 231
-- Data for Name: usuario_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4988 (class 0 OID 24842)
-- Dependencies: 239
-- Data for Name: venda_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 218
-- Name: acesso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acesso_seq', 1, false);


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 242
-- Name: avaliacao_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avaliacao_produto_seq', 1, false);


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 217
-- Name: categoria_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_produto_seq', 1, false);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 227
-- Name: conta_pagar_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conta_pagar_seq', 1, false);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 225
-- Name: conta_receber_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conta_receber_seq', 1, false);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 228
-- Name: cupom_desconto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cupom_desconto_seq', 1, false);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 222
-- Name: endereco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_seq', 1, false);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 226
-- Name: forma_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forma_pagamento_seq', 1, false);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 234
-- Name: imagem_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.imagem_produto_seq', 1, false);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 241
-- Name: item_venda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_venda_seq', 1, false);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 216
-- Name: marca_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marca_produto_seq', 1, false);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 235
-- Name: nota_fiscal_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nota_fiscal_compra_seq', 1, false);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 238
-- Name: nota_fiscal_venda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nota_fiscal_venda_seq', 1, false);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 236
-- Name: nota_item_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nota_item_produto_seq', 1, false);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 221
-- Name: pessoa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pessoa_seq', 1, false);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 232
-- Name: produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_seq', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 237
-- Name: status_rastreio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_rastreio_seq', 1, false);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 223
-- Name: usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_seq', 1, false);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 240
-- Name: venda_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venda_compra_seq', 1, false);


--
-- TOC entry 4749 (class 2606 OID 24621)
-- Name: acesso acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 4765 (class 2606 OID 24942)
-- Name: avaliacao_produto avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4767 (class 2606 OID 24953)
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4769 (class 2606 OID 24961)
-- Name: conta_pagar conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 4773 (class 2606 OID 24996)
-- Name: conta_receber conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 4755 (class 2606 OID 24736)
-- Name: cupom_desconto cupom_desconto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupom_desconto
    ADD CONSTRAINT cupom_desconto_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 25031)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 4753 (class 2606 OID 24704)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 4781 (class 2606 OID 25048)
-- Name: imagem_produto imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4775 (class 2606 OID 25001)
-- Name: item_venda item_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT item_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 4751 (class 2606 OID 24626)
-- Name: marca_produto marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4783 (class 2606 OID 25060)
-- Name: nota_fiscal_compra nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 4785 (class 2606 OID 25078)
-- Name: nota_fiscal_venda nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 4771 (class 2606 OID 24973)
-- Name: nota_item_produto nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4787 (class 2606 OID 25097)
-- Name: pessoa_fisica pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 4789 (class 2606 OID 25104)
-- Name: pessoa_juridica pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 4761 (class 2606 OID 24776)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4777 (class 2606 OID 25008)
-- Name: status_rastreio status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 4759 (class 2606 OID 24748)
-- Name: usuario_acesso unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 4757 (class 2606 OID 24743)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4763 (class 2606 OID 24846)
-- Name: venda_compra venda_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra
    ADD CONSTRAINT venda_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 4812 (class 2620 OID 25128)
-- Name: conta_pagar validachavepessoa_forninsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa_forninsert BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 4813 (class 2620 OID 25127)
-- Name: conta_pagar validachavepessoa_fornupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa_fornupdate BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 4810 (class 2620 OID 25123)
-- Name: avaliacao_produto validachavepessoainsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoainsert BEFORE INSERT ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4814 (class 2620 OID 25125)
-- Name: conta_pagar validachavepessoainsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoainsert BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4816 (class 2620 OID 25130)
-- Name: conta_receber validachavepessoainsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoainsert BEFORE INSERT ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4818 (class 2620 OID 25132)
-- Name: endereco validachavepessoainsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoainsert BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4820 (class 2620 OID 25134)
-- Name: nota_fiscal_compra validachavepessoainsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoainsert BEFORE INSERT ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4806 (class 2620 OID 25136)
-- Name: usuario validachavepessoainsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoainsert BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4808 (class 2620 OID 25138)
-- Name: venda_compra validachavepessoainsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoainsert BEFORE INSERT ON public.venda_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4811 (class 2620 OID 25111)
-- Name: avaliacao_produto validachavepessoaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaupdate BEFORE UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4815 (class 2620 OID 25124)
-- Name: conta_pagar validachavepessoaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaupdate BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4817 (class 2620 OID 25129)
-- Name: conta_receber validachavepessoaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaupdate BEFORE UPDATE ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4819 (class 2620 OID 25131)
-- Name: endereco validachavepessoaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaupdate BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4821 (class 2620 OID 25133)
-- Name: nota_fiscal_compra validachavepessoaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaupdate BEFORE UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4807 (class 2620 OID 25135)
-- Name: usuario validachavepessoaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaupdate BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4809 (class 2620 OID 25137)
-- Name: venda_compra validachavepessoaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaupdate BEFORE UPDATE ON public.venda_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4790 (class 2606 OID 24751)
-- Name: usuario_acesso acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 4804 (class 2606 OID 25061)
-- Name: nota_fiscal_compra conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar(id);


--
-- TOC entry 4792 (class 2606 OID 25105)
-- Name: venda_compra cupom_desconto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra
    ADD CONSTRAINT cupom_desconto_fk FOREIGN KEY (cupom_desconto_id) REFERENCES public.cupom_desconto(id);


--
-- TOC entry 4793 (class 2606 OID 25032)
-- Name: venda_compra endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 4794 (class 2606 OID 25037)
-- Name: venda_compra endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 4795 (class 2606 OID 24872)
-- Name: venda_compra forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 4796 (class 2606 OID 25086)
-- Name: venda_compra nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fiscal_venda(id);


--
-- TOC entry 4798 (class 2606 OID 25066)
-- Name: nota_item_produto notafiscalcompra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT notafiscalcompra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 4797 (class 2606 OID 24943)
-- Name: avaliacao_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 4799 (class 2606 OID 24984)
-- Name: nota_item_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 4800 (class 2606 OID 25009)
-- Name: item_venda produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 4803 (class 2606 OID 25049)
-- Name: imagem_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 4791 (class 2606 OID 24756)
-- Name: usuario_acesso usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 4801 (class 2606 OID 25014)
-- Name: item_venda venda_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda
    ADD CONSTRAINT venda_compra_fk FOREIGN KEY (venda_compra_id) REFERENCES public.venda_compra(id);


--
-- TOC entry 4802 (class 2606 OID 25019)
-- Name: status_rastreio venda_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_compra_fk FOREIGN KEY (venda_compra_id) REFERENCES public.venda_compra(id);


--
-- TOC entry 4805 (class 2606 OID 25081)
-- Name: nota_fiscal_venda venda_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT venda_compra_fk FOREIGN KEY (venda_compra_id) REFERENCES public.venda_compra(id);


-- Completed on 2024-04-21 21:57:16

--
-- PostgreSQL database dump complete
--

