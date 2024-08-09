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
  const specSheetsToDelete: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);
  const dialogDeleteSpecSheet = ref(false);
  const specificationSheetToDelete: Ref<SpecificationSheet> = ref<SpecificationSheet>({});

  const openSpecSheetDeleteDialog = (item: SpecificationSheet) => {
    if (item.new_spec) {
      removeSpecSheetFromList(item);
    } else {
      dialogDeleteSpecSheet.value = true;
      specificationSheetToDelete.value = item;
    }
  }

  const closeSpecSheetDeleteDialog = () => {
    specificationSheetToDelete.value = {};
    dialogDeleteSpecSheet.value = false;
  }

  const addSpecificationSheet = () => {
    let specSheetTemp: SpecificationSheet[] = structuredClone(toRaw(specificationSheets.value));
    specSheetTemp = specSheetTemp.sort((a: SpecificationSheet, b: SpecificationSheet) => (a?.id || 0) - (b?.id || 0));
    const id = specSheetTemp.length ? (specSheetTemp[specSheetTemp.length - 1]?.id || 0) + 1 : 0;
    const newSpecSheet: SpecificationSheet = {
      id,
      url: '',
      name: '',
      force_url: false,
      specSheetFile: null,
      previewName: null,
      new_spec: true,
    }
    specificationSheets.value.push(newSpecSheet);
  }

  const removeSpecSheetFromList = (item: SpecificationSheet) => {
    if (!item.new_spec) {
      specSheetsToDelete.value.push(item);
    }
    specificationSheets.value = JSON.parse(JSON.stringify(specificationSheets.value.filter((specSheetItem) => specSheetItem.id !== item.id)));
  }

  const toggleForceUrlSpecSheet = (specSheetId?: number | null, value?: boolean) => {
    const valueToSet = !value;
    specificationSheets.value = specificationSheets.value.map((specSheet) => ({
      ...specSheet,
      force_url: specSheet.id === specSheetId ? valueToSet : false,
    }));
  }

  const onSpecSheetChange = async (evt: Event, specSheetId: number) => {
    const target = evt.target as HTMLInputElement;
    if (target && target.files) {
      const specSheetObj = specificationSheets.value.find(specSheet => specSheet.id === specSheetId);
      if (specSheetObj) {
        specSheetObj.specSheetFile = target.files[0];
        specSheetObj.previewName = target.files[0].name;
      }
    }
  }

  const clearSpecSheet = (specSheetId: number) => {
    const specSheetObj = specificationSheets.value.find(specSheet => specSheet.id === specSheetId);
    if (specSheetObj) {
      specSheetObj.specSheetFile = null;
      specSheetObj.previewName = null;
    }
  }

  const uploadSpecSheet = async (specSheetFile: File, productName?: string) => {
    const formData = new FormData();
    formData.append('file', specSheetFile);

    let path = '/products/';
    const isDev = import.meta.env.DEV;
    if (isDev) path = `/testing${path}`;
    if (productName) path = `${path}${productName}/`;
    path = `${path}specification-sheets/`;

    formData.append('path', path);

    try {
      const { data, error } = await supabase.functions.invoke('upload-to-s3', {
        body: formData,
      });
      if (error) throw error;
      if (data && data.fileUrl) {
        notify({
          title: 'Specification Sheet uploaded successfully',
          text: data?.message || 'File uploaded successfully',
          type: 'success',
          duration: 6000,
        });
        return data.fileUrl;
      }
    } catch (e: any) {
      console.error(e);
      notify({
        title: 'Error updating product specification sheet',
        text: e?.message || 'An error ocurred trying to update the product spec sheet. Please contact TOP Support.',
        type: 'error',
        duration: 6000,
      });
    }
  }

  const deleteFile = async (imageUrl?: string) => {
    try {
      if (imageUrl && imageUrl !== '') {
        const { data, error } = await supabase.functions.invoke('delete-from-s3', {
          body: {
            prevImageUrl: imageUrl,
          },
          method: 'DELETE',
        });
        if (error) throw error;
        notify({
          title: 'Old product spec sheet deleted successfully',
          text: data?.message || 'Previous file deleted.',
          type: 'success',
          duration: 6000,
        });
      }
    } catch (e: any) {
      console.error(e);
      notify({
        title: 'Error deleting spec sheet from server.',
        text: e?.message || 'An error ocurred trying to delete the old spec sheet from the server. Please contact TOP Support.',
        type: 'error',
        duration: 6000,
      });
    }
  }

  const saveSpecSheet = async (specSheetForm: SpecificationSheet, productSpecSheetForm: SpecificationSheet, productName?: string) => {
    try {
      specificationSheetLoading.value = true;
      // specSheetFile && !force_url ---> Upload file
      // specSheetFile && force_url ---> USE URL
      // !specSheetFile && !force_url ---> Throw Error, no file uploaded
      // !specSheetFile && force_url ---> USE URL
      const action = specSheetForm.specSheetFile
        ? (specSheetForm.force_url ? 'URL' : 'Upload')
        : (specSheetForm.force_url ? 'URL' : 'Error')

      if (action === 'Error' && !specSheetForm.url) {
        notify({
          title: 'Please upload a Spec Sheet File or include the spec sheet url.',
          text: 'Spec sheet file or url can\'t be empty.',
          type: 'error',
          duration: 6000,
        });
        throw new Error('File or spec sheet url can\'t be empty.');
      } else {
        if (action === 'Upload') {
          if (specSheetForm.url && isImageUrlFromCloudFront(specSheetForm.url)) {
            await deleteFile(specSheetForm.url);
          }
          const fileUrl = await uploadSpecSheet(specSheetForm.specSheetFile as File, productName);
          if (fileUrl) specSheetForm.url = fileUrl;
          delete specSheetForm.specSheetFile;
        }
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
      }
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

  const setSpecSheets = async (productId: number, productName?: string) => {
    try {
      specificationSheetLoading.value = true;

      const saveSpecSheets: Promise<any>[] = [];
      specificationSheets.value.forEach((specSheet) => {
        const specSheetForm = {
          id: specSheet.id === 0 ? undefined : specSheet.id,
          url: specSheet.url,
          name: specSheet.name,
          specSheetFile: specSheet.specSheetFile,
        }
        const productSpecSheetForm = {
          specification_sheet_id: specSheet.id === 0 ? undefined : specSheet.id,
          [columnName(productType)]: productId,
        }
        const productNameSlug = productName ? slugify(productName) : undefined;
        saveSpecSheets.push(saveSpecSheet(specSheetForm, productSpecSheetForm, productNameSlug));
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

  const deleteSpecSheet = async (specSheetId: number, specSheetUrl: string) => {
    try {
      const { data, error } = await supabase
        .from('specification_sheet')
        .delete()
        .eq('id', specSheetId);
      if (specSheetUrl && isImageUrlFromCloudFront(specSheetUrl)) {
        await deleteFile(specSheetUrl);
      }
      if (error) throw error;
    } catch (e: any) {
      notify({
        title: `Error removing Specification Sheet ${specSheetId}`,
        text: e?.message || `An error ocurred trying to delete a document. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      })
    }
  }

  const deleteSpecSheets = async () => {
    try {
      specificationSheetLoading.value = true;
      const deleteSpecSheetsPromise: Promise<any>[] = [];

      specSheetsToDelete.value.forEach((specSheet => {
        deleteSpecSheetsPromise.push(deleteSpecSheet(specSheet.id as number, specSheet.url as string));
      }));

      const promiseResult = await Promise.allSettled(deleteSpecSheetsPromise);
    } catch (e: any) {
      console.error(e);
      notify({
        title: 'Error deleting specification sheets',
        text: e?.message || `An error ocurred trying to delete documents. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      })
    } finally {
      specificationSheetLoading.value = false;
    }
  }

  const slugify = (str: string) => (
    String(str)
      .normalize('NFKD') // split accented characters into their base characters and diacritical marks
      .replace(/[\u0300-\u036f]/g, '') // remove all the accents, which happen to be all in the \u03xx UNICODE block.
      .trim() // trim leading or trailing whitespace
      .toLowerCase() // convert to lowercase
      .replace(/[^a-z0-9 -]/g, '') // remove non-alphanumeric characters
      .replace(/\s+/g, '-') // replace spaces with hyphens
      .replace(/-+/g, '-') // remove consecutive hyphens
  )

  const isImageUrlFromCloudFront = (imgUrl: string) => {
    const cloudfrontDomain = import.meta.env.VITE_CLOUDFRONT_DOMAIN;
    const parsedUrl = new URL(imgUrl);
    return parsedUrl.hostname.endsWith(cloudfrontDomain);
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
    dialogDeleteSpecSheet,
    specificationSheetToDelete,
    addSpecificationSheet,
    removeSpecSheetFromList,
    saveSpecSheet,
    setSpecSheets,
    toggleForceUrlSpecSheet,
    clearSpecSheet,
    onSpecSheetChange,
    deleteSpecSheets,
    openSpecSheetDeleteDialog,
    closeSpecSheetDeleteDialog,
  }
}
