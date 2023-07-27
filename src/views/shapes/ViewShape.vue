<template>
  <div>
    <shape-form
      :loading="loading"
      :shape="shape"
      readonly
    ></shape-form>
  </div>
</template>
<script lang="ts" setup>
import ShapeForm from '@/components/ShapeForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface Shape {
  id?: number;
  name: string;
  slug?: string;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const shape: Ref<Shape> = ref<Shape>({
  id: 0,
  name: '',
  slug: '',
});

onMounted(async () => {
  store.pageTitle = 'Shape - View';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('shape')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) shape.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving shape.',
      text: e?.message || 'An error ocurred trying to retrieve shape. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>