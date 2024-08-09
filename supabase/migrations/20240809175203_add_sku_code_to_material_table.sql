alter table "public"."material" add column "sku_code" text;

CREATE UNIQUE INDEX material_sku_code_key ON public.material USING btree (sku_code);

alter table "public"."material" add constraint "material_sku_code_key" UNIQUE using index "material_sku_code_key";