<template>
  <div class="tw-w-full">
    <v-card
      class="py-12 px-10"
      :class="showColors ? 'tw-mb-10' : 'tw-mb-60'"
      :loading="isLoading"
    >
      <v-btn
        class="-tw-mt-6 tw-mb-6 -tw-ml-4"
        icon="mdi-arrow-left"
        flat
        @click="$router.push('/materials')"
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
              placeholder="material-slug"
              :error-messages="slug.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
            <span v-if="!slug.value.value && name.value.value" class="tw-text-sm tw-text-gray-500">
              Generated default slug: {{ slugPlaceholder }}
            </span>
          </div>
        </div>
        <template v-if="props.new || props.edit">
          <v-divider class="border-opacity-100 tw-my-6"></v-divider>
          <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
            <div class="tw-w-full lg:tw-w-3/12">
              <h3 class="tw-text-base tw-font-semibold tw-mt-1">Image</h3>
              <span class="tw-text-sm tw-text-gray-500 tw-mt-1">
              </span>
            </div>
            <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-8/12 xl:tw-w-5/12">
              <v-file-input
                label="Material Image"
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
                    <h3 class="tw-text-base tw-font-semibold tw-mt-1">Image Url Link</h3>
                    <span class="tw-text-sm tw-text-gray-700 tw-mt-1">
                      Preferrably, you need to upload a new image. In case that the image is already present in the AWS S3 Bucket,
                      you can copy the path of the image along with our cloudfront domain (https://assets.theoutdoorplus.com/). E.g. If the image is uploaded to "materials/copper.png",
                      the link is going to be: https://assets.theoutdoorplus.com/materials/copper.png
                    </span>
                    <br>
                    <br>
                    <span class="tw-text-sm tw-text-gray-700 tw-mt-1">
                      <b>If Link is from dropbox (Not recommended): </b>In order to make the link work, when you click on the button "copy link" from the dropbox,
                      you'll get a link that ends with <span class="tw-italic tw-font-semibold">?dl=0</span> . You'll need to replace
                      that with <span class="tw-italic tw-font-semibold">?raw=1</span>
                    </span>
                    <v-textarea
                      v-model="imageUrl.value.value"
                      class="mt-6"
                      variant="outlined"
                      density="compact"
                      name="Image"
                      placeholder="https://link-to-dropbox.com?raw=1"
                      :error-messages="imageUrl.errorMessage.value"
                      :readonly="readonly"
                    >
                    </v-textarea>
                  </v-expansion-panel-text>
                </v-expansion-panel>
              </v-expansion-panels>
            </div>
          </div>
        </template>
        <template v-if="(props.readonly && props.material?.image_url && (props?.material?.color?.length || 0 <= 0)) || props.edit">
          <v-divider class="border-opacity-100 tw-my-6"></v-divider>
          <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
            <div class="tw-w-full lg:tw-w-3/12">
              <h3 class="tw-text-base tw-font-semibold tw-mt-1">Material Preview</h3>
              <span v-if="!props.readonly" class="tw-text-sm tw-text-gray-500 tw-mt-1">
              </span>
            </div>
            <div class="tw-w-full tw-mt-3 tw-mb-10 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
              <v-img
                width="250"
                :lazy-src="imageUrl.value.value || material?.image_url || ''"
                :src="imageUrl.value.value || material?.image_url || ''"
              >
                <template v-slot:placeholder>
                  <div class="d-flex align-center justify-center fill-height">
                    <v-progress-circular
                      color="grey-lighten-4"
                      indeterminate
                    ></v-progress-circular>
                  </div>
                </template>
              </v-img>
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
          >Submit</v-btn>
        </div>
      </form>
    </v-card>
    <v-card
      v-if="showColors"
      class="py-12 px-10 tw-mb-32"
      :loading="isLoading"
    >
      <div class="tw-w-full">
        <h1 class="tw-text-base tw-font-semibold">Colors</h1>
        <div class="tw-text-sm">Preview list of colors associated to {{ material?.name }}</div>
      </div>
      <v-divider class="border-opacity-100 tw-my-6"></v-divider>
      <div class="tw-w-full tw-flex tw-flex-wrap tw-mx-auto tw-justify-center">
        <div
          v-for="(color, i) in material?.color"
          :key="i"
          class="tw-w-2/12 tw-flex tw-flex-col tw-justify-center tw-items-center tw-py-6"
        >
          <v-img
            width="160"
            :lazy-src="color?.image_url || ''"
            :src="color?.image_url || ''"
          >
            <template v-slot:placeholder>
              <div class="d-flex align-center justify-center fill-height">
                <v-progress-circular
                  color="grey-lighten-4"
                  indeterminate
                ></v-progress-circular>
              </div>
            </template>
          </v-img>
          <span class="tw-text-lg tw-font-bold tw-mt-3">{{ color?.name || '' }}</span>
          <span class="tw-text-base tw-uppercase -tw-mt-1">-{{ color?.slug || '' }}</span>
        </div>
      </div>
    </v-card>
  </div>
</template>
<script lang="ts" setup>
import * as yup from 'yup';
import { toTypedSchema } from '@vee-validate/yup';
import { useField, useForm } from 'vee-validate';
import { Ref, ref, onMounted, watch, computed } from 'vue';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { useRouter } from 'vue-router';
import { useAttributeValue } from '@/utils';
import { parse } from 'path';

/**
 *
 * Defining Interfaces
 *
 */

interface Color {
  id?: number;
  name?: string;
  image_url?: string;
  slug?: string;
}

interface Material {
  id?: number;
  name: string;
  slug?: string;
  image_url?: string | null;
  color?: Color[];
}

interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  material?: Material | null;
  loading?: boolean;
}

/**
 *
 * General Definitions
 *
 */

 const router = useRouter();
 const isLoading = ref(false);
 const { notify } = useNotification();
 const { createAttributeValue } = useAttributeValue();

 const props = withDefaults(defineProps<Props>(), {
  new: false,
  edit: false,
  readonly: false,
  material: null,
  loading: false,
 });
watch(
  () => props.loading,
  (value) => {
    isLoading.value = value;
  }
);

const title = computed(() => {
  if (props.new) return 'Create Material';
  if (props.edit) return 'Edit Material';
  if (props.readonly) return 'View Material';
  return 'Material Form';
});

const subtitle = computed(() => {
  if (props.new) return 'Fill out the information below to create a material';
  if (props.edit) return 'Use the form below to edit the material';
  if (props.readonly) return 'View Material Information';
  return '';
});

const showColors = computed(() => {
  return props.readonly && props.material?.color?.length;
})

/**
 *
 * Slug definitions
 *
 */


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

/**
 *
 * Handle Form
 *
 */

const { handleSubmit } = useForm({
  validationSchema: toTypedSchema(
    yup.object({
      name: yup.string().min(2).required(),
      slug: yup.string(),
      image: yup.string(),
    })
  ),
});

const name = useField<string>('name');
const slug = useField<string>('slug');
const imageUrl = useField<string>('image');
const imageFile: Ref<File | null> = ref<File | null>(null);
const imagePreviewURL: Ref<string | null> = ref<string | null>(null);
const oldImageUrl: Ref<string> = ref<string>('');

const fillMaterialInformation = () => {
  if (props.edit || props.readonly) {
    name.value.value = props.material?.name || '';
    slug.value.value = props.material?.slug || '';
    imageUrl.value.value = props.material?.image_url || '';
  }
}

onMounted(() => {
  fillMaterialInformation();
});
watch(
  () => props.material,
  () => {
    fillMaterialInformation();
  },
  { deep: true }
);

/**
 *
 * Handle Data
 *
 */

const handleCreate = async (form: Material) => {
  try {
    isLoading.value = true;
    const { data: material , error } = await supabase
      .from('material')
      .insert(form)
      .select();
    if (error) throw error;
    if (material.length) {
      await createAttributeValue('Material', undefined, 'material', material[0].id);
      router.push(`/materials/${material[0].id}`);
    }
    notify({
      title: 'Material created successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error creating material.',
      text: e?.message || 'An error occurred trying to create a material. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const handleUpdate = async (form: Material) => {
  try {
    isLoading.value = true;
    const { data: mtrl, error } = await supabase
      .from('material')
      .update(form)
      .eq('id', props?.material?.id || 0)
      .select();
    if (error) throw error;
    if(mtrl.length) {
      console.log('BEFORE', imageUrl.value.value);
      name.value.value = mtrl[0].name;
      slug.value.value = mtrl[0].slug;
      console.log('mtrl', mtrl[0].image_url);
      imageUrl.value.value = mtrl[0].image_url;
      console.log('AFTER', imageUrl.value.value);
    }
    notify({
      title: 'Material updated successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);

    notify({
      title: 'Error updating material.',
      text: e?.message || 'An error ocurred trying to update the material. Please contact TOP support.',
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

const handleUpload = async() => {
  const formData = new FormData();
  formData.append('file', imageFile.value as File);

  let path = '/materials/';
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
        title: 'Material image uploaded successfully',
        text: data?.message || 'file uploaded successfully',
        type: 'success',
        duration: 6000,
      });
      imagePreviewURL.value = null;
      clearImage();
      return data.fileUrl;
    }
    return '';
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error updating material image.',
      text: e?.message || 'An error ocurred trying to update the material image. Please contact TOP support.',
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
        title: 'Old material image deleted successfully',
        text: data?.message || 'Previous file deleted.',
        type: 'success',
        duration: 6000,
      });
    }
  } catch (e: any) {
    console.error(e);
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
  if (!form.slug) form.slug = slugify(form.name);
  form.image_url = form.image;
  delete form.image;
  if (props.new) {
    const imgUrl = await handleUpload();
    if (imgUrl) form.image_url = imgUrl;
    await handleCreate(form);
  } else if (props.edit) {
    if (imageFile.value) {
      oldImageUrl.value = imageUrl.value.value;
      const imgUrl = await handleUpload();
      if (imgUrl) {
        form.image_url = imgUrl
        if (isImageUrlFromCloudFront(oldImageUrl.value)) {
          await deleteFile(oldImageUrl.value);
        }
      }
    }
    await handleUpdate(form);
  }
})

</script>
