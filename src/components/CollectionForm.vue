<template>
  <div class="tw-w-full">
    <v-card class="py-12 px-10" :loading="isLoading">
      <v-btn
        class="-tw-mt-6 tw-mb-6 -tw-ml-4" 
        icon="mdi-arrow-left" 
        flat
        @click="$router.push('/collections')"
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
              placeholder="collection-slug"
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
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { useRouter } from 'vue-router';

/**
 * 
 * Defining Interfaces
 * 
 */

interface Collection {
  id?: number;
  name: string;
  slug?: string;
}

interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  collection?: Collection | null;
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

 const props = withDefaults(defineProps<Props>(), {
  new: false,
  edit: false,
  readonly: false,
  collection: null,
  loading: false,
 });
watch(
  () => props.loading,
  (value) => {
    isLoading.value = value;
  }
);

const title = computed(() => {
  if (props.new) return 'Create Collection';
  if (props.edit) return 'Edit Collection';
  if (props.readonly) return 'View Collection'; 
  return 'Collection Form';
});

const subtitle = computed(() => {
  if (props.new) return 'Fill out the information below to create a collection';
  if (props.edit) return 'Use the form below to edit the collection';
  if (props.readonly) return 'View Collection Information';
  return '';
});

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
    })
  ),
});

const name = useField<string>('name');
const slug = useField<string>('slug');

const fillCollectionInformation = () => {
  if (props.edit || props.readonly) {
    name.value.value = props.collection?.name || '';
    slug.value.value = props.collection?.slug || '';
  }
}

onMounted(() => {
  fillCollectionInformation();
});
watch(
  () => props.collection,
  () => {
    fillCollectionInformation();
  },
  { deep: true }
);

/**
 * 
 * Handle Data
 * 
 */

const handleCreate = async (values: Collection) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    if (!form.slug) form.slug = slugify(form.name);
    const { data: collection , error } = await supabase
      .from('collection')
      .insert(form)
      .select();
    if (error) throw error;
    if (collection.length) router.push(`/collections/${collection[0].id}`);
    notify({
      title: 'Collection created successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error creating collection',
      text: e?.message || 'An error occurred trying to create a collection. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const handleUpdate = async (values: Collection) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    if (!form.slug) form.slug = slugify(form.name);
    const { data: collection, error } = await supabase
      .from('collection')
      .update(form)
      .eq('id', props?.collection?.id || 0)
      .select();
    if (error) throw error;
    if(collection.length) {
      name.value.value = collection[0].name;
      slug.value.value = collection[0].slug;
    }
    notify({
      title: 'Collection updated successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    
    notify({
      title: 'Error updating collection',
      text: e?.message || 'An error ocurred trying to update the collection. Please contact TOP support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const submit = handleSubmit(async (values) => {
  if (props.new) {
    await handleCreate(values);
  } else if (props.edit) {
    await handleUpdate(values);
  }
})

</script>