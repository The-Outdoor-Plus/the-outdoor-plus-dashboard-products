import { ComputedRef, Ref } from 'vue';
import { ref, watch, onMounted, toRaw } from 'vue';
import { Image } from '@/types/product';
import { supabase } from '@/supabase';
import { notify } from '@kyvg/vue3-notification';

export function useProductImage(
  productImagesRef: ComputedRef<Image[] | undefined>,
  productType: string = 'product'
) {
  const tableName = (prodType: string) => ({
    'product': 'product_image',
    'variation': 'variation_image',
  })[prodType] || 'product_image';

  const columnName = (prodType: string) => ({
    'product': 'product_id' as keyof Image,
    'variation': 'variation_id' as keyof Image,
  })[prodType] || 'product_id' as keyof Image;

  const imageLoading = ref(false);
  const images: Ref<Image[]> = ref<Image[]>([]);
  const imagesToDelete: Ref<Image[]> = ref<Image[]>([]);
  const dialogDeleteImage = ref(false);
  const imageToDelete: Ref<Image> = ref<Image>({});

  const openImageDeleteDialog = (item: Image) => {
    if (item.new_image) {
      removeImageFromList(item);
    } else {
      dialogDeleteImage.value = true;
      imageToDelete.value = item;
    }
  }

  const closeImageDeleteDialog = () => {
    imageToDelete.value = {};
    dialogDeleteImage.value = false;
  }

  const addImage = () => {
    let imagesTemp: Image[] = structuredClone(toRaw(images.value));
    imagesTemp = imagesTemp.sort((a: Image, b: Image) => (a?.id || 0) - (b?.id || 0));
    const id = imagesTemp.length ? (imagesTemp[imagesTemp.length - 1]?.id || 0) + 1 : 0;
    const newImage: Image = {
      id,
      url: '',
      name: '',
      display_order: (images.value.length - 1) + 1,
      is_primary: false,
      force_url: false,
      imageFile: null,
      imagePreview: null,
      new_image: true,
    }
    images.value.push(newImage);
  }

  const removeImageFromList = (item: Image) => {
    if (!item.new_image) {
      imagesToDelete.value.push(item);
    }
    images.value = JSON.parse(JSON.stringify(images.value.filter((imageItem) => imageItem.id !== item.id)));
  }

  const toggleImageIsPrimary = (imageId?: number | null, value?: boolean) => {
    const valueToSet = !value;
    images.value = images.value.map((img) => ({
      ...img,
      is_primary: img.id === imageId ? valueToSet : false,
    }));
  }

  const toggleForceUrlImage = (imageId?: number | null, value?: boolean) => {
    const valueToSet = !value;
    images.value = images.value.map((img) => ({
      ...img,
      force_url: img.id === imageId ? valueToSet : false,
    }));
  }

  const onImageChange = async (evt: Event, imageId: number) => {
    const target = evt.target as HTMLInputElement;
    if (target && target.files) {
      const imageObj = images.value.find(img => img.id === imageId);
      if (imageObj){
        imageObj.imageFile = target.files[0];
        imageObj.imagePreview = URL.createObjectURL(target.files[0]);
      }
    }
  }

  const clearImage = (imageId: number) => {
    const imageObj = images.value.find(img => img.id === imageId);
    if (imageObj) {
      imageObj.imageFile = null;
      imageObj.imagePreview = null;
    }
  }

  const uploadImage = async (imageFile: File, productName?: string) => {
    const formData = new FormData();
    formData.append('file', imageFile);

    let path = '/products/';
    const isDev = import.meta.env.DEV;
    if (isDev) path = `/testing${path}`;
    if (productName) path = `${path}${productName}/`;
    path = `${path}images/`;

    formData.append('path', path);

    try {
      const { data, error } = await supabase.functions.invoke('upload-to-s3', {
        body: formData,
      });
      if (error) throw error;
      if (data && data.fileUrl) {
        notify({
          title: 'Image uploaded successfully',
          text: data?.message || 'File uploaded successfully.',
          type: 'success',
          duration: 6000,
        });
        return data.fileUrl;
      }
    } catch (e: any) {
      console.error(e);
      notify({
        title: 'Error updating product image',
        text: e?.message || 'An error ocurred trying to update the product image. Please contact TOP Support.',
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
          title: 'Old product image deleted successfully',
          text: data?.message || 'Previous file deleted.',
          type: 'success',
          duration: 6000,
        });
      }
    } catch (e: any) {
      console.error(e);
      notify({
        title: 'Error deleting image from server.',
        text: e?.message || 'An error ocurred trying to delete the old image from the server. Please contact TOP Support.',
        type: 'error',
        duration: 6000,
      })
    }
  }

  const saveImage = async (imageForm: Image, productImgForm: Image, productName?: string) => {
    try {
      imageLoading.value = true;
      // imageFile && !force_url ---> Upload Image
      // imageFile && force_url ---> USE URL
      // !imageFile && !force_url ---> Throw Error, no image uploaded
      // !imageFile && force_url ---> USE URL
      const action = imageForm.imageFile
        ? (imageForm.force_url ? 'URL' : 'Upload')
        : (imageForm.force_url ? 'URL' : 'Error');

      if (action === 'Error' && !imageForm.url) {
        notify({
          title: 'Please upload a Image or include the image url.',
          text: 'Image file or image url can\'t be empty.',
          type: 'error',
          duration: 6000,
        });
        throw new Error('File or image url can\'t be empty.');
      } else {
        if (action === 'Upload') {
          if (imageForm.url && isImageUrlFromCloudFront(imageForm.url)) {
            await deleteFile(imageForm.url);
          }
          const fileUrl = await uploadImage(imageForm.imageFile as File, productName)
          if (fileUrl)
            imageForm.url = fileUrl;
          delete imageForm.imageFile;
        }
        const { data: image, error } = await supabase
          .from('image')
          .upsert(imageForm)
          .select(`id`);
        if (error) throw error;
        const { data, error: e } = await supabase
          .from(tableName(productType))
          .upsert({
            ...productImgForm,
            image_id: image[0].id,
          })
          .select();
        if (e) throw e;
        return data;
      }
    } catch (e: any) {
      notify({
        title: `Error saving images`,
        text: e?.message || `An error occurred trying to save a image. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      imageLoading.value = false;
    }
  }

  const setImages = async (productId: number, productName?: string) => {
    try {
      imageLoading.value = true;

      const saveImages: Promise<any>[] = [];

      images.value.forEach((img) => {
        const imageForm = {
          id: img.id === 0 ? undefined : img.id,
          url: img.url,
          name: img.name,
          imageFile: img.imageFile,
        }
        const productImageForm = {
          image_id: img.id === 0 ? undefined : img.id,
          display_order: img.display_order,
          is_primary: img.is_primary,
          [columnName(productType)]: productId,
        }
        const productNameSlug = productName ? slugify(productName) : undefined;
        saveImages.push(saveImage(imageForm, productImageForm, productNameSlug));
      });
      const promiseResult = await Promise.allSettled(saveImages);
    } catch (e: any) {
      console.error(e);
      notify({
        title: `Error saving images`,
        text: e?.message || `An error occurred trying to save images. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      imageLoading.value = false;
    }
  }

  const deleteImage = async (imageId: number, imageUrl: string) => {
    try {
      const { data, error } = await supabase
        .from('image')
        .delete()
        .eq('id', imageId);
      if (imageUrl && isImageUrlFromCloudFront(imageUrl)) {
        await deleteFile(imageUrl);
      }
      if (error) throw error;
    } catch (e: any) {
      notify({
        title: `Error removing Image ${imageId}`,
        text: e?.message || `An error ocurred trying to delete a image. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      });
    }
  }

  const deleteImages = async () => {
    try {
      imageLoading.value = true;
      const deleteImagesPromise: Promise<any>[] = [];

      imagesToDelete.value.forEach((img) => {
        deleteImagesPromise.push(deleteImage(img.id as number, img.url as string));
      });

      const promiseResult = await Promise.allSettled(deleteImagesPromise);
    } catch (e: any) {
      console.error(e);
      notify({
        title: 'Error deleting images',
        text: e?.message || `An error ocurred trying to delete images. Please contact TOP Support.`,
        type: 'error',
        duration: 6000,
      })
    } finally {
      imageLoading.value = false;
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
    () => productImagesRef.value,
    (productImages) => {
      if (productImages) {
        images.value = productImages;
      }
    },
    { deep: true },
  );

  onMounted(() => {
    if (productImagesRef.value)
      images.value = productImagesRef.value;
  });

  return {
    imageLoading,
    images,
    dialogDeleteImage,
    imageToDelete,
    addImage,
    removeImageFromList,
    toggleImageIsPrimary,
    toggleForceUrlImage,
    onImageChange,
    clearImage,
    saveImage,
    setImages,
    deleteImages,
    openImageDeleteDialog,
    closeImageDeleteDialog,
  }
}
