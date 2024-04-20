<script setup lang="ts">
const route = useRoute();
const config = useRuntimeConfig();

useHead({
  title: `${config.public.appName}${
    route.meta.title ? ` - ${route.meta.title}` : ""
  }`,
  meta: [
    {
      property: "og:title",
      content: `${config.public.appName}${
        route.meta.title ? ` - ${route.meta.title}` : ""
      }`,
    },
  ],
});
</script>
<template>
  <main class="flex h-screen inset-0 overflow-hidden">
    <AppSidebar />
    <div class="flex-1 flex flex-col">
      <AppHeader />
      <slot />
    </div>
  </main>
</template>
