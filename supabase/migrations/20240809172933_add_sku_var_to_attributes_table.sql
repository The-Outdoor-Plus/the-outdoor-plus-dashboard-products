alter table "public"."attributes" add column "sku_var" text;

CREATE UNIQUE INDEX attributes_sku_var_key ON public.attributes USING btree (sku_var);

alter table "public"."attributes" add constraint "attributes_sku_var_key" UNIQUE using index "attributes_sku_var_key";