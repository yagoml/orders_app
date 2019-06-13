
CREATE SEQUENCE public.estados_estado_id_seq;

CREATE TABLE public.estados (
                estado_id INTEGER NOT NULL DEFAULT nextval('public.estados_estado_id_seq'),
                nome VARCHAR(255) DEFAULT '' NOT NULL,
                uf CHAR(2) DEFAULT '' NOT NULL,
                CONSTRAINT estado_id PRIMARY KEY (estado_id)
);


ALTER SEQUENCE public.estados_estado_id_seq OWNED BY public.estados.estado_id;

CREATE SEQUENCE public.cities_city_id_seq;

CREATE TABLE public.cities (
                city_id INTEGER NOT NULL DEFAULT nextval('public.cities_city_id_seq'),
                name VARCHAR(255) DEFAULT '' NOT NULL,
                estado_id INTEGER NOT NULL,
                CONSTRAINT city_id PRIMARY KEY (city_id)
);


ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;

CREATE SEQUENCE public.industry_industry_id_seq;

CREATE TABLE public.industry (
                industry_id INTEGER NOT NULL DEFAULT nextval('public.industry_industry_id_seq'),
                name VARCHAR(255) DEFAULT 'Market' NOT NULL,
                CONSTRAINT industry_id PRIMARY KEY (industry_id)
);


ALTER SEQUENCE public.industry_industry_id_seq OWNED BY public.industry.industry_id;

CREATE SEQUENCE public.market_types_market_type_id_seq;

CREATE TABLE public.market_types (
                market_type_id INTEGER NOT NULL DEFAULT nextval('public.market_types_market_type_id_seq'),
                industry_id INTEGER NOT NULL,
                name VARCHAR(255) DEFAULT 'Market Type' NOT NULL,
                CONSTRAINT market_type_id PRIMARY KEY (market_type_id)
);


ALTER SEQUENCE public.market_types_market_type_id_seq OWNED BY public.market_types.market_type_id;

CREATE TABLE public.indications (
                indication_id CHAR(36) NOT NULL,
                vendor_name VARCHAR(255) DEFAULT 'Vendor Name' NOT NULL,
                city_id INTEGER DEFAULT 0 NOT NULL,
                phone VARCHAR(14),
                comment TEXT,
                email VARCHAR(255),
                CONSTRAINT indication_id PRIMARY KEY (indication_id)
);


CREATE SEQUENCE public.cards_card_id_seq;

CREATE TABLE public.cards (
                card_id INTEGER NOT NULL DEFAULT nextval('public.cards_card_id_seq'),
                name VARCHAR(255) DEFAULT 'Nome Cartão' NOT NULL,
                flag_id VARCHAR(255) DEFAULT 'Flag ID' NOT NULL,
                CONSTRAINT card_id PRIMARY KEY (card_id)
);


ALTER SEQUENCE public.cards_card_id_seq OWNED BY public.cards.card_id;

CREATE TABLE public.vendors (
                vendor_id CHAR(36) NOT NULL,
                name VARCHAR(255) NOT NULL,
                cnpj CHAR(18) NOT NULL,
                email VARCHAR(255) NOT NULL,
                avatar VARCHAR(255) DEFAULT 'uploads/no-pic.jpg' NOT NULL,
                banner VARCHAR(255) DEFAULT 'uploads/no-pic.jpg' NOT NULL,
                cpf CHAR(14) DEFAULT '000.000.000-00' NOT NULL,
                temp_closed BOOLEAN DEFAULT false NOT NULL,
                CONSTRAINT vendorid PRIMARY KEY (vendor_id)
);


CREATE TABLE public.vendor_branchs (
                vendor_branch_id CHAR(36) NOT NULL,
                address VARCHAR(255) NOT NULL,
                phone VARCHAR(14) NOT NULL,
                coordinates VARCHAR(255),
                minimum_value NUMERIC(8,2),
                delivery_time_min INTEGER,
                close TIME DEFAULT '22:00' NOT NULL,
                open TIME DEFAULT '8:00' NOT NULL,
                delivery_time_max INTEGER,
                vendor_id CHAR(36) NOT NULL,
                city_id INTEGER DEFAULT 0 NOT NULL,
                CONSTRAINT vendor_branch_id PRIMARY KEY (vendor_branch_id)
);


CREATE TABLE public.vendor_market_types (
                vendor_market_type_id CHAR(36) NOT NULL,
                market_type_id INTEGER NOT NULL,
                vendor_branch_id CHAR(36) NOT NULL,
                CONSTRAINT vendor_market_type_id PRIMARY KEY (vendor_market_type_id)
);


CREATE TABLE public.card_options (
                card_option_id CHAR(36) NOT NULL,
                card_id INTEGER NOT NULL,
                vendor_branch_id CHAR(36) NOT NULL,
                CONSTRAINT card_option_id PRIMARY KEY (card_option_id)
);


CREATE TABLE public.vendors_operation (
                vendor_operation_id CHAR(36) NOT NULL,
                day_week INTEGER DEFAULT 0 NOT NULL,
                open TIME DEFAULT '12:00' NOT NULL,
                close TIME DEFAULT '18:00' NOT NULL,
                vendor_branch_id CHAR(36) NOT NULL,
                CONSTRAINT vendor_operation_id PRIMARY KEY (vendor_operation_id)
);


CREATE TABLE public.vendor_fees (
                vendor_fee_id CHAR(36) NOT NULL,
                fee NUMERIC(8,2) DEFAULT 0 NOT NULL,
                time_min INTEGER,
                time_max INTEGER,
                vendor_branch_id CHAR(36) NOT NULL,
                CONSTRAINT vendor_fee_id PRIMARY KEY (vendor_fee_id)
);


CREATE TABLE public.users (
                user_id CHAR(36) NOT NULL,
                name VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL,
                city_id INTEGER DEFAULT 0 NOT NULL,
                phone CHAR(14) NOT NULL,
                address VARCHAR(255),
                image VARCHAR(255) DEFAULT 'uploads/no-pic.jpg' NOT NULL,
                CONSTRAINT user_id PRIMARY KEY (user_id)
);


CREATE TABLE public.orders (
                order_id CHAR(36) NOT NULL,
                order_schedule TIMESTAMP NOT NULL,
                delivery_address VARCHAR(255),
                conclude_schedule TIMESTAMP,
                total_price NUMERIC(8,2) NOT NULL,
                address VARCHAR(255),
                user_id CHAR(36) NOT NULL,
                vendor_branch_id CHAR(36) NOT NULL,
                CONSTRAINT order_id PRIMARY KEY (order_id)
);


CREATE TABLE public.rating (
                rating_id CHAR(36) NOT NULL,
                note INTEGER DEFAULT 5 NOT NULL,
                comment TEXT,
                order_id CHAR(36) NOT NULL,
                user_id CHAR(36) NOT NULL,
                schedule DATE NOT NULL,
                vendor_branch_id CHAR(36) NOT NULL,
                CONSTRAINT rating_id PRIMARY KEY (rating_id)
);


CREATE TABLE public.product_categories (
                category_id CHAR(36) NOT NULL,
                name VARCHAR(255) NOT NULL,
                image VARCHAR(255) DEFAULT 'uploads/no-pic.jpg' NOT NULL,
                description TEXT,
                active BOOLEAN DEFAULT true NOT NULL,
                CONSTRAINT category_id PRIMARY KEY (category_id)
);


CREATE TABLE public.product_types (
                type_id CHAR(36) NOT NULL,
                name VARCHAR(255) NOT NULL,
                description TEXT,
                image VARCHAR(255) DEFAULT 'uploads/no-pic.jpg' NOT NULL,
                active BOOLEAN DEFAULT true NOT NULL,
                category_id CHAR(36) NOT NULL,
                CONSTRAINT type_id PRIMARY KEY (type_id)
);


CREATE TABLE public.products (
                product_id CHAR(36) NOT NULL,
                name VARCHAR(255) NOT NULL,
                description TEXT,
                type_id CHAR(36) NOT NULL,
                image VARCHAR(255) DEFAULT 'uploads/no-pic.jpg' NOT NULL,
                price NUMERIC(8,2) NOT NULL,
                active BOOLEAN DEFAULT true NOT NULL,
                vendor_branch_id CHAR(36) NOT NULL,
                CONSTRAINT product_id PRIMARY KEY (product_id)
);


CREATE TABLE public.promotions (
                promotion_id CHAR(36) NOT NULL,
                description TEXT,
                price NUMERIC(8,2) DEFAULT 0.0 NOT NULL,
                product_id CHAR(36) NOT NULL,
                vendor_branch_id CHAR(36) NOT NULL,
                CONSTRAINT promotion_id PRIMARY KEY (promotion_id)
);


CREATE TABLE public.order_products (
                order_product_id CHAR(36) NOT NULL,
                order_id CHAR(36) NOT NULL,
                product_id CHAR(36) NOT NULL,
                comments TEXT,
                quantity INTEGER DEFAULT 1 NOT NULL,
                CONSTRAINT order_product_id PRIMARY KEY (order_product_id)
);


ALTER TABLE public.cities ADD CONSTRAINT estados_cities_fk
FOREIGN KEY (estado_id)
REFERENCES public.estados (estado_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.market_types ADD CONSTRAINT markets_market_types_fk
FOREIGN KEY (industry_id)
REFERENCES public.industry (industry_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.vendor_market_types ADD CONSTRAINT market_types_vendor_market_types_fk
FOREIGN KEY (market_type_id)
REFERENCES public.market_types (market_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.card_options ADD CONSTRAINT cards_payment_options_fk
FOREIGN KEY (card_id)
REFERENCES public.cards (card_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.vendor_branchs ADD CONSTRAINT vendors_vendor_cities_fk
FOREIGN KEY (vendor_id)
REFERENCES public.vendors (vendor_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.vendor_fees ADD CONSTRAINT vendor_cities_vendor_fees_fk
FOREIGN KEY (vendor_branch_id)
REFERENCES public.vendor_branchs (vendor_branch_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.vendors_operation ADD CONSTRAINT vendor_cities_vendors_operation_fk
FOREIGN KEY (vendor_branch_id)
REFERENCES public.vendor_branchs (vendor_branch_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.card_options ADD CONSTRAINT vendor_branchs_card_options_fk
FOREIGN KEY (vendor_branch_id)
REFERENCES public.vendor_branchs (vendor_branch_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.orders ADD CONSTRAINT vendor_branchs_orders_fk
FOREIGN KEY (vendor_branch_id)
REFERENCES public.vendor_branchs (vendor_branch_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.products ADD CONSTRAINT vendor_branchs_products_fk
FOREIGN KEY (vendor_branch_id)
REFERENCES public.vendor_branchs (vendor_branch_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.promotions ADD CONSTRAINT vendor_branchs_promotions_fk
FOREIGN KEY (vendor_branch_id)
REFERENCES public.vendor_branchs (vendor_branch_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.rating ADD CONSTRAINT vendor_branchs_rating_fk
FOREIGN KEY (vendor_branch_id)
REFERENCES public.vendor_branchs (vendor_branch_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.vendor_market_types ADD CONSTRAINT vendor_branchs_vendor_market_types_fk
FOREIGN KEY (vendor_branch_id)
REFERENCES public.vendor_branchs (vendor_branch_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.orders ADD CONSTRAINT users_orders_fk
FOREIGN KEY (user_id)
REFERENCES public.users (user_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.rating ADD CONSTRAINT users_rating_fk
FOREIGN KEY (user_id)
REFERENCES public.users (user_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_products ADD CONSTRAINT orders_order_itens_fk
FOREIGN KEY (order_id)
REFERENCES public.orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.rating ADD CONSTRAINT orders_rating_fk
FOREIGN KEY (order_id)
REFERENCES public.orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.product_types ADD CONSTRAINT product_categories_products_fk
FOREIGN KEY (category_id)
REFERENCES public.product_categories (category_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.products ADD CONSTRAINT products_product_types_fk
FOREIGN KEY (type_id)
REFERENCES public.product_types (type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_products ADD CONSTRAINT product_types_order_itens_fk
FOREIGN KEY (product_id)
REFERENCES public.products (product_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.promotions ADD CONSTRAINT products_promotions_fk
FOREIGN KEY (product_id)
REFERENCES public.products (product_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;