<template>
  <div>
    <gas-type-form
      :loading="loading"
      :gas-type="gasType"
      readonly
    ></gas-type-form>
  </div>
</template>
<script lang="ts" setup>
import GasTypeForm from '@/components/GasTypeForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface GasType {
  id?: number;
  name: string;
  slug?: string;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const gasType: Ref<GasType> = ref<GasType>({
  id: 0,
  name: '',
  slug: '',
});

onMounted(async () => {
  store.pageTitle = 'Gas Type - View';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('gas')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) gasType.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving gas type.',
      text: e?.message || 'An error ocurred trying to retrieve gas type. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>