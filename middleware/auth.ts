export default defineNuxtRouteMiddleware((to) => {
  // if (!to.matched.some((record) => record.meta.requiresAuth)) {
  //   return;
  // }

  const user = useSupabaseUser();

  if (!user.value) {
    return navigateTo("/auth/login");
  }
});
