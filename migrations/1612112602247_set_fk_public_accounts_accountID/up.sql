alter table "public"."accounts"
           add constraint "accounts_accountID_fkey"
           foreign key ("accountID")
           references "public"."accounts"
           ("id") on update cascade on delete set null;
