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
          roles: ['GROUP', 'LANDSCAPE', 'INTERNET', 'ECOMMERCE', 'USER', 'GUEST', 'DEALER', 'DISTRIBUTOR', 'MASTER_DISTRIBUTOR', 'MANAGER', 'ADMIN'],
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
          roles: ['GROUP', 'LANDSCAPE', 'INTERNET', 'ECOMMERCE', 'USER', 'GUEST', 'DEALER', 'DISTRIBUTOR', 'MASTER_DISTRIBUTOR', 'MANAGER', 'ADMIN'],
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
  },
  {
    path: '/materials',
    component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
    children: [
      {
        path: '',
        name: 'MaterialsList',
        component: () => import(/* webpackChunkName: "materials-list" */'@/views/materials/MaterialsList.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: 'new',
        name: 'NewMaterial',
        component: () => import(/* webpackChunkName: "new-material" */'@/views/materials/CreateMaterials.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        }
      },
      {
        path: 'edit/:id',
        name: 'EditMaterial',
        component: () => import(/* webpackChunkName: "edit-material" */'@/views/materials/EditMaterials.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: ':id',
        name: 'ViewMaterial',
        component: () => import(/* webpackChunkName: "view-material" */'@/views/materials/ViewMaterials.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      }
    ],
  },
  {
    path: '/colors',
    component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
    children: [
      {
        path: '',
        name: 'ColorsList',
        component: () => import(/* webpackChunkName: "colors-list" */'@/views/colors/ColorsList.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: 'new',
        name: 'NewColor',
        component: () => import(/* webpackChunkName: "new-color" */'@/views/colors/CreateColor.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        }
      },
      {
        path: 'edit/:id',
        name: 'EditColor',
        component: () => import(/* webpackChunkName: "edit-color" */'@/views/colors/EditColor.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: ':id',
        name: 'ViewColor',
        component: () => import(/* webpackChunkName: "view-color" */'@/views/colors/ViewColor.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      }
    ],
  },
  {
    path: '/shapes',
    component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
    children: [
      {
        path: '',
        name: 'ShapeList',
        component: () => import(/* webpackChunkName: "shape-list" */'@/views/shapes/ShapeList.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: 'new',
        name: 'NewShape',
        component: () => import(/* webpackChunkName: "new-shape" */'@/views/shapes/CreateShape.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        }
      },
      {
        path: 'edit/:id',
        name: 'EditShape',
        component: () => import(/* webpackChunkName: "edit-shape" */'@/views/shapes/EditShape.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: ':id',
        name: 'ViewShape',
        component: () => import(/* webpackChunkName: "view-shape" */'@/views/shapes/ViewShape.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      }
    ],
  },
  {
    path: '/collections',
    component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
    children: [
      {
        path: '',
        name: 'CollectionList',
        component: () => import(/* webpackChunkName: "collection-list" */'@/views/collections/CollectionList.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: 'new',
        name: 'NewCollection',
        component: () => import(/* webpackChunkName: "new-collection" */'@/views/collections/CreateCollection.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        }
      },
      {
        path: 'edit/:id',
        name: 'EditCollection',
        component: () => import(/* webpackChunkName: "edit-collection" */'@/views/collections/EditCollection.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: ':id',
        name: 'ViewCollection',
        component: () => import(/* webpackChunkName: "view-collection" */'@/views/collections/ViewCollection.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      }
    ],
  },
  {
    path: '/categories',
    component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
    children: [
      {
        path: '',
        name: 'CategoryList',
        component: () => import(/* webpackChunkName: "category-list" */'@/views/categories/CategoryList.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: 'new',
        name: 'NewCategory',
        component: () => import(/* webpackChunkName: "new-category" */'@/views/categories/CreateCategory.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        }
      },
      {
        path: 'edit/:id',
        name: 'EditCategory',
        component: () => import(/* webpackChunkName: "edit-category" */'@/views/categories/EditCategory.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: ':id',
        name: 'ViewCategory',
        component: () => import(/* webpackChunkName: "view-category" */'@/views/categories/ViewCategory.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      }
    ],
  },
  {
    path: '/products',
    component: () => import('@/layouts/dashboard/DashboardLayout.vue'),
    children: [
      {
        path: '',
        name: 'ProductList',
        component: () => import(/* webpackChunkName: "product-list" */'@/views/products/ProductList.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: 'new',
        name: 'NewProduct',
        component: () => import(/* webpackChunkName: "new-product" */'@/views/products/CreateProduct.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        }
      },
      {
        path: 'edit/:id',
        name: 'EditProduct',
        component: () => import(/* webpackChunkName: "edit-product" */'@/views/products/EditProduct.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      },
      {
        path: ':id',
        name: 'ViewProduct',
        component: () => import(/* webpackChunkName: "view-product" */'@/views/products/ViewProduct.vue'),
        meta: {
          requiresAuth: true,
          onlyWhenLoggedOut: false,
          roles: ['MANAGER', 'ADMIN'],
        },
      }
    ],
  }
];
