<template>
  <div>
    <shape-form new></shape-form>
  </div>
</template>
<script lang="ts" setup>
import ShapeForm from '@/components/ShapeForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Shape - New';
});
</script>