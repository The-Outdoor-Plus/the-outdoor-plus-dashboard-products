<template>
  <div>
    <color-form new></color-form>
  </div>
</template>
<script lang="ts" setup>
import ColorForm from '@/components/ColorForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Colors - New';
});
</script>