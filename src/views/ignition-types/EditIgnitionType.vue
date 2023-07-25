<template>
  <div>
    <ignition-type-form
      :loading="loading"
      :ignition-type="ignitionType"
      edit
    ></ignition-type-form>
  </div>
</template>
<script lang="ts" setup>
import IgnitionTypeForm from '@/components/IgnitionTypeForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface IgnitionType {
  id?: number;
  name: string;
  slug?: string;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const ignitionType: Ref<IgnitionType> = ref<IgnitionType>({
  id: 0,
  name: '',
  slug: '',
});

onMounted(async () => {
  store.pageTitle = 'Ignition Type - Edit';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('ignition')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) ignitionType.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving ignition type.',
      text: e?.message || 'An error ocurred trying to retrieve ignition type. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>