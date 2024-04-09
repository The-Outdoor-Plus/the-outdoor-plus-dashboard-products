<template>
  <div>
    <product-form
      :loading="isLoading"
      :product="product"
      :product-attributes="productAttributes"
      :product-images="images"
      :product-spect-sheets="specificationSheets"
      :product-documents="documents"
      :attribute-values="attrValues"
      readonly
    ></product-form>
    <variations-list
      :show-child-products="showChildProducts"
      :redirect-to-new-product="redirectToNewProduct"
      :product-id="+(product?.id || 0)"
      :loading-data="loadingData"
      @update-information="updateInformation"
    />
  </div>
</template>
<script lang="ts" setup>
import ProductForm from '@/components/ProductForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref, watch, computed } from 'vue';
import { useRoute } from 'vue-router';
import { Attribute, Documents, Product } from '@/types/product';
import { Image, SpecificationSheet } from '@/types/product';
import { useProduct } from '@/composables/product';
import VariationsList from '@/components/VariationsList.vue';

interface Columns {
  actions: null | undefined;
  id: number;
  name: string;
  sku: string;
  collection: string;
  category: string;
  material: string;
  published: boolean;
  enabled: boolean;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const loadingData = ref(false);
const isLoading = computed(() => loading.value && productLoading.value);
const product: Ref<Product> = ref<Product>({
  id: 0,
  name: '',
});

const queryParams = computed(() => {
  const params: any = {
    ...(product.value.sku ? { sku: `${product.value.sku}-(XX)-(XX)` } : {}),
    ...(product.value.burner_shape ? { burner_shape: product.value.burner_shape }: {}),
    ...(product.value.compatible_bullet_burner ? { compatible_bullet_burner: product.value.compatible_bullet_burner } : {}),
    ...(product.value.compatible_canvas_cover ? { compatible_canvas_cover: product.value.compatible_canvas_cover } : {}),
    ...(product.value.compatible_glass_wind_guard ? { compatible_glass_wind_guard: product.value.compatible_glass_wind_guard } : {}),
    ...(product.value.product_serial_base ? { product_serial_base: product.value.product_serial_base } : {}),
    ...(product.value.name ? { name: product.value.name } : {}),
    ...(product.value.short_description ? { short_description: product.value.short_description } : {}),
    ...(product.value.description ? { description: product.value.description } : {}),
    ...(product.value.website_link ? { website_link: product.value.website_link } : {}),
    ...(product.value?.certifications?.length ? { certifications: JSON.stringify(product.value.certifications) }: {}),
    ...(product.value.dealer_price ? { name: product.value.dealer_price } : {}),
    ...(product.value.distributor_price ? { name: product.value.distributor_price } : {}),
    ...(product.value.group_price ? { name: product.value.group_price } : {}),
    ...(product.value.internet_price ? { name: product.value.internet_price } : {}),
    ...(product.value.landscape_price ? { name: product.value.landscape_price } : {}),
    ...(product.value.map_price ? { name: product.value.map_price } : {}),
    ...(product.value.master_distributor_price ? { name: product.value.master_distributor_price } : {}),
    ...(product.value.msrp_price ? { name: product.value.msrp_price } : {}),
  };
  return new URLSearchParams(params).toString();
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
    console.error(e);
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
  attrValues,
  productLoading,
  loadDocuments,
  loadProductImages,
  loadProductAttributes,
  loadSpecificationSheets
} = useProduct();

const productAttributes: Ref<Attribute[]> = ref<Attribute[]>([]);
const images: Ref<Image[]> = ref<Image[]>([]);
const specificationSheets: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);
const documents: Ref<Documents[]> = ref<Documents[]>([]);

const loadProductInformation = async () => {
  if (product.value?.id) {
    const productId = +product.value?.id;
    images.value = await loadProductImages(productId) || [];
    documents.value = await loadDocuments(productId) || [];
    specificationSheets.value = await loadSpecificationSheets(productId) || [];
    productAttributes.value = await loadProductAttributes(productId) || [];
  }
}

const showChildProducts = computed(() => {
  return product.value.product_type === 'VARIABLE';
});

const redirectToNewProduct = computed(() => {
  return `/products/${product.value.id}/variant/new?${queryParams.value}`;
});


/**
 *
 * Dialog Delete Section
 *
 **/

const itemToDelete: Ref<Columns | null> = ref(null);
const deleteLoading = ref(false);
const dialogDelete = ref(false);

watch(dialogDelete, (value) => {
  if (!value) {
    itemToDelete.value = null;
  }
});
watch(route, async () => {
  if (route.params.id) {
    await updateInformation();
  }
});

const updateInformation = async () => {
  await loadData();
  await loadProductInformation();
}

const deleteItem = (item: Columns) => {
  dialogDelete.value = true;
  itemToDelete.value = item;
}

const closeDialogDelete = () => {
  dialogDelete.value = false;
  itemToDelete.value = null;
}

onMounted(async () => {
  store.pageTitle = 'Product - View';
  await updateInformation();
});


</script>
