alter table "public"."color" add column "sku_code" text;

CREATE UNIQUE INDEX color_sku_code_key ON public.color USING btree (sku_code);

alter table "public"."color" add constraint "color_sku_code_key" UNIQUE using index "color_sku_code_key";