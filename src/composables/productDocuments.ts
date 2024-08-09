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
  const documentsToDelete: Ref<Documents[]> = ref<Documents[]>([]);
  const dialogDeleteDocument = ref(false);
  const documentToDelete: Ref<Documents> = ref<Documents>({});

  const openDocumentDeleteDialog = (item: Documents) => {
    if (item.new_document) {
      removeDocFromList(item);
    } else {
      dialogDeleteDocument.value = true;
      documentToDelete.value = item;
    }
  }

  const closeDocumentDeleteDialog = () => {
    documentToDelete.value = {};
    dialogDeleteDocument.value = false;
  }

  const addDocuments = () => {
    let documentsTemp: Documents[] = structuredClone(toRaw(documents.value));
    documentsTemp = documentsTemp.sort((a: Documents, b: Documents) => (a?.id || 0) - (b?.id || 0));
    const id = documentsTemp?.length ? (documentsTemp[documentsTemp.length - 1]?.id || 0) + 1 : 0;
    const newDocument: Documents = {
      id,
      url: '',
      name: '',
      force_url: false,
      documentFile: null,
      previewName: null,
      new_document: true,
    }
    documents.value.push(newDocument);
  }

  const removeDocFromList = (item: Documents) => {
    if (!item.new_document) {
      documentsToDelete.value.push(item);
    }
    documents.value = JSON.parse(JSON.stringify(documents.value.filter((docItem) => docItem.id !== item.id)));
  }

  const toggleForceUrlDocument = (docId?: number | null, value?: boolean) => {
    const valueToSet = !value;
    documents.value = documents.value.map((doc) => ({
      ...doc,
      force_url: doc.id === docId ? valueToSet : false,
    }));
  }

  const onDocumentChange = async (evt: Event, docId: number) => {
    const target = evt.target as HTMLInputElement;
    if (target && target.files) {
      const docObj = documents.value.find(doc => doc.id === docId);
      if (docObj) {
        docObj.documentFile = target.files[0];
        docObj.previewName = target.files[0].name;
      }
    }
  }

  const clearDocument = (docId: number) => {
    const docObj = documents.value.find(doc => doc.id === docId);
    if (docObj) {
      docObj.documentFile = null
      docObj.previewName = null;
    }
  }

  const uploadDocument = async (documentFile: File, productName?: string) => {
    const formData = new FormData();
    formData.append('file', documentFile);

    let path = '/products/';
    const isDev = import.meta.env.DEV;
    if (isDev) path = `/testing${path}`;
    if (productName) path = `${path}${productName}/`;
    path = `${path}documents/`;

    formData.append('path', path);

    try {
      const { data, error } = await supabase.functions.invoke('upload-to-s3', {
        body: formData,
      });
      if (error) throw error;
      if (data && data.fileUrl) {
        notify({
          title: 'Document uploaded successfully',
          text: data?.message || 'File uploaded successfully',
          type: 'success',
          duration: 6000,
        });
        return data.fileUrl;
      }
    } catch (e: any) {
      console.error(e);
      notify({
        title: 'Error updating product document',
        text: e?.message || 'An error ocurred trying to update the product document. Please contact TOP Support.',
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
          title: 'Old product document deleted successfully',
          text: data?.message || 'Previous file deleted.',
          type: 'success',
          duration: 6000,
        });
      }
    } catch (e: any) {
      console.error(e);
      notify({
        title: 'Error deleting document from server.',
        text: e?.message || 'An error ocurred trying to delete the old document from the server. Please contact TOP Support.',
        type: 'error',
        duration: 6000,
      });
    }
  }

  const saveDocument = async (documentsForm: Documents, productDocumentsForm: Documents, productName?: string) => {
    try {
      documentLoading.value = true;
      // documentFile && !force_url ---> Upload file
      // documentFile && force_url ---> USE URL
      // !documentFile && !force_url ---> Throw Error, no file uploaded
      // !documentFile && force_url ---> USE URL
      const action = documentsForm.documentFile
        ? (documentsForm.force_url ? 'URL' : 'Upload')
        : (documentsForm.force_url ? 'URL' : 'Error')

      if (action === 'Error' && !documentsForm.url) {
        notify({
          title: 'Please upload a document File or include the spec sheet url.',
          text: 'Document file or url can\'t be empty.',
          type: 'error',
          duration: 6000,
        });
        throw new Error('File or document url can\'t be empty.');
      } else {
        if (action === 'Upload') {
          if (documentsForm.url && isImageUrlFromCloudFront(documentsForm.url)) {
            await deleteFile(documentsForm.url);
          }
          const fileUrl = await uploadDocument(documentsForm.documentFile as File, productName);
          if (fileUrl) documentsForm.url = fileUrl;
          delete documentsForm.documentFile;
        }
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
      }
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

  const setDocuments = async (productId: number, productName?: string) => {
    try {
      documentLoading.value = true;
      const saveDocuments: Promise<any>[] =[];

      documents.value.forEach((doc) => {
        const documentsForm = {
          id: doc.id === 0 ? undefined : doc.id,
          url: doc.url,
          name: doc.name,
          documentFile: doc.documentFile,
        }
        const productDocumentsForm = {
          document_id: doc.id === 0 ? undefined : doc.id,
          [columnName(productType)]: productId,
        }
        const productNameSlug = productName ? slugify(productName) : undefined;
        saveDocuments.push(saveDocument(documentsForm, productDocumentsForm, productNameSlug));
      });

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

  const deleteDocument = async (docId: number, documentUrl: string) => {
    try {
      const { data, error } = await supabase
        .from('documents')
        .delete()
        .eq('id', docId);
      if (documentUrl && isImageUrlFromCloudFront(documentUrl)) {
        await deleteFile(documentUrl);
      }
      if (error) throw error;
    } catch (e: any) {
      notify({
        title: `Error removing Document ${docId}`,
        text: e?.message || `An error occurred trying to delete a document. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    }
  }

  const deleteDocuments = async () => {
    try {
      documentLoading.value = true;
      const deleteDocumentPromise: Promise<any>[] = [];

      documentsToDelete.value.forEach((doc) => {
        deleteDocumentPromise.push(deleteDocument(doc.id as number, doc.url as string));
      });

      const promiseResult = await Promise.allSettled(deleteDocumentPromise);
    } catch (e: any) {
      console.error(e);
      notify({
        title: `Error deleting documents`,
        text: e?.message || `An error occurred trying to delete documents. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      documentLoading.value = false;
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

  const getFileName = (fileUrl?: string | null) => {
    const fullPath = fileUrl?.split('/').pop();

    const fileName = fullPath?.split('?')[0];

    return fileName;
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
    dialogDeleteDocument,
    documentToDelete,
    documentsToDelete,
    deleteDocuments,
    addDocuments,
    removeDocFromList,
    saveDocument,
    setDocuments,
    toggleForceUrlDocument,
    clearDocument,
    onDocumentChange,
    getFileName,
    openDocumentDeleteDialog,
    closeDocumentDeleteDialog,
  }
}
