import { ComputedRef, Ref } from 'vue';
import { ref, watch, onMounted, toRaw } from 'vue';
import { SpecificationSheet } from '@/types/product';
import { supabase } from '@/supabase';
import { notify } from '@kyvg/vue3-notification';

export function useProductSpecificationSheet(
  productSpecificationSheetRef: ComputedRef<SpecificationSheet[] | undefined>,
  productType: string = 'product'
) {
  const tableName = (prodType: string) => ({
    'product': 'product_specification_sheet',
    'variation': 'variation_specification_sheet',
  })[prodType] || 'product_specification_sheet';

  const columnName = (prodType: string) => ({
    'product': 'product_id' as keyof SpecificationSheet,
    'variation': 'variation_id' as keyof SpecificationSheet,
  })[prodType] || 'product_id' as keyof SpecificationSheet;

  const specificationSheetLoading = ref(false);
  const specificationSheets: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);

  const addSpecificationSheet = () => {
    let specSheetTemp: SpecificationSheet[] = structuredClone(toRaw(specificationSheets.value));
    specSheetTemp = specSheetTemp.sort((a: SpecificationSheet, b: SpecificationSheet) => (a?.id || 0) - (b?.id || 0));
    const id = specSheetTemp.length ? (specSheetTemp[specSheetTemp.length - 1]?.id || 0) + 1 : 0;
    const newSpecSheet: SpecificationSheet = {
      id,
      url: '',
      name: '',
    }
    specificationSheets.value.push(newSpecSheet);
  }

  const removeSpecSheetFromList = (item: SpecificationSheet) => {
    specificationSheets.value = specificationSheets.value.filter((specSheetItem) => specSheetItem.id !== item.id);
  }

  const saveSpecSheet = async (specSheetForm: SpecificationSheet, productSpecSheetForm: SpecificationSheet) => {
    try {
      specificationSheetLoading.value = true;
      const { data: specSheet, error } = await supabase
        .from('specification_sheet')
        .upsert(specSheetForm)
        .select(`id`);
      if (error) throw error;
      const { data, error: e } = await supabase
        .from(tableName(productType))
        .upsert({
          ...productSpecSheetForm,
          specification_sheet_id: specSheet[0].id,
        })
        .select();
      if (e) throw e;
      return data;
    } catch (e: any) {
      notify({
        title: `Error saving Specification Sheet`,
        text: e?.message || `An error occurred trying to save a Specification Sheet. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      specificationSheetLoading.value = false;
    }
  }

  const setSpecSheets = async (productId: number) => {
    try {
      specificationSheetLoading.value = true;

      const saveSpecSheets: Promise<any>[] = [];
      specificationSheets.value.forEach((specSheet) => {
        const specSheetForm = {
          id: specSheet.id === 0 ? undefined : specSheet.id,
          url: specSheet.url,
          name: specSheet.name,
        }
        const productSpecSheetForm = {
          specification_sheet_id: specSheet.id === 0 ? undefined : specSheet.id,
          [columnName(productType)]: productId,
        }
        saveSpecSheets.push(saveSpecSheet(specSheetForm, productSpecSheetForm));
      });
      const promiseResult = await Promise.allSettled(saveSpecSheets);
    } catch (e: any) {
      console.error(e);
      notify({
        title: `Error saving specification sheets`,
        text: e?.message || `An error occurred trying to save specification sheets. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      specificationSheetLoading.value = false;
    }
  }

  watch(
    () => productSpecificationSheetRef.value,
    (productSpecificationSheet) => {
      if (productSpecificationSheet) {
        specificationSheets.value = productSpecificationSheet;
      }
    },
    { deep: true },
  );

  onMounted(() => {
    if (productSpecificationSheetRef.value)
      specificationSheets.value = productSpecificationSheetRef.value;
  });

  return {
    specificationSheetLoading,
    specificationSheets,
    addSpecificationSheet,
    removeSpecSheetFromList,
    saveSpecSheet,
    setSpecSheets
  }
}
