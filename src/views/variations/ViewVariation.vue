<template>
  <div>
    <variation-form
      readonly
      :loading="isLoading"
      :variation="variation"
      :variation-prices="prices"
      :variation-images="images"
      :variation-documents="documents"
      :variation-spec-sheets="specificationSheets"
      :variation-attributes="attributes"
    ></variation-form>
  </div>
</template>
<script lang="ts" setup>
import VariationForm from '@/components/VariationForm.vue';
import { useVariation } from '@/composables/variation';
import { useAppStore } from '@/store/app';
import { useVariationStore } from '@/store/variation';
import { supabase } from '@/supabase';
import { Documents, Image, PriceData, SpecificationSheet } from '@/types/product';
import { Variation } from '@/types/variation';
import { notify } from '@kyvg/vue3-notification';
import { computed, onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

const store = useAppStore();
const variationStore = useVariationStore();
const route = useRoute();

const isLoading = computed(() => loading.value && variationLoading.value);
const loading = ref(false);
const variation: Ref<Variation> = ref<Variation>({});
const prices: Ref<PriceData> = ref<PriceData>({
  dealer: [],
  distributor: [],
  group: [],
  internet: [],
  landscape: [],
  map: [],
  master_distributor: [],
  msrp: [],
});
const images: Ref<Image[]> = ref<Image[]>([]);
const specificationSheets: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);
const documents: Ref<Documents[]> = ref<Documents[]>([]);

const loadData = async () => {
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('variation')
      .select()
      .eq('id', +route.params.variantid);
    if (error) throw error;
    if (data.length) variation.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving variation.',
      text: e?.message || 'An error ocurred trying to retrieve the variation. Please contact TOP support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
}

const {
  variationLoading,
  attributes,
  loadAttributes,
  loadDocuments,
  loadVariationPrices,
  loadVariationImages,
  loadSpecificationSheets
} = useVariation();

const loadVariationInformation = async () => {
  if (variation.value?.id) {
    const variationId = +variation.value?.id;
    await loadAttributes(variationId);
    prices.value.msrp = await loadVariationPrices('msrp', variationId) || [];
    prices.value.internet = await loadVariationPrices('internet', variationId) || [];
    prices.value.map = await loadVariationPrices('map', variationId) || [];
    prices.value.group = await loadVariationPrices('group', variationId) || [];
    prices.value.dealer = await loadVariationPrices('dealer', variationId) || [];
    prices.value.distributor = await loadVariationPrices('distributor', variationId) || [];
    prices.value.landscape = await loadVariationPrices('landscape', variationId) || [];
    prices.value.master_distributor = await loadVariationPrices('master_distributor', variationId) || [];
    images.value = await loadVariationImages(variationId) || [];
    documents.value = await loadDocuments(variationId) || [];
    specificationSheets.value = await loadSpecificationSheets(variationId) || [];
  }
}

onMounted(async () => {
  store.pageTitle = 'Variation - View';
  variation.value = variationStore.initialValues;
  await loadData();
  await loadVariationInformation();
});
</script>
