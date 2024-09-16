import { TablesInsert } from "./supabase.ts";

export type ProductType = 'VARIABLE' | 'SIMPLE' | '';

export type Parent = `SKU:${string}` | `ID:${string}` | '';
export type TableName = 'product_image' | 'variation_image';
export type FileType = 'image' | 'documents' | 'specification_sheet';
export type EntityForm = TablesInsert<'product_image'> | TablesInsert<'variation_image'> |
  TablesInsert<'product_documents'> | TablesInsert<'variation_documents'> |
  TablesInsert<'product_specification_sheet'> | TablesInsert<'variation_specification_sheet'> | null;
export type FileForm = TablesInsert<'image'> | TablesInsert<'documents'> | TablesInsert<'specification_sheet'>;
export type FileTypeExtension = '.jpg' | '.pdf';
export type ColumName = 'product_id' | 'variation_id';
export type RntityType = 'product' | 'variation';

export type AttributeIds = `attribute_id_${number}`;
export type AttributeFillValues = `attribute_fill_values_${number}`;
export type ProductAttributeValuesIds = `product_attribute_values_ids_${number}`;
export type VariationAttributeValue = `variation_attribute_value_${number}`;
export type GroupedAttributesKey = `attribute_${number}`;

export interface ProductGroupedAttributes {
  attribute_id: number;
  attribute_fill_values: boolean;
  product_attribute_values_ids: number[];
}

export interface VariationGroupedAttributes {
  attribute_id: number;
  variation_attribute_value: number;
}

export interface RecordData {
  id: string;
  sku: string;
  name: string;
  parent_id: Parent;
  dealer_price: string;
  images: string;
  specification_sheets: string;
  documents: string;
  burner_shape: string;
  access_door: string;
  collection_id: string;
  category_id: string;
  shape_id: string;
  product_serial_base: string;
  certifications: string;
  published: string;
  enabled: string;
  company_division: string;
  short_description: string;
  description: string;
  product_type: ProductType;
  website_link: string;
  meta: string;
  product_meta: string;
  sku_formula: string;
  [key: AttributeIds]: string;
  [key: AttributeFillValues]: string;
  [key: ProductAttributeValuesIds]: string;
  [key: VariationAttributeValue]: string;
  upc_codes: string;
  encoded_upc_codes: string;
  product_length: string;
  product_diameter: string;
  product_width: string;
  product_height: string;
  base_length: string;
  base_diameter: string;
  base_width: string;
  base_opening: string;
  toe_kick: string;
  soil_usage: string;
  scupper_width: string;
  scupper_inlet_opening: string;
  gpm: string;
  fire_glass: string;
  ba_length: string;
  ba_diameter: string;
  ba_width: string;
  ba_depth: string;
  burner_length: string;
  burner_diameter: string;
  btu: string;
  compatible_canvas_cover: string;
  compatible_bullet_burner: string;
  compatible_glass_wind_guard: string;
}

export interface Variation {
  id: number | null;
  sku: string;
  name: string;
  parent_id: number | null;
  dealer_price: number | null;
  images: string[];
  specification_sheets: string[];
  documents: string[];
  burner_shape: string | null;
  product_serial_base: string | null;
  certifications: string[];
  enabled: boolean;
  short_description: string | null;
  description: string | null;
  website_link: string | null;
  meta: string | null;
  product_meta: string | null;
  [key: AttributeIds]: number | null;
  [key: VariationAttributeValue]: number | null;
  upc_codes: string | null;
  encoded_upc_codes: string | null;
  product_length: string | null;
  product_diameter: string | null;
  product_width: string | null;
  product_height: string | null;
  base_length: string | null;
  base_diameter: string | null;
  base_width: string | null;
  base_opening: string | null;
  toe_kick: string | null;
  soil_usage: string | null;
  scupper_width: string | null;
  scupper_inlet_opening: string | null;
  gpm: string | null;
  fire_glass: string | null;
  ba_length: string | null;
  ba_diameter: string | null;
  ba_width: string | null;
  ba_depth: string | null;
  burner_length: string | null;
  burner_diameter: string | null;
  btu: string | null;
  compatible_canvas_cover: string | null;
  compatible_bullet_burner: string | null;
  compatible_glass_wind_guard: string | null;
}

export interface Product {
  id: number | null;
  sku: string;
  name: string;
  dealer_price: number | null;
  images: string[];
  specification_sheets: string[];
  documents: string[];
  burner_shape: string | null;
  access_door: boolean;
  collection_id: number | null;
  category_id: number | null;
  shape_id: number | null;
  product_serial_base: string | null;
  certifications: string[];
  published: boolean;
  enabled: boolean;
  company_division: string | null;
  short_description: string | null;
  description: string | null;
  product_type: ProductType | null;
  website_link: string | null;
  meta: string | null;
  product_meta: string | null;
  sku_formula: string | null;
  [key: AttributeIds]: number;
  [key: AttributeFillValues]: boolean;
  [key: ProductAttributeValuesIds]: number[];
  variations?: Variation[];
}

export interface ProductImage {
  product_id?: number | null;
  display_order?: number | null;
  is_primary?: boolean | null;
  variation_id?: number | null;
  image_id?: number | null;
}
