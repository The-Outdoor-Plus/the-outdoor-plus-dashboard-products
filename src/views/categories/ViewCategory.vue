<template>
  <div>
    <category-form
      :loading="loading"
      :category="category"
      readonly
    ></category-form>
    <div class="tw-w-full tw-my-16 rounded">
      <v-data-table-server
        v-model:items-per-page="itemsPerPage"
        :key="`${route.params.id}`"
        :headers="(headers as [])"
        :items-length="totalItems"
        :items="data.serverItems"
        :loading="isLoading"
        class="elevation-1"
        rounded
        item-value="name"
        @update:options="loadItems"
      >
        <template v-slot:top>
          <v-toolbar flat compact color="green-darken-2" class="rounded-t">
            <v-toolbar-title>Child Categories</v-toolbar-title>
            <v-divider class="mx-4" inset vertical></v-divider>
            <v-spacer></v-spacer>
            <v-btn color="white" dark :to="`/categories/new?parent_id=${route.params.id}`" exact>New Category<v-icon icon="mdi-plus" class="ml-2"></v-icon></v-btn>
          </v-toolbar>
          <v-dialog v-model="dialogDelete" max-width="600px">
            <v-card class="pt-4 pb-3" :loading="deleteLoading">
              <v-card-title class="text-h5">Are you sure you want to delelete this category?</v-card-title>
              <v-card-text>
                Category <strong>{{ itemToDelete?.name }}</strong> will be deleted.
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
            :to="`/categories/${item.raw.id}`"
          ></v-btn>
          <v-btn
            size="small"
            icon="mdi-pencil"
            variant="text"
            :to="`/categories/edit/${item.raw.id}`"
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
  </div>
</template>
<script lang="ts" setup>
import CategoryForm from '@/components/CategoryForm.vue';
import { VDataTableServer } from 'vuetify/lib/labs/components.mjs';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, reactive, ref, watch, Ref } from 'vue';
import { useRoute } from 'vue-router';
import { usePagination } from '@/utils';

interface Category {
  id?: number;
  name: string;
  slug?: string;
  parent_id?: number;
}

interface Data {
  serverItems: Category[];
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

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const category: Ref<Category> = ref<Category>({
  id: 0,
  name: '',
  slug: '',
});

const loadData = async () => {
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('category')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) category.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving category.',
      text: e?.message || 'An error ocurred trying to retrieve category. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
}

onMounted(async () => {
  store.pageTitle = 'Category - View';
  await loadData();
});

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
const itemsPerPage = ref(100);
const totalItems = ref(100);
const isLoading = ref(true);

/**
 * Dialog Delete Section
 */

const itemToDelete: Ref<Columns | null> = ref(null);
const deleteLoading = ref(false);
const dialogDelete = ref(false);


watch(dialogDelete, (value) => {
  if (!value) {
    itemToDelete.value = null;
  }
});
watch(route, async (value) => {
  if (route.params.id)
    await loadData();
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
    const { error } = await supabase.from('category').delete()
      .eq('id', itemToDelete?.value?.id);
    if (error) throw error;
    notify({
      type: 'success',
      title: 'Category deleted successfully',
      duration: 6000,
    });
    data.serverItems = data.serverItems.filter((item) => item.id !== itemToDelete?.value?.id);
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error deleting category.',
      text: e?.message || 'An error ocurred trying to delete category. Please contact TOP Support.',
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
 * List Data
 * 
 */
const loadItems = async ({ page, itemsPerPage, sortBy }: TableOptions) => {
  try {
    isLoading.value = true;
    const { from, to } = usePagination(page -1, itemsPerPage);
    const { data: categories, error, count } = await supabase
      .from('category')
      .select('*', { count: 'exact' })
      .eq(`parent_id`, route.params.id)
      .order(sortBy?.[0]?.key || 'name', {
        ascending: sortBy?.[0]?.order === 'desc' ? false : true
      })
      .range(from, to);
    if (error) throw error;
    data.serverItems = categories || [];
    totalItems.value = count || 0;
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error loading categories.',
      text: e?.message || 'An error ocurred trying to load categories. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

</script>