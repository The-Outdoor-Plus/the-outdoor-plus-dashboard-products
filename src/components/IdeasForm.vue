<template>
  <div class="tw-px-6 tw-flex tw-justify-center tw-w-full">
    <div class="tw-w-full tw-mt-12 sm:tw-w-10/12 md:tw-w-9/12 lg:tw-w-8/12 xl:tw-w-6/12 tw-rounded-md tw-bg-white tw-px-4 tw-py-6 tw-shadow-md">
      <div></div>
      <form @submit.prevent="submit">
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">Briefly mention your idea.</div>
          <v-text-field
            v-model="ideasTitle.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="ideasTitle"
            placeholder="Briefly mention your idea."
            :error-messages="ideasTitle.errorMessage.value"
          ></v-text-field>
        </div>
        <div class="tw-w-full">
          <div class="tw-text-base tw-font-semibold">Describe your idea.</div>
          <div class="tw-text-sm tw-text-gray-500">Please be as detailed as possible!</div>
          <v-textarea
            v-model="ideasDescription.value.value"
            class="tw-w-full"
            variant="outlined"
            density="compact"
            name="ideasDescription"
            placeholder="Describe your awesome idea to us."
            :error-messages="ideasDescription.errorMessage.value"
          ></v-textarea>
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

const { notify } = useNotification();
const userStore = useUserStore();
const formValidation = toTypedSchema(
  yup.object({
    name: yup.string().min(2).required(),
    text6__1: yup.string().required(),
  }),
)
const initialValues = {
  name: '',
  text6__1: '',
}

const { handleSubmit, resetForm } = useForm({
  validationSchema: formValidation,
  initialValues: initialValues
});

const ideasTitle = useField<string>('name');
const ideasDescription = useField<string>('text6__1');

const columnValues = computed(() => {
  const columns = {
    // From
    "text__1": `${userStore.currentUser?.user_metadata?.first_name} ${userStore.currentUser?.user_metadata?.last_name}`,
    // Email
    "text2__1": userStore.currentUser?.email,
    // Description
    "text6__1": ideasDescription.value.value,
  }

  return JSON.stringify(columns);
});

const { mutate: createItem, onDone: onCreateItemDone, onError: onCreateItemError } = useMutation(gql`
  mutation createItem ($groupId: String!, $itemName: String!, $columnValues: JSON!) {
    create_item (board_id: 6448102148, group_id: $groupId, item_name: $itemName, column_values: $columnValues) {
      id
    }
  }
`, () => ({
  variables: {
    groupId: 'topics',
    itemName: ideasTitle.value.value,
    columnValues: columnValues.value,
  }
}));

onCreateItemDone((result) => {
  console.log('Item Created', result.data);
  notify({
    title: `Idea sent!`,
    text: 'Thanks for submitting your idea! We\'ll review it and get back to you for any updates.',
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

