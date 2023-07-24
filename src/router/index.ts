// Composables
import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '@/store/user';
import routes from './routes';

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  const userStore = useUserStore();

  const allowedRoles: String[] = (to.meta.roles as String[]) || [];
  const requiresAuth = to.meta.requiresAuth;
  const onlyWhenLoggedOut = to.meta.onlyWhenLoggedOut;
  const currentUser = userStore.currentUser;
  const loggedIn = userStore.isUserAuthenticated;

  if (requiresAuth && !onlyWhenLoggedOut && !loggedIn) {
    return next({
      path: '/login',
      query: { redirect: to.fullPath },
    });
  }

  if (requiresAuth && !loggedIn) {
    return next({
      path: '/login',
      query: { redirect: to.fullPath },
    })
  }

  if (loggedIn && onlyWhenLoggedOut) {
    return next('/');
  }

  if (loggedIn && !allowedRoles.includes(currentUser?.user_metadata?.role || '')) {
    return next('/');
  }

  next();
});

export default router
