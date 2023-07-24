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
      ></v-text-field>  
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
          <v-toolbar-title>Users</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-btn color="white" dark to="/users/new" exact>New User <v-icon icon="mdi-plus" class="ml-2"></v-icon></v-btn>
        </v-toolbar>
        <v-dialog v-model="dialogDelete" max-width="600px">
          <v-card class="pt-4 pb-3" :loading="deleteLoading">
            <v-card-title class="text-h5">Are you sure you want to delete this user?</v-card-title>
            <v-card-text>
              The user <strong>{{ itemToDelete?.first_name }}</strong> with id
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
      <template v-slot:item.actions="{ item }">
        <v-btn 
          size="small"
          icon="mdi-eye"
          variant="text"
          :to="`/users/${item.raw.id}`"
        ></v-btn>
        <v-btn 
          v-if="isActionEnabled((item.raw as Columns))"
          size="small"
          icon="mdi-pencil"
          variant="text"
          :to="`/users/edit/${item.raw.id}`"
        ></v-btn>
        <v-btn
          v-if="isActionEnabled((item.raw as Columns))"
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
  last_name: string | null | undefined;
  first_name: string | null | undefined;
  role: string;
  company: string | null | undefined;
  email: string;
}

const store = useAppStore();
const userStore = useUserStore();

onMounted(() => {
  store.pageTitle = 'Users';
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
    const { error } = await supabase.from('users').delete()
      .eq('id', itemToDelete?.value?.id);
    if (error) throw error;
    notify({
      type: 'success',
      title: 'User deleted successfully',
      duration: 5000,
    });
    data.serverItems = data.serverItems.filter((item) => item.id !== itemToDelete?.value?.id);
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error deleting user.',
      text: e?.message || 'An error ocurred trying to delte user. Please contact TOP Support.',
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
  { title: 'First Name', align: 'end', key: 'first_name' },
  { title: 'Last Name', align: 'end', key: 'last_name' },
  { title: 'Email', align: 'end', key: 'email' },
  { title: 'Company', align: 'end', key: 'company' },
  { title: 'Role', align: 'end', key: 'role' },
  { title: 'Actions', key: 'actions', sortable: false },
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

const isActionEnabled = (item: Columns) => {
  const currentUserId = userStore?.currentUser?.id;
  return item.role !== 'ADMIN' && item.id !== currentUserId;
}

const onEnterSearch = () => {
  search.value = String(Date.now());
}

const loadItems = async ({ page, itemsPerPage, sortBy }: { page: number, itemsPerPage: number, sortBy: any }) => {
  try {
    loading.value = true;
    const { from, to } = usePagination(page - 1, itemsPerPage);
    if (searchFilter.value) {
      const { data: users, error } = await supabase
        .rpc('search_users', {
          search_term: searchFilter.value,
          sort_term: sortBy?.[0]?.key || 'first_name',
          sort_order: sortBy?.[0]?.order === 'desc' ? 'DESC' : 'ASC',
          from_limit: from,
          to_limit: to,
        });
      if (error) throw error;
      data.serverItems = users;
      if (users.length)
        totalItems.value = users[0]?.count || 0;
      else
        totalItems.value = 0;
    } else {
      const { data: users, error, count } = await supabase
        .from('users')
        .select('*', { count: 'exact' })
        .order(sortBy?.[0]?.key || 'first_name', { ascending: sortBy?.[0]?.order === 'desc' ? false : true })
        .range(from, to);
      if (error) throw error;
      data.serverItems = users || [];
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