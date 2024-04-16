<template>
  <div class="tw-w-full">
    <!-- <v-text-field
        v-model="searchFilter"
        class="tw-mb-10"
        append-icon="mdi-magnify"
        label="Search"
        single-line
        hide-details
        variant="solo"
        density="comfortable"
        @keyup.enter="onEnterSearch"
      ></v-text-field>   -->
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
          <v-toolbar-title>Companies</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-btn color="white" dark to="/companies/new" exact>New Company <v-icon icon="mdi-plus" class="ml-2"></v-icon></v-btn>
        </v-toolbar>
        <v-dialog v-model="dialogDelete" max-width="600px">
          <v-card class="pt-4 pb-3" :loading="deleteLoading">
            <v-card-title class="text-h5">Are you sure you want to delete this company?</v-card-title>
            <v-card-text>
              The company <strong>{{ itemToDelete?.name }}</strong> with id
              {{ itemToDelete?.id }} will be will be deleted.
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
      <template v-slot:item.image="{ item }">
        <div class="tw-flex tw-justify-center tw-items-center tw-my-2">
          <v-img
            :width="75"
            :src="item.raw.logo_url"
          ></v-img>
        </div>
      </template>
      <!-- eslint-disable-next-line vue/valid-v-slot -->
      <template v-slot:item.actions="{ item }">
        <v-btn
          size="small"
          icon="mdi-eye"
          variant="text"
          :to="`/companies/${item.raw.id}`"
        ></v-btn>
        <v-btn
          size="small"
          icon="mdi-pencil"
          variant="text"
          :to="`/companies/edit/${item.raw.id}`"
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
import { onMounted, reactive, ref, watch } from 'vue';
import { VDataTableServer } from 'vuetify/lib/labs/components.mjs';
import { supabase } from '@/supabase';
import { usePagination } from '@/utils';
import { useAppStore } from '@/store/app';
import { useUserStore } from '@/store/user';
import { Ref } from 'vue';
import { useNotification } from '@kyvg/vue3-notification';

interface Data {
  serverItems: any[];
}

interface Columns {
  actions: null | undefined;
  id: string;
  name: string | null | undefined;
  role: string | null | undefined;
  slug: string | null | undefined;
  logo_url: string | null | undefined;
}

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Companies';
});

const deleteItem = (item: Columns) => {
  dialogDelete.value = true;
  itemToDelete.value = item;
}

const closeDialogDelete = () => {
  dialogDelete.value = false;
  itemToDelete.value = null;
}

const { notify } = useNotification();

const deleteItemConfirm = async () => {
  try {
    deleteLoading.value = true;
    const { error } = await supabase.from('company').delete()
      .eq('id', itemToDelete?.value?.id);
    if (error) throw error;
    notify({
      type: 'success',
      title: 'Company deleted successfully',
      duration: 5000,
    });
    data.serverItems = data.serverItems.filter((item) => item.id !== itemToDelete?.value?.id);
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error deleting company.',
      text: e?.message || 'An error ocurred trying to delte the company. Please contact TOP Support.',
      type: 'error',
      duration: 5000
    });
  } finally {
    deleteLoading.value = false;
    dialogDelete.value = false;
    itemToDelete.value = null;
  }
}

const headers = ref([
  {
    title: 'ID',
    align: 'start',
    sortable: false,
    key: 'id',
  },
  { title: '', align: 'start', key: 'image' },
  { title: 'Company Name', align: 'start', key: 'name' },
  { title: 'Role', align: 'end', key: 'role' },
  { title: 'Actions', key: 'actions', align: 'end', sortable: false },
]);
const data: Data = reactive({
  serverItems: [],
})


const itemToDelete: Ref<Columns | null> = ref(null);
const deleteLoading = ref(false);
const itemsPerPage = ref(10);
const search = ref('');
const searchFilter = ref('');
const dialogDelete = ref(false);
const loading = ref(true);
const totalItems = ref(0);

watch(dialogDelete, (value) => {
  if (!value) {
    itemToDelete.value = null;
  }
})

const onEnterSearch = () => {
  search.value = String(Date.now());
}

const loadItems = async ({ page, itemsPerPage, sortBy }: { page: number, itemsPerPage: number, sortBy: any }) => {
  try {
    loading.value = true;
    const { from, to } = usePagination(page - 1, itemsPerPage);
    if (searchFilter.value) {
      // const { data: users, error } = await supabase
      //   .rpc('search_users', {
      //     search_term: searchFilter.value,
      //     sort_term: sortBy?.[0]?.key || 'first_name',
      //     sort_order: sortBy?.[0]?.order === 'desc' ? 'DESC' : 'ASC',
      //     from_limit: from,
      //     to_limit: to,
      //   });
      // if (error) throw error;
      // data.serverItems = users;
      // if (users.length)
      //   totalItems.value = users[0]?.count || 0;
      // else
      //   totalItems.value = 0;
    } else {
      const { data: companies, error, count } = await supabase
        .from('company')
        .select('*', { count: 'exact' })
        .order(sortBy?.[0]?.key || 'name', { ascending: sortBy?.[0]?.order === 'desc' ? false : true })
        .range(from, to);
      if (error) throw error;
      data.serverItems = companies || [];
      totalItems.value = count || 0;
    }
    loading.value = false;
  } catch (e) {
    console.error(e);
  } finally {
    loading.value = false;
  }
}
</script>
