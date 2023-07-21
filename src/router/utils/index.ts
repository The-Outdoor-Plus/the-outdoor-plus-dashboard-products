export const mapRoutes = (options: any, routes: any) => {
  routes.forEach((route: any) => {
    route.meta = { ...route.meta, ...options }
    if (route?.children.length > 0)
      route.children = mapRoutes(route.options, route.children);
  });
  return routes;
}