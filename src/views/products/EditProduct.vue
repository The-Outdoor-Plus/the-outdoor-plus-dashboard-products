<template>
  <div>
    <product-form
      :loading="isLoading"
      :product="product"
      :product-prices="prices"
      :product-attributes="productAttributes"
      :product-images="images"
      :product-spect-sheets="specificationSheets"
      :product-documents="documents"
      :attribute-values="attrValues"
      edit
    ></product-form>
  </div>
</template>
<script lang="ts" setup>
import ProductForm from '@/components/ProductForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { Attribute, Documents, Product } from '@/types/product';
import { computed, onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';
import { Image, SpecificationSheet, PriceData } from '@/types/product';
import { useProduct } from '@/composables/product';

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const loadingData = ref(false);
const product: Ref<Product> = ref<Product>({
  id: 0,
  name: '',
});

const isLoading = computed(() => loading.value && productLoading.value);

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

const {
  productLoading,
  attrValues,
  loadDocuments,
  loadProductAttributes,
  loadProductImages,
  loadProductPrices,
  loadSpecificationSheets,
} = useProduct();

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

const productAttributes: Ref<Attribute[]> = ref<Attribute[]>([]);
const images: Ref<Image[]> = ref<Image[]>([]);
const specificationSheets: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);
const documents: Ref<Documents[]> = ref<Documents[]>([]);

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
    documents.value = await loadDocuments(productId) || [];
    specificationSheets.value = await loadSpecificationSheets(productId) || [];
    productAttributes.value = await loadProductAttributes(productId) || [];
  }
}

onMounted(async () => {
  store.pageTitle = 'Product - Edit';
  await loadData();
  await loadProductInformation();
});
</script>
