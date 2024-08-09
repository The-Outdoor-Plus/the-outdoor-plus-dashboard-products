alter table "public"."color" drop constraint "color_sku_code_key";

alter table "public"."gas" drop constraint "gas_sku_code_key";

alter table "public"."ignition" drop constraint "ignition_sku_code_key";

alter table "public"."material" drop constraint "material_sku_code_key";

drop index if exists "public"."color_sku_code_key";

drop index if exists "public"."gas_sku_code_key";

drop index if exists "public"."ignition_sku_code_key";

drop index if exists "public"."material_sku_code_key";