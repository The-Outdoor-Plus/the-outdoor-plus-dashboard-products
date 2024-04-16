<template>
  <div class="tw-flex tw-flex-col tw-items-center">
    <div class="tw-flex tw-w-full tw-justify-center tw-items-center sm:tw-w-10/12 md:tw-w-9/12 lg:tw-w-8/12 xl:tw-w-6/12">
      <v-btn
        v-if="currentItem.id"
        icon="mdi-arrow-left"
        variant="text"
        class="tw-mr-6 tw-mt-0.5"
        @click="selectItem({})"
      ></v-btn>
      <h2 class="tw-text-center tw-text-3xl tw-font-semibold">{{ currentTitle }}</h2>
    </div>
    <div class="tw-text-center"></div>

    <div v-show="!currentItem.id" class="tw-full tw-flex tw-justify-center tw-flex-wrap tw-mt-16 tw-px-12">
      <div
        v-for="(item, key) in items"
        :key="key"
        class="tw-w-3/12 tw-px-8"
      >
        <div
          class="tw-px-5 tw-py-10 tw-border tw-border-gray-500 hover:tw-border-gray-300 tw-rounded-md tw-flex tw-flex-col tw-justify-center tw-items-center tw-transition-all hover:tw-cursor-pointer hover:tw-bg-white tw-h-full"
          @click="selectItem(item)"
        >
          <v-icon :icon="item.icon" size="x-large"></v-icon>
          <div class="tw-text-lg tw-mt-3 tw-text-center">{{ item.name }}</div>
          <div class="tw-text-center tw-text-sm tw-mt-3">{{ item.description }}</div>
        </div>
      </div>
    </div>
    <component v-show="currentItem.id" :is="currentItem.component"></component>
  </div>
</template>
<script lang="ts" setup>
import { ref } from 'vue';
import BugReportForm from '@/components/BugReportForm.vue';
import IdeasForm from '@/components/IdeasForm.vue';
import MissingContentForm from '@/components/MissingContentForm.vue';

interface Item {
  id?: string;
  icon?: string;
  name?: string;
  description?: string;
  component?: any;
}

const currentTitle = ref('Explore Popular Topics');

const items = ref<Item[]>([
  {
    id: 'missing-content',
    icon: 'mdi-file-alert',
    name: 'Missing Content / Incorrect Information',
    component: MissingContentForm,
    description: 'Share with us if you can\'t find any product, photo, specification sheet or similar.',
  },
  {
    id: 'bug-report',
    icon: 'mdi-bug',
    name: 'Report a Issue / Bug',
    component: BugReportForm,
    description: 'Report any issue, bug or problem with BlazeCraft.',
  },
  {
    id: 'request-feature',
    icon: 'mdi-lightbulb-outline',
    name: 'Share your ideas / Request Feature',
    component: IdeasForm,
    description: 'Share with us any idea or feature that you would like to see implemented.',
  },
]);

const currentItem = ref<Item>({});

const selectItem = (item: Item) => {
  currentItem.value = item;
  currentTitle.value = item?.name ?? 'Explore Popular Topics';
}
</script>
