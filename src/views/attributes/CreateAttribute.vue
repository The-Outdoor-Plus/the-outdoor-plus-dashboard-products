<template>
  <div>
    <attributes-form new></attributes-form>
  </div>
</template>
<script lang="ts" setup>
import AttributesForm from '@/components/AttributesForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Attributes - New';
});
</script>
