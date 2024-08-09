alter table "public"."gas" add column "sku_code" text;

CREATE UNIQUE INDEX gas_sku_code_key ON public.gas USING btree (sku_code);

alter table "public"."gas" add constraint "gas_sku_code_key" UNIQUE using index "gas_sku_code_key";