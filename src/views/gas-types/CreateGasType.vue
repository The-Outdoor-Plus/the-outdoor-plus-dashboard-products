<template>
  <div>
    <gas-type-form new></gas-type-form>
  </div>
</template>
<script lang="ts" setup>
import GasTypeForm from '@/components/GasTypeForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Gas Types - New';
});
</script>