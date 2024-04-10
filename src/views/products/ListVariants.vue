<template>
  <div>
    <div class="tw-w-full tw-flex tw-justify-between tw-mb-12">
      <div class="tw-flex tw-items-center">
        <v-btn
          class="tw-mr-4"
          icon="mdi-arrow-left"
          flat
          @click="router.back()"
        ></v-btn>
        <div class="tw-w-full">
          <h1 class="tw-text-2xl tw-font-semibold">{{ title }}</h1>
          <div class="tw-text-base">{{ subtitle }}</div>
        </div>
      </div>
    </div>
    <variations-list
      :show-child-products="showChildProducts"
      :redirect-to-new-product="redirectToNewProduct"
      :product-id="+(product?.id || 0)"
      :loading-data="loadingData"
      @update-information="loadData"
    >
    </variations-list>
  </div>
</template>
<script lang="ts" setup>
import VariationsList from '@/components/VariationsList.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { Product } from '@/types/product';
import { ref, computed, watch, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useNotification } from '@kyvg/vue3-notification';

const store = useAppStore();
const route = useRoute();
const router = useRouter();
const { notify } = useNotification();
const loadingData = ref(false);
const title = ref('');
const subtitle = ref('Variations List');

const product = ref<Product>({
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
    ...(product.value.dealer_price ? { dealer_price: product.value.dealer_price } : {}),
    ...(product.value.distributor_price ? { distributor_price: product.value.distributor_price } : {}),
    ...(product.value.group_price ? { group_price: product.value.group_price } : {}),
    ...(product.value.internet_price ? { internet_price: product.value.internet_price } : {}),
    ...(product.value.landscape_price ? { landscape_price: product.value.landscape_price } : {}),
    ...(product.value.map_price ? { map_price: product.value.map_price } : {}),
    ...(product.value.master_distributor_price ? { master_distributor_price: product.value.master_distributor_price } : {}),
    ...(product.value.msrp_price ? { msrp_price: product.value.msrp_price } : {}),
  };
  return new URLSearchParams(params).toString();
});

const showChildProducts = computed(() => {
  return !!(product.value.id && product.value.name);
});

const redirectToNewProduct = computed(() => {
  return `/products/${product.value.id}/variant/new?${queryParams.value}`;
});

watch(route, async () => {
  if (route.params.id) {
    await loadData();
  }
});

const loadData = async () => {
  try {
    loadingData.value = true;
    const { data, error } = await supabase
      .from('product')
      .select(`
        id,
        name,
        sku,
        burner_shape,
        compatible_bullet_burner,
        compatible_canvas_cover,
        compatible_glass_wind_guard,
        product_serial_base,
        short_description,
        description,
        website_link,
        certifications,
        dealer_price,
        distributor_price,
        group_price,
        internet_price,
        landscape_price,
        map_price,
        master_distributor_price,
        msrp_price
      `)
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) product.value = data[0];
    title.value = product.value?.name || '';
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving parent information.',
      text: e?.message || 'An error ocurred trying to retrieve parent information. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loadingData.value = false;
  }
}

onMounted(async () => {
  store.pageTitle = 'Product - Variations List';
  await loadData();
});

</script>
