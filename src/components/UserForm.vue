<template>
  <div class="tw-w-full">
    <v-card class="py-12 px-10" :loading="isLoading">
      <v-btn
        class="-tw-mt-6 tw-mb-6 -tw-ml-4"
        icon="mdi-arrow-left"
        flat
        @click="$router.push('/users')"
      ></v-btn>
      <form
        @submit.prevent="submit"
      >
        <div class="tw-w-full">
          <h1 class="tw-text-base tw-font-semibold">{{ title }}</h1>
          <div class="tw-text-sm">{{ subtitle }}</div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">First Name</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="firstName.value.value"
              variant="outlined"
              density="compact"
              name="First Name"
              placeholder="First Name"
              :error-messages="firstName.errorMessage.value"
              :readonly="readonly"
            ></v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Last Name</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="lastName.value.value"
              variant="outlined"
              density="compact"
              name="Last Name"
              placeholder="Last Name"
              :error-messages="lastName.errorMessage.value"
              :readonly="readonly"
            ></v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Email</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="email.value.value"
              variant="outlined"
              density="compact"
              name="Email"
              placeholder="Email"
              :error-messages="email.errorMessage.value"
              :readonly="readonly"
            ></v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Role</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-select
              v-model="role.value.value"
              :items="roles"
              variant="outlined"
              density="compact"
              name="Role"
              placeholder="Role"
              :error-messages="role.errorMessage.value"
              :readonly="readonly"
            ></v-select>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Company</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="company.value.value"
              variant="outlined"
              density="compact"
              name="Company"
              placeholder="Company"
              :error-messages="company.errorMessage.value"
              :readonly="readonly"
            ></v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div v-if="!readonly" class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Password</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="password.value.value"
              variant="outlined"
              density="compact"
              name="password"
              placeholder="Password"
              :error-messages="password.errorMessage.value"
              :append-inner-icon="passwordVisible ? 'mdi-eye-off' : 'mdi-eye'"
              :type="passwordVisible ? 'text' : 'password'"
              :readonly="readonly"
              @click:append-inner="passwordVisible = !passwordVisible"
            ></v-text-field>
          </div>
        </div>
        <v-divider v-if="!readonly" class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div class="tw-w-full">
          <v-spacer></v-spacer>
          <v-btn
            v-if="!readonly"
            type="submit"
            color="primary"
          >Submit</v-btn>
        </div>
      </form>
    </v-card>
  </div>
</template>
<script lang="ts" setup>
import * as yup from 'yup';
import { toTypedSchema } from '@vee-validate/yup';
import { useField, useForm } from 'vee-validate';
import { ref, onMounted, watch, computed } from 'vue';
import { supabase, supabaseAdmin } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { useRouter } from 'vue-router';

interface User {
  id?: string;
  first_name?: string | null;
  last_name?: string | null;
  email: string;
  role?: string | null;
  company?: string | null;
}

interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  user?: User | null;
  loading?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  new: false,
  edit: false,
  readonly: false,
  user: null,
  loading: false,
});
watch(
  () => props.loading,
  (value) => {
    isLoading.value = value;
  }
);

const router = useRouter();

const roles = [
  {
    title: 'User',
    value: 'USER'
  },
  {
    title: 'Guest',
    value: 'GUEST',
  },
  {
    title: 'Dealer',
    value: 'DEALER',
  },
  {
    title: 'Distributor',
    value: 'DISTRIBUTOR',
  },
  {
    title: 'Master Distributor',
    value: 'MASTER_DISTRIBUTOR',
  },
  {
    title: 'Manager',
    value: 'MANAGER',
  },
  {
    title: 'Admin',
    value: 'ADMIN',
  },
  {
    title: 'Sales',
    value: 'SALES',
  }
];
const passwordVisible = ref(false);
const isLoading = ref(false);
const { notify } = useNotification();

const { handleSubmit } = useForm({
  validationSchema: toTypedSchema(
    yup.object({
      email: yup.string().email().required(),
      first_name: yup.string().min(3).required(),
      last_name: yup.string().min(3).required(),
      role: yup.string().required(),
      company: yup.string().min(3),
      password: props.new ? yup.string().min(6).required() : yup.string().min(6),
    })
  ),
});

const firstName = useField<string>('first_name');
const lastName = useField<string>('last_name');
const email = useField<string>('email');
const role = useField<string>('role');
const company = useField<string>('company');
const password = useField<string>('password');

const title = computed(() => {
  if (props.new) return 'Create User';
  if (props.edit) return 'Edit User Information';
  if (props.readonly) return 'View User Information';
  return 'User Form';
});

const subtitle = computed(() => {
  if (props.new) return 'Fill out the information below to create a new user.';
  if (props.edit) return 'Use the form below to edit user information.';
  if (props.readonly) return 'View User Information';
  return '';
});

const fillUserInformation = () => {
  if (props.edit || props.readonly) {
    firstName.value.value = props.user?.first_name || '';
    lastName.value.value = props.user?.last_name || '';
    email.value.value = props.user?.email || '';
    role.value.value = props.user?.role || '';
    company.value.value = props.user?.company || '';
  }
}

onMounted(() => {
  fillUserInformation();
});
watch(
  () => props.user,
  () => {
    fillUserInformation();
  },
  { deep: true }
);

const submit = handleSubmit(async (values) => {
  if (props.new) {
    await handleCreate(values);
  } else if (props.edit) {
    await handleUpdate(values);
  }
});

const handleCreate = async (values: User) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    const { data: { user } , error } = await supabaseAdmin.auth.admin.createUser({
      email: form.email,
      password: form.password,
      user_metadata: {
        first_name: form.first_name,
        last_name: form.last_name,
        role: form.role,
        company: form.company,
      }
    });
    if (error) throw error;
    router.push(`/users/${user?.id}`)
    notify({
      title: 'User created successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error creating user',
      text: e?.message || 'An error ocurred trying to create a user. Please contact TOP Support',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const handleUpdate = async (values: User) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    const userInformation = {
      email: form.email,
      password: form.password,
      user_metadata: {
        first_name: form.first_name,
        last_name: form.last_name,
        role: form.role,
        company: form.company,
      }
    }
    const publicUserData = {
      email: form.email,
      first_name: form.first_name,
      last_name: form.last_name,
      role: form.role,
      company: form.company,
    }
    if (!form.password) delete userInformation.password;
    const { error: err } = await supabaseAdmin.auth.admin.updateUserById(
      props?.user?.id || '',
      userInformation,
    );
    if (err) throw err;
    const { error } = await supabase
      .from('users')
      .update(publicUserData)
      .eq('id', props?.user?.id || '');
    if (error) throw error;
    notify({
      title: 'User updated successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error updating user',
      text: e?.message || 'An error ocurred trying to update the user. Please contact TOP support',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

</script>
