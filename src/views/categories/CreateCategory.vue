<template>
  <div>
    <category-form new></category-form>
  </div>
</template>
<script lang="ts" setup>
import CategoryForm from '@/components/CategoryForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Category - New';
});
</script>