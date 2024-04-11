<template>
  <div>
    <quick-view-pricing-tool></quick-view-pricing-tool>
  </div>
</template>

<script lang="ts" setup>
import QuickViewPricingTool from '@/components/QuickViewPricingTool.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Quick View Pricing Tool';
})
</script>
