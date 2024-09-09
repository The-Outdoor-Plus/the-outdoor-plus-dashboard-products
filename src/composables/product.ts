import { supabase } from "@/supabase";
import { Attribute, AttributeValue, Color, Documents, Image, SpecificationSheet } from "@/types/product";
import { notify } from "@kyvg/vue3-notification";
import { Ref, ref } from "vue";

export function useProduct() {
  const productLoading = ref(false);
  const attrValues: Ref<number[]> = ref<number[]>([]);

  const loadProductPrices = async (type: string, product_id: number) => {
    try {
      productLoading.value = true;
      const { data: price, error } = await supabase.from(`${type}_price`)
        .select('price, year, product_id, id',)
        .eq(`product_id`, product_id);

      if (error) throw error;
      return price;
    } catch (e: any) {
      notify({
        title: `Error loading prices.`,
        text: e?.message || `An error occurred trying to load prices. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      productLoading.value = false;
    }
  }

  const loadAllAttributesValues = async (attribute_id: number, material_id: number | undefined = undefined) => {
    try {
      const { data, error } = await supabase
        .from('attributes')
        .select(`
          id,
          name,
          table_name,
          sku_var,
          attribute_value(
            id,
            value,
            sku_code,
            material(
              id,
              name,
              sku_code
            ),
            color(
              id,
              name,
              sku_code,
              material_id
            ),
            gas(
              id,
              name,
              sku_code
            ),
            ignition(
              id,
              name,
              sku_code
            )
          )
        `)
        .eq('id', attribute_id);
      if (error) throw error;
      return data.map((prodAttr) => {
        if (prodAttr.table_name === 'color') {
          if (material_id) {
            return {
              ...prodAttr,
              attribute_value: prodAttr.attribute_value.filter(attrVal => (attrVal.color as any).material_id === material_id),
            }
          }
        }
        return prodAttr;
      });
    } catch (e: any) {
      console.error(e);
    }
  }

  const loadProductConfiguration = async (product_id: number, fillValuesAttributes: any[]) => {
    try {
      productLoading.value = true;
      const { data: attribute_values, error } = await supabase
        .from('product_configuration')
        .select(`value:value_id(
          id,
          attribute_id,
          sku_code, value,
          material(
            id,
            name,
            sku_code
          ),
          gas(
            id,
            name,
            sku_code
          ),
          ignition(
            id,
            name,
            sku_code
          ),
          color(
            id,
            name,
            sku_code
          )
        )`)
        .eq(`product_id`, product_id);
      if (error) throw error;
      const fillValAttrsPromise: Promise<any>[] = [];

      const colorFillAttribute = fillValuesAttributes.find((prodAttr) => {
        const attribute = prodAttr.attribute as Attribute;
        return attribute?.table_name === 'color';
      });
      if (colorFillAttribute) {
        const materialAttribute = attribute_values.find((attrVal) => {
          const attribute = attrVal.value as AttributeValue;
          return !!attribute?.material;
        });
        fillValuesAttributes = fillValuesAttributes.map((prodAttr) => {
          const attribute = prodAttr.attribute as Attribute;
          if (attribute.table_name === 'color') {
            return {
              ...prodAttr,
              material_id: (materialAttribute?.value as AttributeValue)?.material?.id || 0,
            }
          }
          return prodAttr;
        });
      }

      fillValuesAttributes.forEach((fillVal) => {
        fillValAttrsPromise.push(loadAllAttributesValues(fillVal?.attribute?.id || 0, fillVal?.material_id || undefined));
      });
      const fillValues = await Promise.allSettled(fillValAttrsPromise);
      const attributeValues: { [key: number]: any } = {};
      const attrVals: { [key: number]: any } = {};
      attribute_values.forEach((attrVal: any) => {
        const attrId = attrVal.value.attribute_id as number
        if (!attributeValues[attrId]) {
          attributeValues[attrId] = [];
        }
        if (!attrVals[attrId]) {
          attrVals[attrId] = [];
        }
        attributeValues[attrId].push(attrVal.value.id);
        attrVals[attrId].push({
          id: attrVal.value.id,
          permanent_attribute_id: attrVal?.value?.color?.id ||
            attrVal?.value?.ignition?.id ||
            attrVal?.value?.gas?.id ||
            attrVal?.value?.material?.id || null,
          attribute_id: attrVal.value.attribute_id,
          value: attrVal?.value?.color?.name ||
            attrVal?.value?.ignition?.name ||
            attrVal?.value?.gas?.name ||
            attrVal?.value?.material?.name ||
            attrVal?.value?.value || null,
          sku_code: attrVal?.value?.color?.sku_code ||
            attrVal?.value?.ignition?.sku_code ||
            attrVal?.value?.gas?.sku_code ||
            attrVal?.value?.material?.sku_code ||
            attrVal?.value?.sku_code || null,
        })
        attrValues.value.push(attrVal.value.id);
      });

      fillValues.forEach((fillVal) => {
        if (fillVal.status === 'fulfilled') {
          fillVal.value?.[0].attribute_value.forEach((attrVal: any) => {
            if (!attrVals[fillVal.value?.[0].id]) {
              attrVals[fillVal.value?.[0].id] = [];
            }
            attrVals[fillVal.value?.[0].id].push({
              id: attrVal?.id || null,
              attribute_id: fillVal.value?.[0].id,
              permanent_attribute_id: attrVal?.color?.id ||
                attrVal?.ignition?.id ||
                attrVal?.gas?.id ||
                attrVal?.material?.id || null,
              value: attrVal?.color?.name ||
                attrVal?.ignition?.name ||
                attrVal?.gas?.name ||
                attrVal?.material?.name ||
                attrVal?.value || null,
              sku_code: attrVal?.color?.sku_code ||
                attrVal?.ignition?.sku_code ||
                attrVal?.gas?.sku_code ||
                attrVal?.material?.sku_code ||
                attrVal?.sku_code || null,
            });
          })
        }
      });

      return {
        attributeValues,
        attrVals,
      };
    } catch (e) {
      console.error(e);
    } finally {
      productLoading.value = false;
    }
  }

  const loadProductAttributes = async (product_id: number) => {
    try {
      productLoading.value = true;
      const { data, error } = await supabase
        .from('product_attribute')
        .select(`
          id,
          product_id,
          attribute:attribute_id(
            id,
            name,
            table_name,
            sku_var
          ),
          fill_values
        `)
        .eq(`product_id`, product_id);
      if (error) throw error;
      const fillValuesAttributes = data.filter((prodAttr) => !!prodAttr.fill_values);
      const config = await loadProductConfiguration(product_id, fillValuesAttributes);
      if (!config) {
        throw new Error('Error loading product configuration');
      }
      const { attributeValues, attrVals } = config;
      const attributes = data.map((attr: any) => ({
        id: attr.attribute?.id,
        name: attr.attribute?.name,
        table_name: attr.attribute?.table_name,
        fill_values: attr.fill_values,
        sku_var: attr.attribute?.sku_var,
        attribute_value: attributeValues?.[attr.attribute?.id],
        attribute_values: attrVals?.[attr.attribute?.id],
      }));
      return attributes as Attribute[];
    } catch (e) {
      console.error(e);
    } finally {
      productLoading.value = false;
    }
  }

  const loadProductImages = async (product_id: number) => {
    try {
      productLoading.value = true;
      const { data: images, error } = await supabase.from(`product_image`)
        .select(`product_id, image:image_id(id, name, url), display_order, is_primary`)
        .eq(`product_id`, product_id)
      if (error) throw error;
      return images.map((item) => ({
        id: item.image?.length ?
          item.image[0].id :
          (item.image as Image).id,
        name: item.image?.length ?
          item.image[0].name :
          (item.image as Image).name,
        url: item.image?.length ?
          item.image[0].url :
          (item.image as Image).url,
        display_order: item.display_order,
        is_primary: item.is_primary,
      }));
    } catch(e: any) {
      notify({
        title: `Error loading image`,
        text: e?.message || `An error occurred trying to load an image. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      productLoading.value = false;
    }
  }

  const loadSpecificationSheets = async (product_id: number) => {
    try {
      productLoading.value = true;
      const { data: specSheets, error } = await supabase.from(`product_specification_sheet`)
        .select(`product_id, specification_sheet:specification_sheet_id(id, name, url)`)
        .eq(`product_id`, product_id)
      if (error) throw error;
      return specSheets.map((item) => ({
        id: item.specification_sheet?.length ?
          item.specification_sheet[0].id :
          (item.specification_sheet as SpecificationSheet).id,
        name: item.specification_sheet?.length ?
          item.specification_sheet[0].name :
          (item.specification_sheet as SpecificationSheet).name,
        url: item.specification_sheet?.length ?
          item.specification_sheet[0].url :
          (item.specification_sheet as SpecificationSheet).url,
      }));
    } catch(e: any) {
      notify({
        title: `Error loading specification sheets`,
        text: e?.message || `An error occurred trying to load specification sheets. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      productLoading.value = false;
    }
  }

  const loadDocuments = async (product_id: number) => {
    try {
      productLoading.value = true;
      const { data: docs, error } = await supabase.from(`product_documents`)
        .select(`product_id, document:document_id(id, name, url)`)
        .eq(`product_id`, product_id);
        if (error) throw error;
        return docs.map((item) => ({
          id: item.document?.length ?
            item.document[0].id :
            (item.document as Documents).id,
          name: item.document?.length ?
            item.document[0].name :
            (item.document as Documents).name,
          url: item.document.length ?
            item.document[0].url :
            (item.document as Documents).url,
        }));
    } catch (e: any) {
      notify({
        title: `Error loading documents`,
        text: e?.message || `An error occurred trying to load documents. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      productLoading.value = false;
    }
  }

  return {
    productLoading,
    attrValues,
    loadDocuments,
    loadProductAttributes,
    loadProductConfiguration,
    loadProductImages,
    loadProductPrices,
    loadSpecificationSheets
  }
}
