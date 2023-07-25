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
      class="elevation-1"
      item-value="first_name"
      @update:options="loadItems"
    >
      <template v-slot:top>
        <v-toolbar flat compact color="blue-darken-2">
          <v-toolbar-title>Ignition Types</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-btn color="white" dark to="/ignition-types/new" exact>New Ignition Type <v-icon icon="mdi-plus" class="ml-2"></v-icon></v-btn>
        </v-toolbar>
        <v-dialog v-model="dialogDelete" max-width="600px">
          <v-card class="pt-4 pb-3" :loading="deleteLoading">
            <v-card-title class="text-h5">Are you sure you want to delelete this ignition type?</v-card-title>
            <v-card-text>
              Ignition type <strong>{{ itemToDelete?.name }}</strong> will be deleted.
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
      <!-- eslint-disable-next-line vue/valid-v-slot -->
      <template v-slot:item.actions="{ item }">
        <v-btn
          size="small"
          icon="mdi-eye"
          variant="text"
          :to="`/ignition-types/${item.raw.id}`"
        ></v-btn>
        <v-btn
          size="small"
          icon="mdi-pencil"
          variant="text"
          :to="`/ignition-types/edit/${item.raw.id}`"
        ></v-btn>
        <v-btn
          size="small"
          @click="deleteItem((item.raw as Columns))"
          icon="mdi-delete"
          variant="text"
        ></v-btn>
      </template>
    </v-data-table-server>
  </div>
</template>
<script lang="ts" setup>
import { onMounted, reactive, ref, watch, Ref } from 'vue';
import { VDataTableServer } from 'vuetify/lib/labs/components.mjs';
import { supabase } from '@/supabase';
import { useAppStore } from '@/store/app';
import { useNotification } from '@kyvg/vue3-notification';
import { usePagination } from '@/utils';

/**
 * 
 * Defining Interfaces
 * 
 */

interface IgnitionType {
  id: number;
  name: string;
  slug: string;
}

interface Data {
  serverItems: IgnitionType[];
}

interface Columns {
  actions: null | undefined;
  id: number;
  name: string;
  slug: string;
}

interface TableOptions {
  page: number;
  itemsPerPage: number;
  sortBy: any;
}

/**
 * General definitions
 */
onMounted(() => {
  store.pageTitle = 'Ignition Types';
});

const store = useAppStore();
const { notify } = useNotification();

const headers = ref([
  {
    title: 'ID',
    align: 'start',
    sortable: false,
    key: 'id',
  },
  { title: 'Name', align: 'end', key: 'name' },
  { title: 'Slug', align: 'end', key: 'slug' },
  { title: 'Actions', key: 'actions', sortable: false, align: 'end' },
]);
const data: Data = reactive({
  serverItems: [],
});
const itemsPerPage = ref(10);
const totalItems = ref(10);
const loading = ref(true);

/**
 * 
 * Dialog Delete Section
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
    const { error } = await supabase.from('ignition').delete()
      .eq('id', itemToDelete?.value?.id);
    if (error) throw error;
    notify({
      type: 'success',
      title: 'Ignition Type deleted successfully',
      duration: 6000,
    });
    data.serverItems = data.serverItems.filter((item) => item.id !== itemToDelete?.value?.id);
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error deleting ignition type.',
      text: e?.message || 'An error ocurred trying to delete ignition type. Please contact TOP Support.',
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
  if(!searchValue) {
    search.value = String(Date.now());
  }
});

/**
 * 
 * List Data
 * 
 */
const loadItems = async ({ page, itemsPerPage, sortBy }: TableOptions) => {
  try {
    loading.value = true;
    const { from, to } = usePagination(page -1, itemsPerPage);
    if (searchFilter.value) {
      const { data: ignitionTypes, error } = await supabase
        .rpc('search_ignition_types', {
          search_term: searchFilter.value,
          sort_term: sortBy?.[0]?.key || 'name',
          sort_order: sortBy?.[0]?.order === 'desc' ? 'DESC' : 'ASC',
          from_limit: from,
          to_limit: to,
        });
      if (error) throw error;
      data.serverItems = ignitionTypes;
      totalItems.value = ignitionTypes?.[0]?.count || 0;
    } else {
      const { data: ignitionTypes, error, count } = await supabase
        .from('ignition')
        .select('*', { count: 'exact' })
        .order(sortBy?.[0]?.key || 'name', {
          ascending: sortBy?.[0]?.order === 'desc' ? false : true
        })
        .range(from, to);
      if (error) throw error;
      data.serverItems = ignitionTypes || [];
      totalItems.value = count || 0;
    }
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error loading ignition types.',
      text: e?.message || 'An error ocurred trying to load ignition types. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
}
</script>