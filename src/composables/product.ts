import { supabase } from "@/supabase";
import { Attribute, Documents, Image, SpecificationSheet } from "@/types/product";
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

  const loadProductConfiguration = async (product_id: number) => {
    try {
      productLoading.value = true;
      const { data: attribute_values, error } = await supabase
        .from('product_configuration')
        .select('value:value_id(id, attribute_id)')
        .eq(`product_id`, product_id);
      if (error) throw error;
      const attributeValues: { [key: number]: any } = {};
      attribute_values.forEach((attrVal: any) => {
        const attrId = attrVal.value.attribute_id as number
        if (!attributeValues[attrId]) {
          attributeValues[attrId] = [];
        }
        attributeValues[attrId].push(attrVal.value.id);
        attrValues.value.push(attrVal.value.id);
      });
      return attributeValues;
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
        .select('id, product_id, attribute:attribute_id(id, name, table_name), fill_values')
        .eq(`product_id`, product_id);
      if (error) throw error;
      const attributeValue = await loadProductConfiguration(product_id);
      const attributes = data.map((attr: any) => ({
        id: attr.attribute?.id,
        name: attr.attribute?.name,
        table_name: attr.attribute?.table_name,
        fill_values: attr.fill_values,
        attribute_value: attributeValue?.[attr.attribute?.id],
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
