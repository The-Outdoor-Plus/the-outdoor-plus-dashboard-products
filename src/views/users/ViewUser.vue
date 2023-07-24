<template>
  <div>
    <user-form readonly :loading="loading" :user="user"></user-form>
  </div>
</template>
<script lang="ts" setup>
import UserForm from '@/components/UserForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted, ref, Ref } from 'vue';
import { useNotification } from '@kyvg/vue3-notification';
import { supabase } from '@/supabase';
import { useRoute } from 'vue-router';

interface User {
  id?: string;
  first_name?: string | null;
  last_name?: string | null;
  email: string;
  role?: string | null;
  company?: string | null;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const user: Ref<User> = ref<User>({
  id: '',
  first_name: '',
  last_name: '',
  email: '',
  role: '',
  company: '',
});

onMounted(async () => {
  store.pageTitle = 'Users - View';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('users')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) user.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving user.',
      text: e?.message || 'An error ocurred trying to retrieve user information. Please contact TOP support',
      type: 'error',
      duration: 5000,
    });
  } finally {
    loading.value = false;
  }
})
</script>