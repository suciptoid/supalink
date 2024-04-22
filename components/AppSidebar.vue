<script setup lang="ts">
const route = useRoute();
const config = useRuntimeConfig();

const links = [
  {
    label: "My Links",
    icon: "i-heroicons-link",
    to: `/org/${route.params.org_id}`,
    labelClass: "py-2",
    iconClass: "px-4",
  },
  {
    label: "Analytics",
    icon: "i-heroicons-chart-bar",
    to: `/org/${route.params.org_id}/stats`,
    labelClass: "py-2",
    iconClass: "px-4",
  },
];
</script>

<template>
  <aside
    class="flex flex-col w-[250px] max-h-screen border-r dark:border-gray-700 bg-gray-50/50 dark:bg-gray-800"
  >
    <div class="text-lg font-bold py-3 px-4 border-b dark:border-gray-700">
      {{ config.public.appName }}
    </div>
    <nav class="flex-1 overflow-x-auto px-3 py-2">
      <UVerticalNavigation size="lg" :links="links" />
    </nav>
    <div class="border-t px-4 py-1 dark:border-gray-700">
      <SideProfile />
    </div>
  </aside>
</template>
