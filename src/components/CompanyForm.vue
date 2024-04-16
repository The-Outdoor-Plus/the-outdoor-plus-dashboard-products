<template>
  <div class="tw-w-full">
    <div class="tw-w-full tw-flex tw-justify-end tw-mb-4 tw-px-4">
      <v-btn
        v-if="readonly"
        color="purple"
        append-icon="mdi-pencil"
        @click.prevent="$router.push(`/companies/edit/${route.params.id}`)"
      >Edit</v-btn>
    </div>
    <v-card class="py-12 px-10" :loading="isLoading">
      <v-btn
        class="-tw-mt-6 tw-mb-6 -tw-ml-4"
        icon="mdi-arrow-left"
        flat
        @click="$router.push('/companies')"
      ></v-btn>
      <form @submit.prevent="submit">
        <div class="tw-w-full">
          <h1 class="tw-text-base tw-font-semibold">{{ title }}</h1>
          <div class="tw-text-sm">{{ subtitle }}</div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Name</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="name.value.value"
              variant="outlined"
              density="compact"
              name="Name"
              placeholder="Name"
              :error-messages="name.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Slug</h3>
            <span v-if="!props.readonly" class="tw-text-sm tw-text-gray-500 tw-mt-1">
              Optional. If no slug is provided, a default slug will be generated.
            </span>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="slug.value.value"
              variant="outlined"
              density="compact"
              name="Slug"
              placeholder="company-slug"
              :error-messages="slug.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
            <span v-if="!slug.value.value && name.value.value" class="tw-text-sm tw-text-gray-500">
              Generated default slug: {{ slugPlaceholder }}
            </span>
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
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Logo URL</h3>
            <span class="tw-text-sm tw-text-gray-500 tw-mt-1">
              In order to make the link work, when you click on the button "copy link" from the dropbox,
              you'll get a link that ends with <span class="tw-italic tw-font-semibold">?dl=0</span> . You'll need to replace
              that with <span class="tw-italic tw-font-semibold">?raw=1</span>
            </span>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="logoUrl.value.value"
              variant="outlined"
              density="compact"
              name="logoURL"
              placeholder="https://dropbox-link-to-log.com"
              :error-messages="logoUrl.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div class="tw-w-full">
          <v-spacer></v-spacer>
          <v-btn
            v-if="!readonly"
            type="submit"
            color="primary"
          >{{ submitButtonTitle }}</v-btn>
        </div>
      </form>
    </v-card>
  </div>
</template>
<script lang="ts" setup>
import { ref, computed, watch, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useNotification } from '@kyvg/vue3-notification';
import * as yup from 'yup';
import { toTypedSchema } from '@vee-validate/yup';
import { useField, useForm } from 'vee-validate';
import { supabase } from '@/supabase';

/**
 *
 * Defining Interfaces
 *
 */
interface Company {
  id?: number;
  name: string;
  slug?: string;
  logo_url?: string;
  role?: string;
}

interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  company?: Company | null;
  loading?: boolean;
}

const router = useRouter();
const route = useRoute();
const isLoading = ref(false);
const { notify } = useNotification();

const props = withDefaults(defineProps<Props>(), {
  new: false,
  edit: false,
  readonly: false,
  company: null,
  loading: false,
});
watch(
  () => props.loading,
  (value) => {
    isLoading.value = value;
  }
);

const title = computed(() => {
  if (props.new) return 'Create Company';
  if (props.edit) return 'Edit Company';
  if (props.readonly) return 'View Company';
  return 'Company Form';
})

const subtitle = computed(() => {
  if (props.new) return 'Fill out the information below to create a company';
  if (props.edit) return 'Use the form below to edit the company';
  if (props.readonly) return 'View Company Information';
  return '';
})

const submitButtonTitle = computed(() => {
  if (props.new) return 'Create';
  if (props.edit) return 'Save';
  if (props.readonly) return 'Edit Company';
  return '';
})

const roles = [
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
    title: 'Group',
    value: 'GROUP',
  },
  {
    title: 'Internet',
    value: 'INTERNET',
  },
  {
    title: 'Landscape / Designer',
    value: 'LANDSCAPE',
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

/**
 * Grabbed from https://byby.dev/js-slugify-string
 */
const slugify = (str: string) => (
  String(str)
    .normalize('NFKD') // split accented characters into their base characters and diacritical marks
    .replace(/[\u0300-\u036f]/g, '') // remove all the accents, which happen to be all in the \u03xx UNICODE block.
    .trim() // trim leading or trailing whitespace
    .toLowerCase() // convert to lowercase
    .replace(/[^a-z0-9 -]/g, '') // remove non-alphanumeric characters
    .replace(/\s+/g, '-') // replace spaces with hyphens
    .replace(/-+/g, '-') // remove consecutive hyphens
)

const slugPlaceholder = computed(() => slugify(name.value.value))

const { handleSubmit } = useForm({
  validationSchema: toTypedSchema(
    yup.object({
      name: yup.string().min(2).required(),
      slug: yup.string(),
      role: yup.string().required(),
      logo_url: yup.string(),
    })
  ),
});

const name = useField<string>('name');
const slug = useField<string>('slug');
const logoUrl = useField<string>('logo_url');
const role = useField<string>('role');

const fillCompanyInformation = () => {
  if (props.edit || props.readonly) {
    name.value.value = props.company?.name || '';
    slug.value.value = props.company?.slug || '';
    logoUrl.value.value = props.company?.logo_url || '';
    role.value.value = props.company?.role || '';
  }
}

onMounted(() => {
  fillCompanyInformation();
});
watch(
  () => props.company,
  () => {
    fillCompanyInformation();
  },
  { deep: true }
);

const handleCreate = async (values: Company) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    if (!form.slug) form.slug = slugify(form.name);
    const { data: company , error } = await supabase
      .from('company')
      .insert(form)
      .select();
    if (error) throw error;
    if (company.length) {
      router.push(`/companies/${company[0].id}`)
    }
    notify({
      title: 'Company created successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error creating company',
      text: e?.message || 'An error occurred trying to create a company. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const handleUpdate = async (values: Company) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    if (!form.slug) form.slug = slugify(form.name);
    const { data: company, error } = await supabase
      .from('company')
      .update(form)
      .eq('id', props?.company?.id || 0)
      .select();
    if (error) throw error;
    if(company.length) {
      name.value.value = company[0].name;
      slug.value.value = company[0].slug;
      role.value.value = company[0].role;
      logoUrl.value.value = company[0].logo_url;
    }
    notify({
      title: 'Company updated successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);

    notify({
      title: 'Error updating company',
      text: e?.message || 'An error ocurred trying to update the company. Please contact TOP support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}



const submit = handleSubmit(async (values) => {
  if (props.new) await handleCreate(values);
  else if (props.edit) await handleUpdate(values);
})
</script>
