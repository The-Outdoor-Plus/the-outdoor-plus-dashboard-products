import {
  RecordData,
  Parent,
  ProductType,
  AttributeIds,
  AttributeFillValues,
  ProductAttributeValuesIds,
  VariationAttributeValue,
  Product,
  Variation,
  TableName,
  ColumName,
  ProductImage,
  FileTypeExtension,
  FileType,
  FileForm,
  EntityForm,
  ProductGroupedAttributes,
  GroupedAttributesKey,
  VariationGroupedAttributes,
} from "../_shared/types/products.ts";
import { SupabaseClient } from "https://esm.sh/@supabase/supabase-js@2";
import { Database, TablesInsert } from "../_shared/types/supabase.ts";
import { keys } from "./filter-keys.ts";
import { slugify } from "../_shared/functions.ts";

const fileTypeExtension = (fileType: FileType): FileTypeExtension => ({
    'image': '.jpg' as FileTypeExtension,
    'documents': '.pdf' as FileTypeExtension,
    'specification_sheet': '.pdf' as FileTypeExtension,
})[fileType] || '.jpg' as FileTypeExtension;

const tableName = (prodType: string, fileType: FileType): TableName => ({
  'product': `product_${fileType || 'image'}` as TableName,
  'variation': `variation_${fileType || 'image'}` as TableName,
})[prodType] || `product_${fileType || 'image'}` as TableName;

const columnName = (prodType: string): ColumName => ({
  'product': 'product_id' as ColumName,
  'variation': 'variation_id' as ColumName,
})[prodType] || 'product_id' as ColumName;

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

export const extractStrArray = (arrayStr: string): string[] =>
  arrayStr.split(',');

export const extractNumberArray = (numberArray: string): number[] =>
  numberArray.split(',').map(num => +num);

export function extractProducts(recordData: RecordData[]): Product[] {
  return recordData.reduce<Product[]>((productFiltered, row) => {
    if (!row.parent_id) {
      const parent: Product = {
        id: +row?.id || null,
        sku: row.sku,
        name: row.name,
        dealer_price: parseFloat(row?.dealer_price.replace(',', '')) || null,
        images: extractStrArray(row.images).filter(img => !!img),
        documents: extractStrArray(row.documents).filter(doc => !!doc),
        specification_sheets: extractStrArray(row.specification_sheets).filter(spec => !!spec),
        burner_shape: row.burner_shape || null,
        access_door: Boolean(row.access_door.toLowerCase() === 'true'),
        collection_id: +row?.collection_id || null,
        category_id: +row?.category_id || null,
        shape_id: +row?.shape_id || null,
        product_serial_base: row?.product_serial_base || null,
        certifications: extractStrArray(row.certifications).filter(cert => !!cert),
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
            if (parent_id === row.id || parent_id.toLowerCase() === row.sku.toLowerCase()) {
              const variation: Variation = {
                id: +rowChild.id || null,
                sku: rowChild.sku,
                name: rowChild.sku,
                parent_id: parent_id === row.id ? +parent_id : null,
                dealer_price: parseFloat(rowChild?.dealer_price.replace(',', '')) || null,
                images: extractStrArray(rowChild.images).filter(img => !!img),
                documents: extractStrArray(rowChild.documents).filter(doc => !!doc),
                specification_sheets: extractStrArray(rowChild.specification_sheets).filter(spec => !!spec),
                burner_shape: rowChild?.burner_shape || null,
                product_serial_base: rowChild?.product_serial_base || null,
                certifications: extractStrArray(rowChild.certifications).filter(cert => !!cert),
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
                  variation[key as VariationAttributeValue] = +rowChild[key as VariationAttributeValue];
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

export const filterFormPayload = <T extends Product | Variation>(form: T, entityType: 'productKeys' | 'variationKeys'): T => (
  Object.fromEntries(Object.entries(form).filter(([key, value]) => {
    return keys[entityType].includes(key) && !!form[key as keyof T];
  })) as T
);

export async function handleCreateProduct(values: Product, supabaseClient: SupabaseClient<Database>) {
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

export async function insertVariation(values: Variation, supabaseClient: SupabaseClient<Database>) {
  try {
    const form = JSON.parse(JSON.stringify(values));
    const { data: variation, error } = await supabaseClient
      .from('variation')
      .insert(form)
      .select();
    if (error) throw error;
    return variation;
  } catch (e: any) {
    console.error(e);
    return e;
  }
}

export async function handleCreateVariation(values: Variation, supabaseClient: SupabaseClient<Database>) {
  try {
    const variationForm = filterFormPayload<Variation>(values, 'variationKeys');
    const newVariation = await insertVariation(variationForm, supabaseClient);
    let variationConfigurationResponse = null;

    if (newVariation && newVariation[0].id) {
      await handleFiles(newVariation[0].id || 0, newVariation[0].name, 'variation', values.images, supabaseClient, 'image');
      await handleFiles(newVariation[0].id || 0, newVariation[0].name, 'variation', values.specification_sheets, supabaseClient, 'specification_sheet');
      await handleFiles(newVariation[0].id || 0, newVariation[0].name, 'variation', values.documents, supabaseClient, 'documents');

      variationConfigurationResponse = await handleVariationAttributes(values, newVariation[0].id, supabaseClient);
    }
    return {
      newVariation: newVariation[0],
      variationConfigurationResponse,
    }
  } catch (e: any) {
    console.error(e);
    return e;
  }
}

export function groupProductAttributesByNumber(product: Product): ProductGroupedAttributes[] {
  const groupedAttributes: ProductGroupedAttributes[] = [];

  Object.keys(product).forEach((key) => {
    if (key.startsWith('attribute_id_')) {
      const number = key.match(/attribute_id_(\d+)/)?.[1];

      const groupedAttribute: ProductGroupedAttributes = {} as ProductGroupedAttributes;

      groupedAttribute.attribute_id = product[key as AttributeIds];
      groupedAttribute.product_attribute_values_ids = product[`product_attribute_values_ids_${number}` as ProductAttributeValuesIds];
      groupedAttribute.attribute_fill_values = product[`attribute_fill_values_${number}` as AttributeFillValues];

      groupedAttributes.push(groupedAttribute);
    }
  });

  return groupedAttributes;
}

export async function setProductAttribute(productAttribute: ProductGroupedAttributes, productId: number, supabaseClient: SupabaseClient<Database>) {
  try {
    const { data, error } = await supabaseClient
      .from('product_attribute')
      .insert({
        product_id: productId,
        attribute_id: productAttribute.attribute_id,
        fill_values: productAttribute.attribute_fill_values,
      }).select();
    if (error) throw error;
    return data;
  } catch (e) {
    console.error(e);
    throw new Error(e);
  }
}

export async function setProductConfiguration(productAttribute: ProductGroupedAttributes, productId: number, supabaseClient: SupabaseClient<Database>) {
  try {
    const insertForms = productAttribute.product_attribute_values_ids.map((id: number) => ({
      product_id: productId,
      value_id: id,
    })).filter((form) => !!form.value_id && !productAttribute.attribute_fill_values);
    const { data, error } = await supabaseClient
      .from('product_configuration')
      .insert(insertForms)
      .select();
    if (error) throw error;
    return data;
  } catch (e) {
    console.error(e);
    throw new Error(e);
  }
}

export async function handleProductAttributes(product: Product, productId: number, supabaseClient: SupabaseClient<Database>) {
  const groupedAttributes = groupProductAttributesByNumber(product);
  const attributesPromises: Promise<any>[] = [];
  const configurationPromises: Promise<any>[] = [];

  groupedAttributes.forEach((groupedAttribute) => {
    attributesPromises.push(setProductAttribute(groupedAttribute, productId, supabaseClient));
    configurationPromises.push(setProductConfiguration(groupedAttribute, productId, supabaseClient));
  });

  const attributesResponse = await Promise.allSettled(attributesPromises);
  const configurationResponse = await Promise.allSettled(configurationPromises);
  return {
    attributesResponse,
    configurationResponse,
  }
}

export function groupVariationAttributesByNumber(variation: Variation): VariationGroupedAttributes[] {
  const groupedAttributes: VariationGroupedAttributes[] = [];

  Object.keys(variation).forEach((key) => {
    if (key.startsWith('attribute_id_')) {
      const number = key.match(/attribute_id_(\d+)/)?.[1];

      const groupedAttribute: VariationGroupedAttributes = {} as VariationGroupedAttributes;

      groupedAttribute.attribute_id = variation[key as AttributeIds] || 0;
      groupedAttribute.variation_attribute_value = variation[`variation_attribute_value_${number}` as VariationAttributeValue] || 0;

      groupedAttributes.push(groupedAttribute);
    }
  });

  return groupedAttributes;
}

export async function setVariationConfiguration(variationAttribute: VariationGroupedAttributes[], variationId: number, supabaseClient: SupabaseClient<Database>) {
  try {
    const insertForms = variationAttribute.map((variationAttribute) => ({
      variation_id: variationId,
      attribute_id: variationAttribute.attribute_id,
      value_id: variationAttribute.variation_attribute_value,
    })).filter((form) => !!form.value_id);
    const { data, error } = await supabaseClient
      .from('variation_configuration')
      .insert(insertForms)
      .select();
    if (error) throw error;
    return data;
  } catch (e) {
    console.error(e);
    throw new Error(e);
  }
}

export async function handleVariationAttributes(variation: Variation, variationId: number, supabaseClient: SupabaseClient<Database>) {
  const groupedAttributes = groupVariationAttributesByNumber(variation);

  console.log('Grouped',groupedAttributes);
  console.log('VARIATION ID', variationId);
  const variationConfiguration = await setVariationConfiguration(groupedAttributes, variationId, supabaseClient);
  return variationConfiguration;

}

const replaceSpacesFromStr = (str: string, replaceWith: string = '_'): string =>
  str.replace(/\s+/g, replaceWith);

function getContentTypeFromExtension(filename: string): string {
  const extension = filename.split('.')?.[1] || null;
  if (!extension) {
    return 'application/octet-stream';
  }

  switch(extension) {
    case 'tiff':
    case 'tif':
      return 'image/tiff';
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'webp':
      return 'image/webp';
    case 'avif':
      return 'image/avif';
    case 'txt':
      return 'text/plain';
    case 'svg':
      return  'image/svg+xml';
    case 'pdf':
      return 'application/pdf';
    case 'docx':
      return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    case 'xlsx':
      return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    case 'csv':
      return 'text/csv';
    case 'epub':
      return 'application/epub+zip';
    default:
      return 'application/octet-stream';
  }
}

function getFilenameFromDropboxUrl(url: string, fallbackExtension: string = '.jpg'): string {
  const parsedUrl = new URL(url);
  const pathSegments = parsedUrl.pathname.split('/');
  const filename = pathSegments.reverse().find(segment => segment.includes('.'));
  return filename || `product-name${fallbackExtension}`;
}

function getFilenameFromContentDisposition(contentDisposition: string | null): string | null {
  if (!contentDisposition) return null;

  const utf8FilenameMatch = contentDisposition.match(/filename\*=UTF-8''(.+)$/i);
  if (utf8FilenameMatch) {
    return decodeURIComponent(utf8FilenameMatch[1]);
  }

  const filenameMatch = contentDisposition.match(/filename="?(.+?)"?(;|$)/i);
  if (filenameMatch) {
    return filenameMatch[1];
  }

  return null;
}

export async function fetchFile(fileUrl: string, fallbackExtension: string = '.jpg') {
  try {
    const downloadUrl = new URL(fileUrl);
    downloadUrl.searchParams.set('dl', '1');

    const fileleResponse = await fetch(downloadUrl.toString());
    if (!fileleResponse.ok) {
      throw new Error('Failed to fetch file from Dropbox');
    }

    const fileBlob = await fileleResponse.blob();
    const filename = replaceSpacesFromStr(getFilenameFromContentDisposition(fileleResponse.headers.get('content-disposition')) ||
      getFilenameFromDropboxUrl(fileUrl, fallbackExtension));

    const contentType = getContentTypeFromExtension(filename);


    const file = new File([fileBlob], filename, { type: contentType });

    return {
      file,
      filename
    };
  } catch (e) {
    console.error(e);
    throw new Error(e);
  }
}

export async function handleSettingFiles(productName: string, imageUrl: string, supabaseClient: SupabaseClient<Database>, fileType: FileType) {
  try {
    const { file: fileImage, filename } = await fetchFile(imageUrl, fileTypeExtension(fileType));
    const formData = new FormData();
    formData.append('file', fileImage);

    let path = '/products/';
    const isDev = Deno.env.get('DEV');
    if (isDev) path = `/testing${path}`;
    if (productName) path = `${path}${productName}/`;
    path = `${path}${fileType}/`;

    formData.append('path', path);

    const { data, error } = await supabaseClient.functions.invoke('upload-to-s3', {
      body: formData,
    });

    if (error) throw error;
    if (data && data.fileUrl) {
      return {
        url: data.fileUrl,
        filename,
      };
    }
  } catch (e) {
    console.error(e);
  }
}

async function saveFile(
  fileForm: FileForm,
  productImgForm: ProductImage,
  entityType: 'product' | 'variation',
  supabaseClient: SupabaseClient<Database>,
  fileType: FileType,
) {
  try {
    const { data: file, error } = await supabaseClient
      .from(fileType)
      .upsert(fileForm as TablesInsert<typeof fileType>)
      .select(`id`);
    if (error) throw error;
    let entityForm: EntityForm = null;
    if (entityType === 'product') {
      let form: TablesInsert<'product_image'> |
        TablesInsert<'product_documents'> |
        TablesInsert<'product_specification_sheet'> | null = null;

      if (fileType === 'image') {
        form = {
          product_id: productImgForm?.product_id || 0,
          image_id: file[0].id,
          display_order: productImgForm?.display_order || 0,
          is_primary: productImgForm?.is_primary || false,
        } as TablesInsert<'product_image'>;
      }
      if (fileType === 'documents') {
        form = {
          product_id: productImgForm?.product_id || 0,
          document_id: file[0].id,
        } as TablesInsert<'product_documents'>;
      }
      if (fileType === 'specification_sheet') {
        form = {
          product_id: productImgForm?.product_id || 0,
          specification_sheet_id: file[0].id,
        } as TablesInsert<'product_specification_sheet'>;
      }
      entityForm = form;
    } else if(entityType === 'variation') {
      let form: TablesInsert<'variation_image'> |
        TablesInsert<'variation_documents'> |
        TablesInsert<'variation_specification_sheet'> | null = null;

      if (fileType === 'image') {
        form = {
          variation_id: productImgForm?.product_id || 0,
          image_id: file[0].id,
          display_order: productImgForm?.display_order || 0,
          is_primary: productImgForm?.is_primary || false,
        } as TablesInsert<'variation_image'>;
      }

      if (fileType === 'documents') {
        form = {
          variation_id: productImgForm?.product_id || 0,
          document_id: file[0].id,
        } as TablesInsert<'variation_documents'>;
      }

      if (fileType === 'specification_sheet') {
        form = {
          variation_id: productImgForm?.product_id || 0,
          specification_sheet_id: file[0].id,
        } as TablesInsert<'variation_specification_sheet'>;
      }
      entityForm = form;
    }


    const { data, error: e } = await supabaseClient
      .from(tableName(entityType, fileType))
      .upsert(entityForm as any)
      .select();
    if (e) throw e;
    return data;
  } catch (e) {
    console.error(e);
  }
}

export async function handleFiles(
  productId: number,
  productName: string,
  entityType: 'product' | 'variation',
  imagesUrl: string[],
  supabaseClient: SupabaseClient<Database>,
  fileType: FileType,
) {
  try {
    const saveImages: Promise<any>[] = [];
    const fetchImages: Promise<any>[] = [];

    imagesUrl.forEach((imgUrl: string) => {
      fetchImages.push(handleSettingFiles(slugify(productName), imgUrl, supabaseClient, fileType));
    });

    const imagesResponse = await Promise.allSettled(fetchImages);

    imagesResponse.forEach((imgResponse, index) => {
      if (imgResponse.status === 'fulfilled') {
        const imageForm = {
          url: imgResponse.value.url,
          name: imgResponse.value.filename,
        }
        const productImageForm = {
          display_order: index + 1,
          is_primary: index === 0,
          [columnName(entityType)]: productId
        }

        saveImages.push(saveFile(imageForm, productImageForm, entityType, supabaseClient, fileType))
      }
    });
  } catch (e) {
    console.error(e);
  }
}
