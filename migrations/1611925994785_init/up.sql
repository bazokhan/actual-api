CREATE TABLE public.__migrations__ (
    id bigint NOT NULL
);
CREATE SEQUENCE public.__migrations___id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.__migrations___id_seq OWNED BY public.__migrations__.id;
CREATE TABLE public.accounts (
    id text NOT NULL,
    account_id text,
    name text,
    balance_current integer,
    balance_available integer,
    balance_limit integer,
    mask text,
    official_name text,
    type text,
    subtype text,
    bank text,
    offbudget integer DEFAULT 0,
    closed integer DEFAULT 0,
    tombstone integer DEFAULT 0
);
CREATE TABLE public.banks (
    id text NOT NULL,
    bank_id text,
    name text,
    tombstone integer DEFAULT 0
);
CREATE TABLE public.categories (
    id text NOT NULL,
    name text,
    is_income integer DEFAULT 0,
    cat_group text,
    sort_order real,
    tombstone integer DEFAULT 0
);
CREATE TABLE public.category_groups (
    id text NOT NULL,
    name text,
    is_income integer DEFAULT 0,
    sort_order real,
    tombstone integer DEFAULT 0
);
CREATE TABLE public.created_budgets (
    month text NOT NULL
);
CREATE TABLE public.messages_clock (
    id integer NOT NULL,
    clock text
);
CREATE TABLE public.messages_crdt (
    id integer NOT NULL,
    "timestamp" text NOT NULL,
    dataset text NOT NULL,
    "row" text NOT NULL,
    col text NOT NULL,
    value bytea NOT NULL
);
CREATE TABLE public.payee_rules (
    id text NOT NULL,
    payee_id text,
    type text,
    value text,
    tombstone integer DEFAULT 0
);
CREATE TABLE public.payees (
    id text NOT NULL,
    name text,
    category text,
    tombstone integer DEFAULT 0,
    transfer_acct text
);
CREATE TABLE public.pending_transactions (
    id text NOT NULL,
    account_id text,
    amount integer,
    payee_id text,
    date text
);
CREATE TABLE public.rules (
    id text NOT NULL,
    stage text,
    conditions text,
    actions text,
    tombstone integer DEFAULT 0
);
CREATE TABLE public.spreadsheet_cells (
    name text NOT NULL,
    expr text,
    cachedvalue text
);
CREATE TABLE public.transactions (
    id text NOT NULL,
    isparent integer DEFAULT 0,
    ischild integer DEFAULT 0,
    account_id text,
    category_id text,
    amount integer,
    payee_id text,
    notes text,
    date integer,
    financial_id text,
    type text,
    location text,
    error text,
    imported_description text,
    starting_balance_flag integer DEFAULT 0,
    transferred_id text,
    sort_order real,
    tombstone integer DEFAULT 0,
    cleared integer DEFAULT 1,
    pending integer DEFAULT 0
);
ALTER TABLE ONLY public.__migrations__ ALTER COLUMN id SET DEFAULT nextval('public.__migrations___id_seq'::regclass);
ALTER TABLE ONLY public.__migrations__
    ADD CONSTRAINT __migrations___pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.category_groups
    ADD CONSTRAINT category_groups_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.created_budgets
    ADD CONSTRAINT created_budgets_pkey PRIMARY KEY (month);
ALTER TABLE ONLY public.messages_clock
    ADD CONSTRAINT messages_clock_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.messages_crdt
    ADD CONSTRAINT messages_crdt_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.messages_crdt
    ADD CONSTRAINT messages_crdt_timestamp_key UNIQUE ("timestamp");
ALTER TABLE ONLY public.payee_rules
    ADD CONSTRAINT payee_rules_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.payees
    ADD CONSTRAINT payees_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.pending_transactions
    ADD CONSTRAINT pending_transactions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.spreadsheet_cells
    ADD CONSTRAINT spreadsheet_cells_pkey PRIMARY KEY (name);
ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
CREATE INDEX payee_rules_lowercase_index ON public.payee_rules USING btree (lower(value));
CREATE INDEX trans_category ON public.transactions USING btree (category_id);
CREATE INDEX trans_category_date ON public.transactions USING btree (category_id, date);
CREATE INDEX trans_date ON public.transactions USING btree (date);
ALTER TABLE ONLY public.pending_transactions
    ADD CONSTRAINT pending_transactions_acct_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id);
