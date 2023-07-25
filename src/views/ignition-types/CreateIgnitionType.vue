<template>
  <div>
    <ignition-type-form new></ignition-type-form>
  </div>
</template>
<script lang="ts" setup>
import IgnitionTypeForm from '@/components/IgnitionTypeForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Ignition Types - New';
});
</script>