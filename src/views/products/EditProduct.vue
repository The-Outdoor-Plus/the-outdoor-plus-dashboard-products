<template>
  <div>
    <product-form
      :loading="loading"
      :product="product"
      edit
    ></product-form>
  </div>
</template>
<script lang="ts" setup>
import ProductForm from '@/components/ProductForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface Product {
  id?: number;
  name: string;
  slug?: string;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const product: Ref<Product> = ref<Product>({
  id: 0,
  name: '',
  slug: '',
});

onMounted(async () => {
  store.pageTitle = 'Product - Edit';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('product')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) product.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving product.',
      text: e?.message || 'An error ocurred trying to retrieve product. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>