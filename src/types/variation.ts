import { Documents, Image, PriceData, SpecificationSheet } from "./product";

/**
 *
 * Defining Interfaces
 *
 */
export interface Variation {
  id?: number;
  sku?: string;
  name?: string | null;
  enabled?: boolean | null;
  upc_codes?: string | null;
  encoded_upc_codes?: string | null;
  short_description?: string | null;
  description?: string | null;
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
  product_serial_base?: string | null;
  website_link?: string | null;
  certifications?: string[];
}

export interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  loading?: boolean;
  variation?: Variation | null;
  variationPrices?: PriceData;
  variationImages?: Image[];
  variationSpecSheets?: SpecificationSheet[];
  variationDocuments?: Documents[];
}
