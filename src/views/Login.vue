<template>
  <div class="tw-w-full tw-min-h-screen">
    <div class="tw-flex tw-flex-row tw-h-full">
      <div class="tw-w-3/12 tw-min-h-screen">
        <div class="tw-w-full tw-bg-white tw-mt-60 tw-flex tw-flex-col tw-px-8">
          <v-img
            class="tw-w-full"
            src="@/assets/top_logo.png"
          ></v-img>
          <form 
            class="tw-mt-8"
            @submit.prevent="submit"
          >
            <v-text-field
              v-model="email.value.value"
              variant="outlined"
              name="Email"
              label="E-mail"
              :error-messages="email.errorMessage.value"
            ></v-text-field>
            <v-text-field
              v-model="password.value.value"
              class="tw-mt-4"
              variant="outlined"
              name="Password"
              label="Password"
              :error-messages="password.errorMessage.value"
              :append-inner-icon="passwordVisible ? 'mdi-eye-off' : 'mdi-eye'"
              :type="passwordVisible ? 'text' : 'password'"
              @click:append-inner="passwordVisible = !passwordVisible"
            ></v-text-field>
            <v-btn
              class="tw-mt-4 tw-bg-blue-600"
              type="submit"
              block
              color="blue-darken-3"
            >
              Login
            </v-btn>
          </form>
        </div>
      </div>
      <div class="tw-w-9/12 tw-min-h-screen">
        <v-img
          class="tw-h-full"
          cover
          src="@/assets/topbg.jpg"
        ></v-img>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import { useField, useForm } from 'vee-validate';
import { toTypedSchema } from '@vee-validate/yup'
import * as yup from 'yup';
import { useNotification } from '@kyvg/vue3-notification';
import { supabase } from '@/supabase';
import { useUserStore } from '@/store/user';
import { useRouter } from 'vue-router';

const userStore = useUserStore();
const { notify } = useNotification();
const router = useRouter();

const isLoading = ref(false);

const passwordVisible = ref(false);

const { handleSubmit } = useForm({
  validationSchema: toTypedSchema(
    yup.object({
      email: yup.string().email().required(),
      password: yup.string().min(6).required(),
    })
  ),
});

const email = useField('email');
const password = useField('password');

const submit = handleSubmit(async (values) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    const { data, error } = await supabase.auth.signInWithPassword(form);
    if (error) throw error;
    userStore.successfullLogIn(data.user, data.session);
    notify({
      title: 'Logged in successfully',
      type: 'success',
      duration: 5000,
    });
    router.push('/');
  } catch (e: any) {
    notify({
      title: 'Error signing in.',
      text: e?.message || 'An error ocurred trying to sign in. Please contact TOP Support.',
      type: 'error',
      duration: 5000,
    });
    console.error(e);
  } finally {
    isLoading.value = false;
  }
});
</script>

