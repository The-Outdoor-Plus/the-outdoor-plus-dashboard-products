<template>
  <div class="tw-px-6 tw-flex tw-justify-center tw-w-full">
    <div class="tw-w-full tw-mt-12 sm:tw-w-10/12 md:tw-w-9/12 lg:tw-w-8/12 xl:tw-w-6/12 tw-rounded-md tw-bg-white tw-px-4 tw-py-6 tw-shadow-md">
      <div></div>
      <form @submit.prevent="submit">
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">Mention the missing/incorrect content.</div>
          <v-text-field
            v-model="missingTitle.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="missingTitle"
            placeholder="Mention what is the missing content"
            :error-messages="missingTitle.errorMessage.value"
          ></v-text-field>
        </div>
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">Describe the missing/incorrect content.</div>
          <div class="tw-text-sm tw-text-gray-500">Please be as detailed as possible. What's the missing/incorrect content, where it is from and what product/variation belongs to. (Or if its a whole variation missing)</div>
          <v-textarea
            v-model="missingDescription.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="missingDescription"
            placeholder="Describe the missing content"
            :error-messages="missingDescription.errorMessage.value"
          ></v-textarea>
        </div>
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">What's the missing content?</div>
          <v-autocomplete
            v-model="missingType.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="missingType"
            item-value="id"
            item-title="name"
            :items="missingTypes"
            :error-messages="missingType.errorMessage.value"
          ></v-autocomplete>
        </div>
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">What product/variation is related to the content?</div>
          <div class="tw-text-sm tw-text-gray-500">Type the product name where the content is missing or the information is incorrect.</div>
          <v-text-field
            v-model="missingProduct.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="missingProduct"
            placeholder="Type the product name where the content is missing or the information is incorrect."
            :error-messages="missingProduct.errorMessage.value"
          ></v-text-field>
        </div>
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">URL</div>
          <div class="tw-text-sm tw-text-gray-500">If possible, provide the URL of where the content is missing or the information is incorrect.</div>
          <v-text-field
            v-model="missingUrl.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="missingURL"
            placeholder="URL of where the content is missing or information is incorrect."
            :error-messages="missingUrl.errorMessage.value"
          ></v-text-field>
        </div>
        <v-btn
          color="primary"
          type="submit"
        >
          Send report
        </v-btn>
      </form>
    </div>
  </div>
</template>
<script lang="ts" setup>
import { useField, useForm } from 'vee-validate';
import { toTypedSchema } from '@vee-validate/yup';
import * as yup from 'yup';
import { ref, computed } from 'vue';
import { useMutation } from '@vue/apollo-composable';
import { useUserStore } from '@/store/user';
import { useNotification } from '@kyvg/vue3-notification';
import gql from 'graphql-tag';
import * as Sentry from '@sentry/vue';

const missingTypes = ref([
  {
    name: 'Specification Sheets',
    id: 'Specification Sheets',
  },
  {
    name: 'Manuals',
    id: 'Manuals',
  },
  {
    name: 'Warranty Information',
    id: 'Warranty Information',
  },
  {
    name: 'Product variation',
    id: 'Product variation',
  },
  {
    name: 'Product',
    id: 'Product'
  },
  {
    name: 'Image(s)',
    id: 'Image(s)'
  },
  {
    name: 'Product/Variation Information',
    id: 'Product/Variation Information',
  },
  {
    name: 'Product/Variation Dimension',
    id: 'Product/Variation Dimension',
  },
  {
    name: 'Product/Variation Pricing',
    id: 'Product/Variation Pricing',
  },
  {
    name: 'Other',
    id: 'Other'
  }
])

const { notify } = useNotification();
const userStore = useUserStore();
const formValidation = toTypedSchema(
  yup.object({
    name: yup.string().min(2).required(),
    text1__1: yup.string().required(),
    text0__1: yup.string(),
    text4__1: yup.string(),
    text9__1: yup.string(),
  }),
)
const initialValues = {
  name: '',
  text1__1: '',
  text0__1: '',
  text4__1: '',
  text9__1: 'Product/Variation Information',
}

const { handleSubmit, resetForm } = useForm({
  validationSchema: formValidation,
  initialValues: initialValues
});

const missingTitle = useField<string>('name');
const missingDescription = useField<string>('text1__1');
const missingType = useField<string>('text9__1');
const missingProduct = useField<string>('text4__1');
const missingUrl = useField<string>('text0__1');

const columnValues = computed(() => {
  const columns = {
    // From
    "text__1": `${userStore.currentUser?.user_metadata?.first_name} ${userStore.currentUser?.user_metadata?.last_name}`,
    // Email
    "text7__1": userStore.currentUser?.email,
    // Description
    "text1__1": missingDescription.value.value,
    // Missing Type
    "text9__1": missingType.value.value,
    // Missing Product
    "text4__1": missingType.value.value,
    // Missing URL
    "text0__1": missingType.value.value,
  }

  return JSON.stringify(columns);
});

const { mutate: createItem, onDone: onCreateItemDone, onError: onCreateItemError } = useMutation(gql`
  mutation createItem ($groupId: String!, $itemName: String!, $columnValues: JSON!) {
    create_item (board_id: 6448104580, group_id: $groupId, item_name: $itemName, column_values: $columnValues) {
      id
    }
  }
`, () => ({
  variables: {
    groupId: 'topics',
    itemName: missingTitle.value.value,
    columnValues: columnValues.value,
  }
}));

onCreateItemDone((result) => {
  console.log('Item Created', result.data);
  notify({
    title: `Thanks for submitting your report!`,
    text: 'Your submission helps us maintain up to date information.',
    type: 'info',
    duration: 6000,
  });
  resetForm();
});

onCreateItemError((err) => {
  notify({
    title: `Error sending report.`,
    text: err?.message || `An error sending the report. Don't worry, errors in this page are being captured and set to us. Call TOP Support for further assitance`, type: 'error',
    duration: 6000,
  });
  Sentry.captureException(err);
});

const submit = handleSubmit(async (values) => {
  createItem();
});
</script>
