
alter table "public"."pending_transactions" drop constraint "pending_transactions_acct_fkey",
             add constraint "pending_transactions_account_id_fkey"
             foreign key ("account_id")
             references "public"."accounts"
             ("id") on update cascade on delete cascade;

alter table "public"."pending_transactions" drop constraint "pending_transactions_account_id_fkey";

ALTER TABLE "public"."accounts" ADD COLUMN "ID" uuid NOT NULL UNIQUE DEFAULT gen_random_uuid();

alter table "public"."accounts" drop constraint "accounts_pkey";
alter table "public"."accounts"
    add constraint "accounts_pkey" 
    primary key ( "ID" );

ALTER TABLE "public"."accounts" DROP COLUMN "id" CASCADE;

alter table "public"."accounts" rename column "ID" to "id";

ALTER TABLE "public"."accounts" ADD COLUMN "accountID" uuid NULL;

ALTER TABLE "public"."accounts" DROP COLUMN "account_id" CASCADE;

ALTER TABLE "public"."categories" ADD COLUMN "groupID" uuid NULL;

ALTER TABLE "public"."categories" DROP COLUMN "cat_group" CASCADE;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
ALTER TABLE "public"."categories" ADD COLUMN "ID" uuid NOT NULL UNIQUE DEFAULT gen_random_uuid();

alter table "public"."categories" drop constraint "categories_pkey";
alter table "public"."categories"
    add constraint "categories_pkey" 
    primary key ( "ID" );

ALTER TABLE "public"."categories" DROP COLUMN "id" CASCADE;

alter table "public"."categories" rename column "ID" to "id";

alter table "public"."category_groups" rename to "groups";

CREATE EXTENSION IF NOT EXISTS pgcrypto;
ALTER TABLE "public"."groups" ADD COLUMN "ID" uuid NOT NULL UNIQUE DEFAULT gen_random_uuid();

alter table "public"."groups" drop constraint "category_groups_pkey";
alter table "public"."groups"
    add constraint "groups_pkey" 
    primary key ( "ID" );

ALTER TABLE "public"."groups" DROP COLUMN "id" CASCADE;

alter table "public"."groups" rename column "ID" to "id";

ALTER TABLE "public"."payees" ADD COLUMN "accountID" uuid NULL UNIQUE;

ALTER TABLE "public"."payees" DROP COLUMN "transfer_acct" CASCADE;

ALTER TABLE "public"."payees" ADD COLUMN "categoryID" uuid NULL;

ALTER TABLE "public"."payees" ADD CONSTRAINT "payees_categoryID_key" UNIQUE ("categoryID");

ALTER TABLE "public"."payees" DROP COLUMN "category" CASCADE;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
ALTER TABLE "public"."payees" ADD COLUMN "ID" uuid NOT NULL UNIQUE DEFAULT gen_random_uuid();

alter table "public"."payees" drop constraint "payees_pkey";
alter table "public"."payees"
    add constraint "payees_pkey" 
    primary key ( "ID" );

ALTER TABLE "public"."payees" DROP COLUMN "id" CASCADE;

alter table "public"."payees" rename column "ID" to "id";

ALTER TABLE "public"."pending_transactions" ADD COLUMN "accountID" uuid NOT NULL UNIQUE;

ALTER TABLE "public"."pending_transactions" ADD COLUMN "payeeID" uuid NOT NULL UNIQUE;

ALTER TABLE "public"."pending_transactions" ADD COLUMN "Date" date NULL;

ALTER TABLE "public"."payees" DROP CONSTRAINT "payees_categoryID_key";

ALTER TABLE "public"."pending_transactions" DROP CONSTRAINT "pending_transactions_accountID_key";

ALTER TABLE "public"."pending_transactions" DROP CONSTRAINT "pending_transactions_payeeID_key";

ALTER TABLE "public"."pending_transactions" DROP COLUMN "date" CASCADE;

alter table "public"."pending_transactions" rename column "Date" to "date";

ALTER TABLE "public"."pending_transactions" DROP COLUMN "payee_id" CASCADE;

ALTER TABLE "public"."pending_transactions" DROP COLUMN "account_id" CASCADE;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
ALTER TABLE "public"."pending_transactions" ADD COLUMN "ID" uuid NOT NULL UNIQUE DEFAULT gen_random_uuid();

alter table "public"."pending_transactions" drop constraint "pending_transactions_pkey";
alter table "public"."pending_transactions"
    add constraint "pending_transactions_pkey" 
    primary key ( "ID" );

ALTER TABLE "public"."pending_transactions" DROP COLUMN "id" CASCADE;

alter table "public"."pending_transactions" rename column "ID" to "id";

ALTER TABLE "public"."transactions" ADD COLUMN "accountID" uuid NOT NULL;

ALTER TABLE "public"."transactions" DROP COLUMN "account_id" CASCADE;

ALTER TABLE "public"."transactions" ADD COLUMN "categoryID" uuid NULL;

ALTER TABLE "public"."transactions" DROP COLUMN "category_id" CASCADE;

ALTER TABLE "public"."transactions" ADD COLUMN "payeeID" uuid NOT NULL;

ALTER TABLE "public"."transactions" DROP COLUMN "payee_id" CASCADE;

ALTER TABLE "public"."transactions" ADD COLUMN "transferredID" uuid NULL UNIQUE;

ALTER TABLE "public"."transactions" DROP COLUMN "transferred_id" CASCADE;

CREATE EXTENSION IF NOT EXISTS pgcrypto;
ALTER TABLE "public"."transactions" ADD COLUMN "ID" uuid NOT NULL UNIQUE DEFAULT gen_random_uuid();

alter table "public"."transactions" drop constraint "transactions_pkey";
alter table "public"."transactions"
    add constraint "transactions_pkey" 
    primary key ( "ID" );

ALTER TABLE "public"."transactions" DROP COLUMN "id" CASCADE;

alter table "public"."transactions" rename column "ID" to "id";

alter table "public"."transactions"
           add constraint "transactions_accountID_fkey"
           foreign key ("accountID")
           references "public"."accounts"
           ("id") on update cascade on delete cascade;

alter table "public"."transactions"
           add constraint "transactions_payeeID_fkey"
           foreign key ("payeeID")
           references "public"."payees"
           ("id") on update cascade on delete set null;

ALTER TABLE "public"."transactions" ALTER COLUMN "payeeID" DROP NOT NULL;

alter table "public"."transactions"
           add constraint "transactions_categoryID_fkey"
           foreign key ("categoryID")
           references "public"."categories"
           ("id") on update cascade on delete set null;

alter table "public"."transactions"
           add constraint "transactions_transferredID_fkey"
           foreign key ("transferredID")
           references "public"."transactions"
           ("id") on update cascade on delete cascade;

ALTER TABLE "public"."transactions" ADD COLUMN "Date" date NULL DEFAULT now();

ALTER TABLE "public"."transactions" DROP COLUMN "date" CASCADE;

alter table "public"."transactions" rename column "Date" to "date";

ALTER TABLE "public"."transactions" ADD COLUMN "created_at" timestamptz NULL DEFAULT now();

ALTER TABLE "public"."transactions" ADD COLUMN "updated_at" timestamptz NULL DEFAULT now();

CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_transactions_updated_at"
BEFORE UPDATE ON "public"."transactions"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_transactions_updated_at" ON "public"."transactions" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

alter table "public"."payees"
           add constraint "payees_accountID_fkey"
           foreign key ("accountID")
           references "public"."accounts"
           ("id") on update cascade on delete cascade;

alter table "public"."categories"
           add constraint "categories_groupID_fkey"
           foreign key ("groupID")
           references "public"."groups"
           ("id") on update cascade on delete set null;
