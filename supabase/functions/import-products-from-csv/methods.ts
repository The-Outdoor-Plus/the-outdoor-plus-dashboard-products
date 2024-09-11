import {
  RecordData,
  Parent,
  ProductType,
  AttributeIds,
  AttributeFillValues,
  ProductAttributeValuesIds,
  VariationAttributeValue,
  Product,
  Variation
} from "../_shared/types/products.ts";
import { SupabaseClient } from "https://esm.sh/@supabase/supabase-js@2";
import { Database } from "../_shared/types/supabase.ts";
import { keys } from "./filter-keys.ts";

export const transformRecordData = (parsedData: Record<string, string>[]): RecordData[] =>
  parsedData.map(row => {
    const transformedRow: RecordData = {
      id: row.id,
      sku: row.sku,
      name: row.name,
      parent_id: row.parent_id as Parent,
      dealer_price: row.dealer_price,
      images: row.images,
      specification_sheets: row.specification_sheets,
      documents: row.documents,
      burner_shape: row.burner_shape,
      access_door: row.access_door,
      collection_id: row.collection_id,
      shape_id: row.shape_id,
      product_serial_base: row.product_serial_base,
      certifications: row.certifications,
      published: row.published,
      enabled: row.enabled,
      company_division: row.company_division,
      short_description: row.short_description,
      description: row.description,
      product_type: row.product_type as ProductType,
      website_link: row.website_link,
      meta: row.meta,
      product_meta: row.product_meta,
      sku_formula: row.sku_formula,
      upc_codes: row.upc_codes,
      encoded_upc_codes: row.encoded_upc_codes,
      product_length: row.product_length,
      product_diameter: row.product_diameter,
      product_width: row.product_width,
      product_height: row.product_height,
      base_length: row.base_length,
      base_diameter: row.base_diameter,
      base_width: row.base_width,
      base_opening: row.base_opening,
      toe_kick: row.toe_kick,
      soil_usage: row.soil_usage,
      scupper_width: row.scupper_width,
      scupper_inlet_opening: row.scupper_inlet_opening,
      gpm: row.gpm,
      fire_glass: row.fire_glass,
      ba_length: row.ba_length,
      ba_diameter: row.ba_diameter,
      ba_width: row.ba_width,
      ba_depth: row.ba_depth,
      burner_length: row.burner_length,
      btu: row.btu,
      compatible_canvas_cover: row.compatible_canvas_cover,
      compatible_bullet_burner: row.compatible_bullet_burner,
      compatible_glass_wind_guard: row.compatible_glass_wind_guard,
      category_id: row.category_id,
      burner_diameter: row.burner_diameter,
    };

    Object.keys(row).forEach((key) => {
      if (key.startsWith('attribute_id_')) {
        transformedRow[key as AttributeIds] = row[key];
      } else if (key.startsWith('attribute_fill_values_')) {
        transformedRow[key as AttributeFillValues] = row[key];
      } else if (key.startsWith('product_attribute_values_ids_')) {
        transformedRow[key as ProductAttributeValuesIds] = row[key];
      } else if (key.startsWith('variation_attribute_value_')) {
        transformedRow[key as VariationAttributeValue] = row[key];
      }
    });

    return transformedRow;
  });

export const extractStrArray = (arrayStr: string): string[] => {
  return arrayStr.split(',');
}

export const extractNumberArray = (numberArray: string): number[] => {
  return numberArray.split(',').map(num => +num);
}

export const extractProducts = (recordData: RecordData[]): Product[] => {
  return recordData.reduce<Product[]>((productFiltered, row) => {
    if (!row.parent_id) {
      const parent: Product = {
        id: +row?.id || null,
        sku: row.sku,
        name: row.name,
        dealer_price: +row?.dealer_price || null,
        images: extractStrArray(row.images),
        documents: extractStrArray(row.documents),
        specification_sheets: extractStrArray(row.specification_sheets),
        burner_shape: row.burner_shape || null,
        access_door: Boolean(row.access_door.toLowerCase() === 'true'),
        collection_id: +row?.collection_id || null,
        category_id: +row?.category_id || null,
        shape_id: +row?.shape_id || null,
        product_serial_base: row?.product_serial_base || null,
        certifications: extractStrArray(row.certifications),
        published: Boolean(row.published.toLowerCase() === 'true'),
        enabled: Boolean(row.enabled.toLowerCase() === 'true'),
        company_division: row?.company_division || null,
        short_description: row?.short_description || null,
        description: row?.description || null,
        product_type: row?.product_type || null,
        website_link: row?.website_link || null,
        meta: row?.meta || null,
        product_meta: row?.product_meta || null,
        sku_formula: row?.sku_formula || null,
        variations: recordData.reduce<Variation[]>((variantFiltered, rowChild) => {
          if (rowChild.parent_id) {
            const [_, parent_id] = rowChild.parent_id.split(':');
            console.log('SKu', rowChild.sku);
            console.log('Parent', parent_id);
            if (parent_id === row.id || parent_id.toLowerCase() === row.sku.toLowerCase()) {
              const variation: Variation = {
                id: +rowChild.id || null,
                sku: rowChild.sku,
                name: rowChild.sku,
                parent_id: parent_id === row.id ? +parent_id : null,
                dealer_price: +rowChild?.dealer_price || null,
                images: extractStrArray(rowChild.images),
                documents: extractStrArray(rowChild.documents),
                specification_sheets: extractStrArray(rowChild.specification_sheets),
                burner_shape: rowChild?.burner_shape || null,
                product_serial_base: rowChild?.product_serial_base || null,
                certifications: extractStrArray(rowChild.certifications),
                enabled: Boolean(rowChild?.enabled.toLowerCase() === 'true'),
                short_description: rowChild?.short_description || null,
                description: rowChild?.description || null,
                website_link: rowChild?.website_link || null,
                meta: rowChild?.meta || null,
                product_meta: rowChild?.product_meta || null,
                upc_codes: rowChild?.upc_codes || null,
                encoded_upc_codes: rowChild?.encoded_upc_codes || null,
                product_length: rowChild?.product_length || null,
                product_diameter: rowChild?.product_diameter || null,
                product_width: rowChild?.product_width || null,
                product_height: rowChild?.product_height || null,
                base_length: rowChild?.base_length || null,
                base_diameter: rowChild?.base_diameter || null,
                base_width: rowChild?.base_width || null,
                base_opening: rowChild?.base_opening || null,
                toe_kick: rowChild?.toe_kick || null,
                soil_usage: rowChild?.soil_usage || null,
                scupper_width: rowChild?.scupper_width || null,
                scupper_inlet_opening: rowChild?.scupper_inlet_opening || null,
                gpm: rowChild?.gpm || null,
                fire_glass: rowChild?.fire_glass || null,
                ba_length: rowChild?.ba_length || null,
                ba_diameter: rowChild?.ba_diameter || null,
                ba_width: rowChild?.ba_width || null,
                ba_depth: rowChild?.ba_depth || null,
                burner_length: rowChild?.burner_length || null,
                burner_diameter: rowChild?.burner_diameter || null,
                btu: rowChild?.btu || null,
                compatible_bullet_burner: rowChild?.compatible_bullet_burner || null,
                compatible_canvas_cover: rowChild?.compatible_canvas_cover || null,
                compatible_glass_wind_guard: rowChild?.compatible_glass_wind_guard || null,
              }

              Object.keys(rowChild).forEach((key) => {
                if (key.startsWith('attribute_id_')) {
                  variation[key as AttributeIds] = +row[key as AttributeIds];
                } else if (key.startsWith('variation_attribute_value_')) {
                  variation[key as VariationAttributeValue] = +row[key as VariationAttributeValue];
                }
              });

              variantFiltered.push(variation);
            }
          }
          return variantFiltered;
        }, [])
      }

      Object.keys(row).forEach((key) => {
        if (key.startsWith('attribute_id_')) {
          parent[key as AttributeIds] = +row[key as AttributeIds];
        } else if (key.startsWith('attribute_fill_values_')) {
          parent[key as AttributeFillValues] = Boolean(row[key as AttributeFillValues].toLowerCase() === 'true');
        } else if (key.startsWith('product_attribute_values_ids_')) {
          parent[key as ProductAttributeValuesIds] = extractNumberArray(row[key as ProductAttributeValuesIds]);
        }
      });

      productFiltered.push(parent);
    }
    return productFiltered;
  }, [])
}

export const filterFormPayload = <T>(form: Product, entityType: 'productKeys' | 'variationKeys'): T => (
  Object.fromEntries(Object.entries(form).filter(([key, value]) => {
    return keys[entityType].includes(key) && !!form[key as keyof Product];
  })) as T
);

export const handleCreateProduct = async(values: Product, supabaseClient: SupabaseClient<Database>) => {
  try {
    const form = JSON.parse(JSON.stringify(values));
    const { data: product, error } = await supabaseClient
      .from('product')
      .insert(form)
      .select();
    if (error) throw error;
    return product;
  } catch (e: any) {
    console.error(e);
    return e;
  }
}
