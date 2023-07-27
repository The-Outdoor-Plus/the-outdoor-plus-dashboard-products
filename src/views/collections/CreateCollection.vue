<template>
  <div>
    <collection-form new></collection-form>
  </div>
</template>
<script lang="ts" setup>
import CollectionForm from '@/components/CollectionForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Collection - New';
});
</script>