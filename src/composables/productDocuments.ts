import { ComputedRef, Ref } from 'vue';
import { ref, watch, onMounted, toRaw } from 'vue';
import { Documents } from '@/types/product';
import { supabase } from '@/supabase';
import { notify } from '@kyvg/vue3-notification';

export function useProductDocument(
  productDocumentsRef: ComputedRef<Documents[] | undefined>,
  productType: string = 'product'
) {
  const tableName = (prodType: string) => ({
    'product': 'product_documents',
    'variation': 'variation_documents',
  })[prodType] || 'product_documents';

  const columnName = (prodType: string) => ({
    'product': 'product_id' as keyof Documents,
    'variation': 'variation_id' as keyof Documents,
  })[prodType] || 'product_id' as keyof Documents;

  const documentLoading = ref(false);
  const documents: Ref<Documents[]> = ref<Documents[]>([]);

  const addDocuments = () => {
    let documentsTemp: Documents[] = structuredClone(toRaw(documents.value));
    documentsTemp = documentsTemp.sort((a: Documents, b: Documents) => (a?.id || 0) - (b?.id || 0));
    const id = documentsTemp?.length ? (documentsTemp[documentsTemp.length - 1]?.id || 0) + 1 : 0;
    const newDocument: Documents = {
      id,
      url: '',
      name: '',
    }
    documents.value.push(newDocument);
  }

  const removeDocFromList = (item: Documents) => {
    documents.value = documents.value.filter((docItem) => docItem.id !== item.id);
  }

  const saveDocument = async (documentsForm: Documents, productDocumentsForm: Documents) => {
    try {
      documentLoading.value = true;
      const { data: docs, error } = await supabase
        .from('documents')
        .upsert(documentsForm)
        .select(`id`);
      if (error) throw error;
      const { data, error: e } = await supabase
        .from(tableName(productType))
        .upsert({
          ...productDocumentsForm,
          document_id: docs[0].id,
        })
        .select();
      if (e) throw e;
      return data;
    } catch (e: any) {
      notify({
        title: `Error saving Documents`,
        text: e?.message || `An error occurred trying to save Documents. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      documentLoading.value = false;
    }
  }

  const setDocuments = async (productId: number) => {
    try {
      documentLoading.value = true;
      const saveDocuments: Promise<any>[] =[];

      documents.value.forEach((doc) => {
        const documentsForm = {
          id: doc.id === 0 ? undefined : doc.id,
          url: doc.url,
          name: doc.name,
        }
        const productDocumentsForm = {
          document_id: doc.id === 0 ? undefined : doc.id,
          [columnName(productType)]: productId,
        }
        saveDocuments.push(saveDocument(documentsForm, productDocumentsForm));
      });

      documentLoading.value = true;
      const promiseResult = await Promise.allSettled(saveDocuments);
    } catch (e: any) {
      console.error(e);
      notify({
        title: `Error saving documents`,
        text: e?.message || `An error occurred trying to save documents. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      documentLoading.value = false;
    }
  }

  watch(
    () => productDocumentsRef.value,
    (productDocuments) => {
      if (productDocuments)
        documents.value = productDocuments;
    },
    { deep: true },
  );

  onMounted(() => {
    if (productDocumentsRef.value)
      documents.value = productDocumentsRef.value;
  });

  return {
    documentLoading,
    documents,
    addDocuments,
    removeDocFromList,
    saveDocument,
    setDocuments,
  }
}
