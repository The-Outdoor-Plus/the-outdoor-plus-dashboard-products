alter table "public"."ignition" add column "sku_code" text;

CREATE UNIQUE INDEX ignition_sku_code_key ON public.ignition USING btree (sku_code);

alter table "public"."ignition" add constraint "ignition_sku_code_key" UNIQUE using index "ignition_sku_code_key";