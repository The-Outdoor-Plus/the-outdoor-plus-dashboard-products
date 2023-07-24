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
    }
];
