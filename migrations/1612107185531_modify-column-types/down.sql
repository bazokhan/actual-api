
alter table "public"."categories" drop constraint "categories_groupID_fkey";

alter table "public"."payees" drop constraint "payees_accountID_fkey";

DROP TRIGGER IF EXISTS "set_public_transactions_updated_at" ON "public"."transactions";
ALTER TABLE "public"."transactions" DROP COLUMN "updated_at";

ALTER TABLE "public"."transactions" DROP COLUMN "created_at";

alter table "public"."transactions" rename column "date" to "Date";

ALTER TABLE "public"."transactions" ADD COLUMN "date" int4;
ALTER TABLE "public"."transactions" ALTER COLUMN "date" DROP NOT NULL;

ALTER TABLE "public"."transactions" DROP COLUMN "Date";

alter table "public"."transactions" drop constraint "transactions_transferredID_fkey";

alter table "public"."transactions" drop constraint "transactions_categoryID_fkey";

ALTER TABLE "public"."transactions" ALTER COLUMN "payeeID" SET NOT NULL;

alter table "public"."transactions" drop constraint "transactions_payeeID_fkey";

alter table "public"."transactions" drop constraint "transactions_accountID_fkey";

alter table "public"."transactions" rename column "id" to "ID";

ALTER TABLE "public"."transactions" ADD COLUMN "id" text;
ALTER TABLE "public"."transactions" ALTER COLUMN "id" DROP NOT NULL;

alter table "public"."transactions" drop constraint "transactions_pkey";
alter table "public"."transactions"
    add constraint "transactions_pkey" 
    primary key ( "id" );

ALTER TABLE "public"."transactions" DROP COLUMN "ID";

ALTER TABLE "public"."transactions" ADD COLUMN "transferred_id" text;
ALTER TABLE "public"."transactions" ALTER COLUMN "transferred_id" DROP NOT NULL;

ALTER TABLE "public"."transactions" DROP COLUMN "transferredID";

ALTER TABLE "public"."transactions" ADD COLUMN "payee_id" text;
ALTER TABLE "public"."transactions" ALTER COLUMN "payee_id" DROP NOT NULL;

ALTER TABLE "public"."transactions" DROP COLUMN "payeeID";

ALTER TABLE "public"."transactions" ADD COLUMN "category_id" text;
ALTER TABLE "public"."transactions" ALTER COLUMN "category_id" DROP NOT NULL;

ALTER TABLE "public"."transactions" DROP COLUMN "categoryID";

ALTER TABLE "public"."transactions" ADD COLUMN "account_id" text;
ALTER TABLE "public"."transactions" ALTER COLUMN "account_id" DROP NOT NULL;

ALTER TABLE "public"."transactions" DROP COLUMN "accountID";

alter table "public"."pending_transactions" rename column "id" to "ID";

ALTER TABLE "public"."pending_transactions" ADD COLUMN "id" text;
ALTER TABLE "public"."pending_transactions" ALTER COLUMN "id" DROP NOT NULL;

alter table "public"."pending_transactions" drop constraint "pending_transactions_pkey";
alter table "public"."pending_transactions"
    add constraint "pending_transactions_pkey" 
    primary key ( "id" );

ALTER TABLE "public"."pending_transactions" DROP COLUMN "ID";

ALTER TABLE "public"."pending_transactions" ADD COLUMN "account_id" text;
ALTER TABLE "public"."pending_transactions" ALTER COLUMN "account_id" DROP NOT NULL;

ALTER TABLE "public"."pending_transactions" ADD COLUMN "payee_id" text;
ALTER TABLE "public"."pending_transactions" ALTER COLUMN "payee_id" DROP NOT NULL;

alter table "public"."pending_transactions" rename column "date" to "Date";

ALTER TABLE "public"."pending_transactions" ADD COLUMN "date" text;
ALTER TABLE "public"."pending_transactions" ALTER COLUMN "date" DROP NOT NULL;

ALTER TABLE "public"."pending_transactions" ADD CONSTRAINT "pending_transactions_payeeID_key" UNIQUE ("payeeID");

ALTER TABLE "public"."pending_transactions" ADD CONSTRAINT "pending_transactions_accountID_key" UNIQUE ("accountID");

ALTER TABLE "public"."payees" ADD CONSTRAINT "payees_categoryID_key" UNIQUE ("categoryID");

ALTER TABLE "public"."pending_transactions" DROP COLUMN "Date";

ALTER TABLE "public"."pending_transactions" DROP COLUMN "payeeID";

ALTER TABLE "public"."pending_transactions" DROP COLUMN "accountID";

alter table "public"."payees" rename column "id" to "ID";

ALTER TABLE "public"."payees" ADD COLUMN "id" text;
ALTER TABLE "public"."payees" ALTER COLUMN "id" DROP NOT NULL;

alter table "public"."payees" drop constraint "payees_pkey";
alter table "public"."payees"
    add constraint "payees_pkey" 
    primary key ( "id" );

ALTER TABLE "public"."payees" DROP COLUMN "ID";

ALTER TABLE "public"."payees" ADD COLUMN "category" text;
ALTER TABLE "public"."payees" ALTER COLUMN "category" DROP NOT NULL;

ALTER TABLE "public"."payees" DROP CONSTRAINT "payees_categoryID_key";

ALTER TABLE "public"."payees" DROP COLUMN "categoryID";

ALTER TABLE "public"."payees" ADD COLUMN "transfer_acct" text;
ALTER TABLE "public"."payees" ALTER COLUMN "transfer_acct" DROP NOT NULL;

ALTER TABLE "public"."payees" DROP COLUMN "accountID";

alter table "public"."groups" rename column "id" to "ID";

ALTER TABLE "public"."groups" ADD COLUMN "id" text;
ALTER TABLE "public"."groups" ALTER COLUMN "id" DROP NOT NULL;

alter table "public"."groups" drop constraint "groups_pkey";
alter table "public"."groups"
    add constraint "category_groups_pkey" 
    primary key ( "id" );

ALTER TABLE "public"."groups" DROP COLUMN "ID";

alter table "public"."groups" rename to "category_groups";

alter table "public"."categories" rename column "id" to "ID";

ALTER TABLE "public"."categories" ADD COLUMN "id" text;
ALTER TABLE "public"."categories" ALTER COLUMN "id" DROP NOT NULL;

alter table "public"."categories" drop constraint "categories_pkey";
alter table "public"."categories"
    add constraint "categories_pkey" 
    primary key ( "id" );

ALTER TABLE "public"."categories" DROP COLUMN "ID";

ALTER TABLE "public"."categories" ADD COLUMN "cat_group" text;
ALTER TABLE "public"."categories" ALTER COLUMN "cat_group" DROP NOT NULL;

ALTER TABLE "public"."categories" DROP COLUMN "groupID";

ALTER TABLE "public"."accounts" ADD COLUMN "account_id" text;
ALTER TABLE "public"."accounts" ALTER COLUMN "account_id" DROP NOT NULL;

ALTER TABLE "public"."accounts" DROP COLUMN "accountID";

alter table "public"."accounts" rename column "id" to "id_key";

ALTER TABLE "public"."accounts" ADD COLUMN "id" text;
ALTER TABLE "public"."accounts" ALTER COLUMN "id" DROP NOT NULL;

alter table "public"."accounts" drop constraint "accounts_pkey";
alter table "public"."accounts"
    add constraint "accounts_pkey" 
    primary key ( "id" );

alter table "public"."pending_transactions" add foreign key ("account_id") references "public"."accounts"("id") on update cascade on delete cascade;

alter table "public"."pending_transactions" drop constraint "pending_transactions_account_id_fkey",
          add constraint "pending_transactions_acct_fkey"
          foreign key ("account_id")
          references "public"."accounts"
          ("id")
          on update no action
          on delete no action;
