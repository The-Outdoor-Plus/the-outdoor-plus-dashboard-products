<template>
  <div class="tw-px-6 tw-flex tw-justify-center tw-w-full">
    <div class="tw-w-full tw-mt-12 sm:tw-w-10/12 md:tw-w-9/12 lg:tw-w-8/12 xl:tw-w-6/12 tw-rounded-md tw-bg-white tw-px-4 tw-py-6 tw-shadow-md">
      <div></div>
      <form @submit.prevent="submit">
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">What's the issue?</div>
          <v-text-field
            v-model="issueTitle.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="issueTitle"
            placeholder="Brief description of the issue"
            :error-messages="issueTitle.errorMessage.value"
          ></v-text-field>
        </div>
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">Describe the issue</div>
          <div class="tw-text-sm tw-text-gray-500">Please be as detailed as possible!. Include any steps to reproduce the issue as well.</div>
          <v-textarea
            v-model="issueDescription.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="issueDescription"
            placeholder="Steps to reproduce the issue"
            :error-messages="issueDescription.errorMessage.value"
          ></v-textarea>
        </div>
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">Severity</div>
          <div class="tw-text-sm tw-text-gray-500">Please select the severity of the issue.</div>
          <v-autocomplete
            v-model="severity.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="Severity"
            item-value="id"
            item-title="name"
            :items="severityItems"
            :error-messages="severity.errorMessage.value"
          ></v-autocomplete>
          <div class="tw-text-sm tw-text-gray-500">Low: Something is wrong visually or is not placed correctly, information can be seen but it's not complete.</div>
          <div class="tw-text-sm tw-text-gray-500">Normal: Some products might be taking too much time to load or the information is incorrect, not loading and showing an error, but you can still see other information and navigate through the system.</div>
          <div class="tw-text-sm tw-text-gray-500">High: Some products are not loading completely and you get an error.</div>
          <div class="tw-text-sm tw-text-gray-500 tw-mb-5">Critical: You get an error in the page and make the whole system unusable.</div>
        </div>
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">URL of where the issue happened.</div>
          <div class="tw-text-sm tw-text-gray-500">If possible, please include the URL where you're having the issue.</div>
          <v-text-field
            v-model="url.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="issueURL"
            :error-messages="url.errorMessage.value"
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

const severityItems = ref([
  { name: 'Low', id: 'Low' },
  { name: 'Normal', id: 'Normal' },
  { name: 'High', id: 'High' },
  { name: 'Critical', id: 'Critical' },
])

const { notify } = useNotification();
const userStore = useUserStore();
const formValidation = toTypedSchema(
  yup.object({
    name: yup.string().min(2).required(),
    status_12__1: yup.string().required(),
    text_1__1: yup.string().required(),
    text_2__1: yup.string(),
  }),
)
const initialValues = {
  name: '',
  status_12__1: 'Low',
  text_1__1: '',
  text_2__1: '',
}

const { handleSubmit, resetForm } = useForm({
  validationSchema: formValidation,
  initialValues: initialValues
});

const issueTitle = useField<string>('name');
const issueDescription = useField<string>('text_1__1');
const url = useField<string>('text_2__1');
const severity = useField<number>('status_12__1');

const columnValues = computed(() => {
  const columns = {
    // Severity
    "status_12__1": {
      "label": severity.value.value,
    },
    // From
    "text8__1": `${userStore.currentUser?.user_metadata?.first_name} ${userStore.currentUser?.user_metadata?.last_name}`,
    // Email
    "text__1": userStore.currentUser?.email,
    // Description
    "text_1__1": issueDescription.value.value,
    // URL
    "text_2__1": url.value.value,
  }

  return JSON.stringify(columns);
});

const { mutate: createItem, onDone: onCreateItemDone, onError: onCreateItemError } = useMutation(gql`
  mutation createItem ($groupId: String!, $itemName: String!, $columnValues: JSON!) {
    create_item (board_id: 6448099523, group_id: $groupId, item_name: $itemName, column_values: $columnValues) {
      id
    }
  }
`, () => ({
  variables: {
    groupId: 'topics',
    itemName: issueTitle.value.value,
    columnValues: columnValues.value,
  }
}));

onCreateItemDone((result) => {
  console.log('Item Created', result.data);
  notify({
    title: `Bug report sent.`,
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
