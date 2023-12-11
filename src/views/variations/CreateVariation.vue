<template>
  <div>
  </div>
</template>
<script lang="ts" setup>
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Variation - New';
});
</script>
