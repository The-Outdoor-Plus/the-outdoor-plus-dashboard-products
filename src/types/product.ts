/**
 * 
 * Defining Interfaces
 * 
 */
export interface Shape {
  id?: number;
  name: string;
}

export interface Material {
  id?: number;
  name: string;
}

export interface IgnitionType {
  id?: number;
  name: string;
}

export interface GasType {
  id?: number;
  name: string;
}

export interface Color {
  id?: number;
  name: string;
}

export interface Collection {
  id?: number;
  name: string;
}

export interface Category {
  id?: number;
  name: string;
}

export interface ItemsList {
  category: Category[];
  collection: Collection[];
  color: Color[];
  gas: GasType[];
  ignition: IgnitionType[];
  material: Material[];
  shape: Shape[];
  baseColor: Color[];
}

export interface Price {
  id?: number;
  product_id?: number;
  price?: number;
  year?: number;
}

export interface PriceData {
  msrp: Price[];
  map: Price[];
  internet: Price[];
  group: Price[];
  dealer: Price[];
  distributor: Price[];
  landscape: Price[];
  master_distributor: Price[];
}

export interface ProductImage {
  product_id?: number;
  image_id?: number;
  display_order?: number;
  is_primary?: boolean;
  url?: string;
  name?: string;
}

export interface Product {
  id?: number;
  sku?: string
  upc_codes?: string;
  encoded_upc_codes?: string;
  relation?: string;
  product_length?: string;
  product_diameter?: string;
  product_width?: string;
  product_height?: string;
  base_length?: string;
  base_diameter?: string;
  base_width?: string;
  base_opening?: string;
  toe_kick?: string;
  soil_usage?: string;
  scupper_width?: string;
  scupper_inlet_opening?: string;
  gpm?: string;
  fire_glass?: string;
  ba_length?: string;
  ba_diameter?: string;
  ba_width?: string;
  ba_depth?: string;
  burner_shape?: string;
  burner_length?: string;
  burner_diameter?: string;
  compatible_canvas_cover?: string;
  compatible_bullet_burner?: string;
  compatible_glass_wind_guard?: string;
  access_door?: boolean;
  parent_id?: number;
  collection_id?: number | null;
  category_id?: number | null;
  shape_id?: number | null;
  material_id?: number | null;
  color_id?: number | null;
  ignition_id?: number | null;
  gas_id?: number | null;
  product_serial_base?: string;
  certifications?: string[];
  base_color_id?: number | null;
  base_material_id?: number | null;
  published?: boolean;
  enabled?: boolean;
  created_by?: string;
  updated_by?: string;
  company_division?: string;
  updated_at?: string;
  created_at?: string;
  name?: string;
  short_description?: string;
  description?: string;
  dealer_prices?: Price[];
  distributor_prices?: Price[];
  group_prices?: Price[];
  internet_prices?: Price[];
  landscape_prices?: Price[];
  map_prices?: Price[];
  master_distributor_prices?: Price[];
  msrp_prices?: Price[];
  images?: ProductImage[];
}

export interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  product?: Product | null;
  loading?: boolean;
}