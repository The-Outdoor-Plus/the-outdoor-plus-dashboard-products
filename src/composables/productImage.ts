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
    }
    images.value.push(newImage);
  }

  const removeImageFromList = (item: Image) => {
    images.value = images.value.filter((imageItem) => imageItem.id !== item.id);
  }

  const toggleImageIsPrimary = (imageId?: number | null, value?: boolean) => {
    const valueToSet = !value;
    images.value = images.value.map((img) => ({
      ...img,
      is_primary: img.id === imageId ? valueToSet : false,
    }));
  }

  const saveImage = async (imageForm: Image, productImgForm: Image) => {
    try {
      imageLoading.value = true;
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

  const setImages = async (productId: number) => {
    try {
      imageLoading.value = true;

      const saveImages: Promise<any>[] = [];

      images.value.forEach((img) => {
        const imageForm = {
          id: img.id === 0 ? undefined : img.id,
          url: img.url,
          name: img.name,
        }
        const productImageForm = {
          image_id: img.id === 0 ? undefined : img.id,
          display_order: img.display_order,
          is_primary: img.is_primary,
          [columnName(productType)]: productId,
        }
        saveImages.push(saveImage(imageForm, productImageForm));
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
    addImage,
    removeImageFromList,
    toggleImageIsPrimary,
    saveImage,
    setImages,
  }
}
