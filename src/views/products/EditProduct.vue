<template>
  <div>
    <product-form
      :loading="loading"
      :product="product"
      :product-prices="prices"
      :product-attributes="productAttrs"
      :product-images="images"
      :product-spect-sheets="specificationSheets"
      edit
    ></product-form>
  </div>
</template>
<script lang="ts" setup>
import ProductForm from '@/components/ProductForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { Product } from '@/types/product';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';
import { Image, SpecificationSheet, PriceData } from '@/types/product';

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const loadingData = ref(false);
const product: Ref<Product> = ref<Product>({
  id: 0,
  name: '',
});

const loadData = async () => {
  try {
    loading.value = true;
    loadingData.value = true;
    const { data, error } = await supabase
      .from('product')
      .select()
      .eq('id', route.params.id);
      if (error) throw error;
      if (data.length) product.value = data[0];
  } catch (e: any) {
    notify({
      title: 'Error retrieving product.',
      text: e?.message || 'An error ocurred trying to retrieve product. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
    loadingData.value = false;
  }
}

const loadProductPrices = async (type: string, product_id: number) => {
  try {
    loading.value = true;
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
    loading.value = false;
  }
}

const loadProductAttributes = async (attr_type: string, product_id: number, color_type?: string) => {
  try {
    loading.value = true;
    let query = supabase.from(`product_${attr_type}`)
      .select(`${attr_type}_id, product_id`)
      .eq(`product_id`, product_id)
    if (color_type) query = query.eq(`type`, color_type);
    const { data: attribute, error } = await query;
    if (error) throw error;
    return attribute.map((item) => +(item?.[`${attr_type}_id` as any]) as number);
  } catch(e: any) {
    notify({
      title: `Error loading ${attr_type} attribute.`,
      text: e?.message || `An error occurred trying to load ${attr_type} attribute. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
}

const loadProductImages = async (product_id: number) => {
  try {
    loading.value = true;
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
    loading.value = false;
  }
}

const loadSpecificationSheets = async (product_id: number) => {
  try {
    loading.value = true;
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
    loading.value = false;
  }
}

const prices: Ref<PriceData> = ref<PriceData>({
  map: [],
  dealer: [],
  distributor: [],
  group: [],
  internet: [],
  landscape: [],
  master_distributor: [],
  msrp: [],
});

const productAttrs: {
  colors: Ref<number[] | number>
  baseColors: Ref<number[] | number>
  ignitionTypes: Ref<number[] | number>
  gasTypes: Ref<number[] | number>
} = {
  colors: ref<number[] | number>([]),
  baseColors: ref<number[] | number>([]),
  ignitionTypes: ref<number[] | number>([]),
  gasTypes: ref<number[] | number>([]),
}

const images: Ref<Image[]> = ref<Image[]>([]);
const specificationSheets: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);

const loadProductInformation = async () => {
  if (product.value?.id) {
    const productId = +product.value?.id;
    prices.value.msrp = await loadProductPrices('msrp', productId) || [];
    prices.value.internet = await loadProductPrices('internet', productId) || [];
    prices.value.map = await loadProductPrices('map', productId) || [];
    prices.value.group = await loadProductPrices('group', productId) || [];
    prices.value.dealer = await loadProductPrices('dealer', productId) || [];
    prices.value.distributor = await loadProductPrices('distributor', productId) || [];
    prices.value.landscape = await loadProductPrices('landscape', productId) || [];
    prices.value.master_distributor = await loadProductPrices('master_distributor', productId) || [];
    images.value = await loadProductImages(productId) || [];
    if (product.value.relation === 'PARENT' || product.value.relation === 'PARENT_GROUP') {
      productAttrs.colors.value = await loadProductAttributes('color', productId, 'default') || [];
      productAttrs.baseColors.value = await loadProductAttributes('color', productId, 'base') || [];
      productAttrs.gasTypes.value = await loadProductAttributes('gas', productId) || [];
      productAttrs.ignitionTypes.value = await loadProductAttributes('ignition', productId) || [];
      specificationSheets.value = await loadSpecificationSheets(productId) || [];
    }
  }
}

onMounted(async () => {
  store.pageTitle = 'Product - Edit';
  await loadData();
  await loadProductInformation();
});
</script>
