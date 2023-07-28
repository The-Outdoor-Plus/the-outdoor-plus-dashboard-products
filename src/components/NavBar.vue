<template>
  <v-navigation-drawer
    v-model="drawer"
    class="tw-max-h-[95vh] !tw-fixed"
    :rail="store.rail"
    permanent
    @click="store.rail = false"
  >
    <v-list density="compact" nav>
      <template v-for="(item, i) in navItems" :key="i">
        <template v-if="item.children.length">
          <v-list-group
            v-if="isLinkAllowed(item.roles)"
            :value="item.label"
          >
            <template v-slot:activator="{ props }">
              <v-list-item
                v-bind="props"
                exact
                :prepend-icon="item.icon"
                :title="item.label"
              ></v-list-item>
            </template>
            <template
              v-for="(child, i) in item.children"
              :key="i"
            >
              <v-list-item
                v-if="isLinkAllowed(child.roles)"
                exact
                :title="child.label"
                :value="child.label"
                :to="child.link"
              >
              </v-list-item>
            </template>
            
          </v-list-group>
        </template>
        <template v-else>
          <v-list-item 
            v-if="isLinkAllowed(item.roles)"
            exact
            :prepend-icon="item.icon"
            :title="item.label"
            :value="item.label"
            :to="item.link"
          ></v-list-item>
        </template>
      </template>
    </v-list>

    <v-divider></v-divider>

    <template v-slot:append>
      <v-divider></v-divider>
      <v-list-item
        class="mb-3 mt-2"
        :prepend-avatar="avatar"
        :title="userName"
        :subtitle="userEmail"
        nav
      >
      </v-list-item>
    </template>
    
  </v-navigation-drawer>
</template>

<script setup lang="ts">
import { ref, computed, reactive } from 'vue';
import { useAppStore } from '@/store/app';
import { useUserStore } from '@/store/user';

const store = useAppStore();
const userStore = useUserStore();

const navItems = reactive([
  {
    label: 'Home',
    icon: 'mdi-home',
    link: '/',
    roles: ['USER', 'GUEST', 'DEALER', 'DISTRIBUTOR', 'MANAGER', 'ADMIN'],
    children: [],
  },
  {
    label: 'Products',
    icon: 'mdi-layers-search',
    roles: ['USER', 'GUEST', 'DEALER', 'DISTRIBUTOR', 'MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View Products',
        link: '/products',  
        roles: ['USER', 'GUEST', 'DEALER', 'DISTRIBUTOR', 'MANAGER', 'ADMIN'],
      },
      {
        label: 'Create Product',
        link: '/products/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Categories',
    icon: 'mdi-dots-hexagon',
    roles: ['MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View Categories',
        link: '/categories',  
        roles: ['MANAGER', 'ADMIN'],
      },
      {
        label: 'Create Category',
        link: '/categories/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Collections',
    icon: 'mdi-rhombus-split',
    roles: ['MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View Collections',
        link: '/collections',  
        roles: ['MANAGER', 'ADMIN'],
      },
      {
        label: 'Create Collection',
        link: '/collections/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Product Shapes',
    icon: 'mdi-shape',
    roles: ['MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View product shapes',
        link: '/shapes',  
        roles: ['MANAGER', 'ADMIN'],
      },
      {
        label: 'Create proudct shape',
        link: '/shapes/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Materials',
    icon: 'mdi-hammer-screwdriver',
    roles: ['MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View materials',
        link: '/materials',  
        roles: ['MANAGER', 'ADMIN'],
      },
      {
        label: 'Create material',
        link: '/materials/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Colors / Finishes',
    icon: 'mdi-palette-swatch-variant',
    roles: ['MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View colors',
        link: '/colors',  
        roles: ['MANAGER', 'ADMIN'],
      },
      {
        label: 'Create color',
        link: '/colors/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Ignition Types',
    icon: 'mdi-gas-burner',
    roles: ['MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View ignition types',
        link: '/ignition-types',  
        roles: ['MANAGER', 'ADMIN'],
      },
      {
        label: 'Create ignition type',
        link: '/ignition-types/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Gas Types',
    icon: 'mdi-gas-cylinder',
    roles: ['MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View gas types',
        link: '/gas-types',  
        roles: ['MANAGER', 'ADMIN'],
      },
      {
        label: 'Create gas type',
        link: '/gas-types/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Users',
    icon: 'mdi-account-multiple',
    roles: ['MANAGER', 'ADMIN'],
    children: [
      {
        label: 'View users',
        link: '/users',  
        roles: ['MANAGER', 'ADMIN'],
      },
      {
        label: 'Create user',
        link: '/users/new',
        roles: ['MANAGER', 'ADMIN']
      }
    ]
  },
  {
    label: 'Settings',
    icon: 'mdi-cog',
    roles: ['MANAGER', 'ADMIN'],
    children: [],
  }
]);

const drawer = ref(true);
const userName = computed(() => {
  return `${userStore.currentUser?.user_metadata?.first_name} ${userStore.currentUser?.user_metadata?.last_name}`;
});
const userEmail = computed(() => userStore.currentUser?.email);
const avatar = computed(() => {
  return `https://ui-avatars.com/api/?background=FCB017&color=fff&name=${userStore.currentUser?.user_metadata?.first_name}+${userStore.currentUser?.user_metadata?.last_name}`;
})

const isLinkAllowed = (roles: string[]) => {
  return roles.includes(userStore?.currentUser?.role || '');
}

</script>


