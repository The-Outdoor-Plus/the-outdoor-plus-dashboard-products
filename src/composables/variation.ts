import { supabase } from "@/supabase";
import { Attribute, Documents, Image, SpecificationSheet } from "@/types/product";
import { notify } from "@kyvg/vue3-notification";
import { Ref, ref } from "vue";

export function useVariation() {
  const variationLoading = ref(false);
  const attributes: Ref<{ [key: number]: number | null }> = ref<{ [key: number]: number | null }>({});

  const loadAttributes = async (variationId: number) => {
    try {
      variationLoading.value = true;
      const { data, error } = await supabase.from(`variation_configuration`)
        .select('variation_id, attribute_value!inner(id, attribute_id)')
        .eq(`variation_id`, variationId);
      if (error) throw error;
      if (data)
        data.forEach((variationConf) => {
          const attrValue = variationConf.attribute_value as unknown as { id: number, attribute_id: number };
          attributes.value[attrValue.attribute_id] = attrValue.id;
        });
    } catch (e: any) {
      notify({
        title: `Error loading attributes.`,
        text: e?.message || `An error occurred trying to load attributes. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      variationLoading.value = false;
    }
  }

  const loadVariationPrices = async (type: string, variation_id: number) => {
    try {
      variationLoading.value = true;
      const { data: price, error } = await supabase.from(`${type}_price`)
        .select('price, year, variation_id, id')
        .eq(`variation_id`, variation_id);

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
      variationLoading.value = false;
    }
  }

  const loadVariationImages = async (variationId: number) => {
    try {
      variationLoading.value = true;
      const { data: images, error } = await supabase.from(`variation_image`)
        .select(`variation_id, image:image_id(id, name, url), display_order, is_primary`)
        .eq(`variation_id`, variationId)
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
      variationLoading.value = false;
    }
  }

  const loadDocuments = async (variationId: number) => {
    try {
      variationLoading.value = true;
      const { data: docs, error } = await supabase.from(`variation_documents`)
        .select(`variation_id, document:document_id(id, name, url)`)
        .eq(`variation_id`, variationId);
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
      variationLoading.value = false;
    }
  }

  const loadSpecificationSheets = async (variationId: number) => {
    try {
      variationLoading.value = true;
      const { data: specSheets, error } = await supabase.from(`variation_specification_sheet`)
        .select(`variation_id, specification_sheet:specification_sheet_id(id, name, url)`)
        .eq(`variation_id`, variationId)
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
      variationLoading.value = false;
    }
  }

  return {
    variationLoading,
    attributes,
    loadAttributes,
    loadDocuments,
    loadVariationImages,
    loadVariationPrices,
    loadSpecificationSheets
  }
}

