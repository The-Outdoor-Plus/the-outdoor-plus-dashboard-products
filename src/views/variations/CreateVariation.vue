<template>
  <div>
    <variation-form
      new
      :variation="variation"
      :variation-prices="prices"
    ></variation-form>
  </div>
</template>
<script lang="ts" setup>
import VariationForm from '@/components/VariationForm.vue';
import { useAppStore } from '@/store/app';
import { useVariationStore } from '@/store/variation';
import { PriceData } from '@/types/product';
import { Variation } from '@/types/variation';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

const store = useAppStore();
const variationStore = useVariationStore();
const route = useRoute();

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

onMounted(() => {
  store.pageTitle = 'Variation - New';
  variation.value = variationStore.initialValues;
  Object.keys(route.query).forEach((queryKey) => {
    if (variationStore.variationKeys.includes(queryKey)) {
      console.log(queryKey);
      variation.value = {
        ...variation.value,
        [queryKey]: queryKey === 'certifications' ?
          JSON.parse(route.query[queryKey] as string) :
          route.query[queryKey],
      }
    }
  });
  if (route?.query?.prices) {
    prices.value = JSON.parse(route.query.prices as string) as PriceData;
  }
});
</script>
