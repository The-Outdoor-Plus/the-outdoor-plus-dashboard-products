/**
 *
 * Defining Interfaces
 *
 */
export interface Attribute {
  id?: number;
  name?: string;
  table_name?: string;
  slug?: string;
  attribute_value?: AttributeValue[];
  fill_values?: boolean;
}

export interface AttributeValues {
  [key: number]: AttributeValue[];
}
export interface AttributeValue {
  id?: number;
  attribute_id?: number;
  value?: string;
  material_id?: number;
  color_id?: number;
  gas_id?: number;
  ignition_id?: number;
  slug?: string;
  material?: Material;
  color?: Color;
  gas?: GasType;
  ignition?: IgnitionType;
}

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
  // color: Color[];
  gas?: GasType[];
  ignition?: IgnitionType[];
  // material: Material[];
  shape: Shape[];
  // baseColor: Color[];
}

export interface Image {
  id?: number | null;
  url?: string;
  name?: string;
  display_order?: number;
  is_primary?: boolean;
  product_id?: number;
}

export interface SpecificationSheet {
  id?: number;
  url?: string;
  name?: string;
  product_id?: number;
  variation_id?: number;
  specification_sheet_id?: number;
}

export interface Documents {
  id?: number;
  url?: string;
  name?: string;
  product_id?: number;
  variation_id?: number;
  document_id?: number;
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
  upc_codes?: string | null;
  encoded_upc_codes?: string | null;
  product_type?: string | null;
  product_length?: string | null;
  product_diameter?: string | null;
  product_width?: string | null;
  product_height?: string | null;
  base_length?: string | null;
  base_diameter?: string | null;
  base_width?: string | null;
  base_opening?: string | null;
  toe_kick?: string | null;
  soil_usage?: string | null;
  scupper_width?: string | null;
  scupper_inlet_opening?: string | null;
  gpm?: string | null;
  fire_glass?: string | null;
  ba_length?: string | null;
  ba_diameter?: string | null;
  ba_width?: string | null;
  ba_depth?: string | null;
  burner_shape?: string | null;
  burner_length?: string | null;
  burner_diameter?: string | null;
  compatible_canvas_cover?: string | null;
  compatible_bullet_burner?: string | null;
  compatible_glass_wind_guard?: string | null;
  access_door?: boolean | null;
  parent_id?: number | null;
  collection_id?: number | null;
  category_id?: number | null;
  shape_id?: number | null;
  material_id?: number | null;
  color_id?: number | null;
  ignition_id?: number | null;
  gas_id?: number | null;
  product_serial_base?: string | null;
  certifications?: string[];
  base_color_id?: number | null;
  base_material_id?: number | null;
  published?: boolean | null;
  enabled?: boolean | null;
  created_by?: string | null;
  updated_by?: string | null;
  company_division?: string | null;
  updated_at?: string | null;
  created_at?: string | null;
  name?: string;
  short_description?: string | null;
  description?: string | null;
  dealer_prices?: Price[];
  distributor_prices?: Price[];
  group_prices?: Price[];
  internet_prices?: Price[];
  landscape_prices?: Price[];
  map_prices?: Price[];
  master_distributor_prices?: Price[];
  msrp_prices?: Price[];
  images?: ProductImage[];
  website_link?: string | null;
}

export interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  product?: Product | null;
  loading?: boolean;
  productPrices?: PriceData;
  // productAttributes?: { colors: number[] | any, baseColors: number[] | any, ignitionTypes: number[] | any, gasTypes: number[] | any };
  attributeValues?: number[];
  productAttributes?: Attribute[];
  productImages?: Image[];
  productSpectSheets?: SpecificationSheet[];
  productDocuments?: Documents[];
}

export interface Attrs {
  [x: string]: string | number | undefined;
  product_id: number;
  type: string | undefined;
}
