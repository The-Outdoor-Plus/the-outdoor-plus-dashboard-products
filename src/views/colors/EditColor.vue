<template>
  <div>
    <color-form
      :loading="loading"
      :color="color"
      edit
    ></color-form>
  </div>
</template>
<script lang="ts" setup>
import ColorForm from '@/components/ColorForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface Color {
  id?: number;
  name: string;
  slug?: string;
  material_id?: number;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const color: Ref<Color> = ref<Color>({
  id: 0,
  name: '',
  slug: '',
  material_id: 0,
});

onMounted(async () => {
  store.pageTitle = 'Color - Edit';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('color')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) color.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving color.',
      text: e?.message || 'An error ocurred trying to retrieve color. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>