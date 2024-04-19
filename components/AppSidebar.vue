<script setup lang="ts">
const route = useRoute();
const colorMode = useColorMode();

const client = useSupabaseClient();
const user = useSupabaseUser();

const links = [
  {
    label: "My Links",
    icon: "i-heroicons-link",
    to: `/org/${route.params.org_id}`,
  },
  {
    label: "Analytics",
    icon: "i-heroicons-chart-bar",
    to: `/org/${route.params.org_id}/stats`,
  },
];
</script>

<template>
  <aside
    class="flex flex-col w-[250px] max-h-screen border-r dark:border-gray-700 bg-gray-50/50 dark:bg-gray-800"
  >
    <div class="text-lg font-bold py-3 px-4 border-b">Supalink</div>
    <nav class="flex-1 overflow-x-auto px-3 py-2">
      <UVerticalNavigation :links="links" />

      <!-- <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" />
      <UVerticalNavigation :links="links" /> -->
    </nav>
    <div class="border-t px-4 py-1">
      <SideProfile />
    </div>
  </aside>
</template>
