<template>
  <div class="tw-w-full">
    <v-text-field
      v-model="searchFilter"
      class="tw-mb-10"
      append-icon="mdi-magnify"
      label="Search"
      single-line
      hide-details
      variant="solo"
      density="comfortable"
      @keyup.enter="onEnterSearch"
    >
    </v-text-field>
    <v-data-table-server
      v-model:items-per-page="itemsPerPage"
      :headers="(headers as [])"
      :search="search"
      :items-length="totalItems"
      :items="data.serverItems"
      :loading="loading"
      class="elevation-1 tw-mb-24"
      item-value="name"
      @update:options="loadItems"
    >
      <template v-slot:top>
        <v-toolbar flat compact color="blue-darken-2">
          <v-toolbar-title>Attributes</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-btn color="white" dark to="/attributes/new" exact>New Attributes<v-icon icon="mdi-plus" class="ml-2"></v-icon></v-btn>
        </v-toolbar>
        <v-dialog v-model="dialogDelete" max-width="600px">
          <v-card>
            <v-card-title class="text-h5">
              Are you sure you want to delete this attribute?
            </v-card-title>
            <v-card-text>
              Attribute <strong>{{ itemToDelete?.name }}</strong> will be deleted.
              This action cannot be reversed. Are you sure you want to continue?
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue-darken-1" variant="text" @click="closeDialogDelete">Cancel</v-btn>
              <v-btn color="red-darken-1" variant="text" @click="deleteItemConfirm">Delete</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </template>
      <template v-slot:item.actions="{ item }">
        <v-btn
          v-if="!item.raw.table_name"
          size="small"
          icon="mdi-eye"
          variant="text"
          :to="`/attributes/${item.raw.id}`"
        ></v-btn>
        <v-btn
          v-if="!item.raw.table_name"
          size="small"
          icon="mdi-pencil"
          variant="text"
          :to="`/attributes/edit/${item.raw.id}`"
        ></v-btn>
        <v-btn
          v-if="item.raw.table_name"
          size="small"
          icon="mdi-pencil"
          variant="text"
          :to="`/${item.raw.slug}s`"
        ></v-btn>
        <v-btn
          v-if="!item.raw.table_name"
          size="small"
          icon="mdi-delete"
          variant="text"
          @click="deleteItem((item.raw as Columns))"
        ></v-btn>
      </template>
    </v-data-table-server>
  </div>
</template>
<script lang="ts" setup>
import { useAppStore } from '@/store/app';
import { VDataTableServer } from 'vuetify/lib/labs/components.mjs';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { Ref } from 'vue';
import { onMounted, ref, reactive, watch } from 'vue';
import { usePagination } from '@/utils';

/**
 *
 * Defining Interfaces
 *
 */

interface Attribute {
  id: number;
  name: string;
  table_name?: string | undefined;
  slug?: string;
}

interface Data {
  serverItems: Attribute[];
}

interface Columns {
  actions: null | undefined;
  id: number;
  name: string;
  table_name: string | undefined;
}

interface TableOptions {
  page: number;
  itemsPerPage: number;
  sortBy: any;
}

/**
 * General Definitions
 */
const store = useAppStore();
const { notify } = useNotification();

onMounted(() => {
  store.pageTitle = 'Attributes';
});

const headers = ref([
  {
    title: 'ID',
    align: 'start',
    sortable: false,
    key: 'id',
  },
  { title: 'Name', align: 'end', key: 'name' },
  { title: 'Actions', key: 'actions', sortable: false, align: 'end' }
]);
const data: Data = reactive({
  serverItems: [],
});
const itemsPerPage = ref(10);
const totalItems = ref(10);
const loading = ref(true);

/**
 *
 * Dialog Delet Section
 *
 **/

const itemToDelete: Ref<Columns | null> = ref(null);
const deleteLoading = ref(false);
const dialogDelete = ref(false);

watch(dialogDelete, (value) => {
  if (!value) {
    itemToDelete.value = null;
  }
});

const deleteItem = (item: Columns) => {
  dialogDelete.value = true;
  itemToDelete.value = item;
}

const closeDialogDelete = () => {
  dialogDelete.value = false;
  itemToDelete.value = null;
}

const deleteItemConfirm = async () => {
  try {
    deleteLoading.value = true;
    const { error } = await supabase.from('attributes').delete()
      .eq('id', itemToDelete?.value?.id);
    if (error) throw error;
    notify({
      type: 'success',
      title: 'Attribute deleted successfully',
      duration: 6000,
    });
    data.serverItems = data.serverItems.filter((item) => item.id !== itemToDelete?.value?.id);
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error deleting material.',
      text: e?.message || 'An error ocurred trying to delete the attribute. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    deleteLoading.value = false;
    dialogDelete.value = false;
    itemToDelete.value = null;
  }
}

/**
 *
 * Search
 *
 */
const search = ref('');
const searchFilter = ref('');

const onEnterSearch = () => {
  search.value = String(Date.now());
}

watch(searchFilter, (searchValue) => {
  if (!searchValue) {
    search.value = String(Date.now());
  }
});

/**
 *
 * List Data
 *
 **/

const loadItems = async ({ page, itemsPerPage, sortBy }: TableOptions) => {
  try {
    loading.value = true;
    const { from, to } = usePagination(page -1, itemsPerPage);
    if (searchFilter.value) {
      const { data: attributes, error } = await supabase
        .rpc('search_attributes', {
          search_term: searchFilter.value,
          sort_term: sortBy?.[0]?.key || 'name',
          sort_order: sortBy?.[0]?.order === 'desc' ? 'DESC' : 'ASC',
          from_limit: from,
          to_limit: to,
        });
      if (error) throw error;
      data.serverItems = attributes;
      totalItems.value = attributes?.[0]?.count || 0;
    } else {
      const { data: attributes, error, count } = await supabase
        .from('attributes')
        .select('*', { count: 'exact' })
        .order(sortBy?.[0]?.key || 'name', {
          ascending: sortBy?.[0]?.order === 'desc' ? false : true
        })
        .range(from, to);
      if (error) throw error;
      data.serverItems = attributes || [];
      totalItems.value = count || 0;
    }
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error loading attributes.',
      text: e?.message || 'An error ocurred trying to load attributes. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
}
</script>

