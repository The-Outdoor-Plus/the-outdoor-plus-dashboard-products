export default [
  {
      path: '/',
      component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
      children: [
        {
          path: '',
          name: 'Home',
          // route level code-splitting
          // this generates a separate chunk (about.[hash].js) for this route
          // which is lazy-loaded when the route is visited.
          component: () => import(/* webpackChunkName: "home" */ '@/views/Home.vue'),
          meta: { 
            requiresAuth: true, 
            onlyWhenLoggedOut: false,
            roles: ['USER', 'GUEST', 'DEALER', 'DISTRIBUTOR', 'MANAGER', 'ADMIN'],
          }
        },
      ],
    },
    {
      path: '/login',
      component: () => import('@/layouts/login/LoginLayout.vue'),
      children: [
        {
          path: '',
          name: 'Login',
          component: () => import(/* webpackChunkName: "login" */'@/views/Login.vue'),
          meta: { 
            requiresAuth: false, 
            onlyWhenLoggedOut: true, 
            roles: ['USER', 'GUEST', 'DEALER', 'DISTRIBUTOR', 'MANAGER', 'ADMIN'],
          }
        }
      ],
    },
    {
      path: '/users',
      component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
      children: [
        {
          path: '',
          name: 'UsersList',
          component: () => import(/* webpackChunkName: "users-list" */'@/views/users/UserList.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        },
        {
          path: 'new',
          name: 'NewUser',
          component: () => import(/* webpackChunkName: "new-user" */'@/views/users/CreateUser.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          }
        },
        {
          path: 'edit/:id',
          name: 'EditUser',
          component: () => import(/* webpackChunkName: "edit-user" */'@/views/users/EditUser.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        },
        {
          path: ':id',
          name: 'ViewUser',
          component: () => import(/* webpackChunkName: "view-user" */'@/views/users/ViewUser.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        }
      ],
    },
    {
      path: '/gas-types',
      component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
      children: [
        {
          path: '',
          name: 'GasTypeList',
          component: () => import(/* webpackChunkName: "gas-type-list" */'@/views/gas-types/GasTypeList.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        },
        {
          path: 'new',
          name: 'NewGasType',
          component: () => import(/* webpackChunkName: "new-gas-type" */'@/views/gas-types/CreateGasType.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          }
        },
        {
          path: 'edit/:id',
          name: 'EditGasType',
          component: () => import(/* webpackChunkName: "edit-gas-type" */'@/views/gas-types/EditGasType.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        },
        {
          path: ':id',
          name: 'ViewGasType',
          component: () => import(/* webpackChunkName: "view-gas-type" */'@/views/gas-types/ViewGasType.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        }
      ],
    },
    {
      path: '/ignition-types',
      component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
      children: [
        {
          path: '',
          name: 'IgnitionTypeList',
          component: () => import(/* webpackChunkName: "ignition-type-list" */'@/views/ignition-types/IgnitionTypeList.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        },
        {
          path: 'new',
          name: 'NewIgnitionType',
          component: () => import(/* webpackChunkName: "new-ignition-type" */'@/views/ignition-types/CreateIgnitionType.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          }
        },
        {
          path: 'edit/:id',
          name: 'EditIgnitionType',
          component: () => import(/* webpackChunkName: "edit-ignition-type" */'@/views/ignition-types/EditIgnitionType.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        },
        {
          path: ':id',
          name: 'ViewIgnitionType',
          component: () => import(/* webpackChunkName: "view-ignition-type" */'@/views/ignition-types/ViewIgnitionType.vue'),
          meta: {
            requiresAuth: true,
            onlyWhenLoggedOut: false,
            roles: ['MANAGER', 'ADMIN'],
          },
        }
      ],
    }
];
