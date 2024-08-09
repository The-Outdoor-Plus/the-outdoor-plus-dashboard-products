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
        <template v-if="props.new || props.edit">
          <v-divider class="border-opacity-100 tw-my-6"></v-divider>
          <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
            <div class="tw-w-full lg:tw-w-3/12">
              <h3 class="tw-text-base tw-font-semibold tw-mt-1">Logo</h3>
              <span class="tw-text-sm tw-text-gray-500 tw-mt-1">
              </span>
            </div>
            <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-8/12 xl:tw-w-5/12">
              <v-file-input
                label="Logo Image"
                variant="outlined"
                density="compact"
                name="Image"
                show-size
                :readonly="readonly"
                @change="onFileChange($event)"
                @click:clear="clearImage"
              ></v-file-input>
              <div>
                <div v-show="imagePreviewURL" class="tw-text-base tw-font-semibold tw-mb-4">Upload Preview: </div>
                <v-img
                    v-show="imagePreviewURL"
                    width="250"
                    :src="imagePreviewURL || ''"
                  >
                </v-img>
              </div>
              <v-expansion-panels class="mb-5 mt-8">
                <v-expansion-panel>
                  <v-expansion-panel-title disable-icon-rotate>
                    Advanced Options
                    <template v-slot:actions>
                      <v-icon color="orange" icon="mdi-alert">
                      </v-icon>
                    </template>
                  </v-expansion-panel-title>
                  <v-expansion-panel-text>
                    <h3 class="tw-text-base tw-font-semibold tw-mt-1">Logo Url Link</h3>
                    <span class="tw-text-sm tw-text-gray-700 tw-mt-1">
                      Preferrably, you need to upload a new image. In case that the image is already present in the AWS S3 Bucket,
                      you can copy the path of the image along with our cloudfront domain (https://assets.theoutdoorplus.com/). E.g. If the image is uploaded to "companies/top.png",
                      the link is going to be: https://assets.theoutdoorplus.com/companies/top.png
                    </span>
                    <br>
                    <br>
                    <span class="tw-text-sm tw-text-gray-700 tw-mt-1">
                      <b>If Link is from dropbox (Not recommended): </b>In order to make the link work, when you click on the button "copy link" from the dropbox,
                      you'll get a link that ends with <span class="tw-italic tw-font-semibold">?dl=0</span> . You'll need to replace
                      that with <span class="tw-italic tw-font-semibold">?raw=1</span>
                    </span>
                    <v-textarea
                      v-model="logoUrl.value.value"
                      class="mt-6"
                      variant="outlined"
                      density="compact"
                      name="Image"
                      placeholder="https://link-to-dropbox.com?raw=1"
                      :error-messages="logoUrl.errorMessage.value"
                      :readonly="readonly"
                    >
                    </v-textarea>
                  </v-expansion-panel-text>
                </v-expansion-panel>
              </v-expansion-panels>
            </div>
          </div>
        </template>
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
import { Ref, ref, computed, watch, onMounted } from 'vue';
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
const imageFile: Ref<File | null> = ref<File | null>(null);
const imagePreviewURL: Ref<string | null> = ref<string | null>(null);
const oldImageUrl: Ref<string> = ref<string>('');

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

const onFileChange = async (evt: Event) => {
  const target = evt.target as HTMLInputElement;
  if (target && target.files) {
    imageFile.value = target.files[0];
    imagePreviewURL.value = URL.createObjectURL(target.files[0]);
  }
}

const clearImage = () => {
  imageFile.value = null;
  imagePreviewURL.value = null;
}

const handleUpload = async () => {
  const formData = new FormData();
  formData.append('file', imageFile.value as File);

  let path = '/companies/';
  const isDev = import.meta.env.DEV;
  if (isDev) path = `/testing${path}`;
  formData.append('path', path);

  try {
    isLoading.value = true;
    const { data, error } = await supabase.functions.invoke('upload-to-s3', {
      body: formData,
    });
    if (error) throw error;
    if (data && data.fileUrl) {
      notify({
        title: 'Logo image uploaded successfully',
        text: data?.message || 'File uplaoded successfully.',
        type: 'success',
        duration: 6000,
      });
      imagePreviewURL.value = null;
      clearImage();
      return data.fileUrl;
    }
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error updating logo image',
      text: e?.message || 'An error ocurred trying to update the logo image. Please contact TOP support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const deleteFile = async(imgUrl?: string) => {
  try {
    isLoading.value = true;
    if (imgUrl && imgUrl !== '') {
      const { data, error } = await supabase.functions.invoke('delete-from-s3', {
        body: {
          prevImageUrl: imgUrl,
        },
        method: 'DELETE',
      });
      if (error) throw error;
      notify({
        title: 'Old logo image deleted successfully',
        text: data?.message || 'Previous file deleted.',
        type: 'success',
        duration: 6000,
      });
    }
  } catch (e: any) {
    notify({
      title: 'Error deleting image from server.',
      text: e?.message || 'An error ocurred trying to delete the old image from the server. Please contact TOP support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const isImageUrlFromCloudFront = (imgUrl: string) => {
  const cloudfrontDomain = import.meta.env.VITE_CLOUDFRONT_DOMAIN;
  const parsedUrl = new URL(imgUrl);
  return parsedUrl.hostname.endsWith(cloudfrontDomain);
}

const submit = handleSubmit(async (values) => {
  const form = JSON.parse(JSON.stringify(values));
  if (props.new) {
    if (imageFile.value) {
      const imgUrl = await handleUpload();
      if (imgUrl) form.logo_url = imgUrl;
    }
    await handleCreate(form);
  } else if (props.edit) {
    if (imageFile.value) {
      oldImageUrl.value = logoUrl.value.value;
      const imgUrl = await handleUpload();
      if (imgUrl) {
        form.logo_url = imgUrl;
        if (isImageUrlFromCloudFront(oldImageUrl.value)) {
          await deleteFile(oldImageUrl.value);
        }
      }
    }
    await handleUpdate(form);
  }
})
</script>
