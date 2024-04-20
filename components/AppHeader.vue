<script setup lang="ts">
const client = useSupabaseClient();
const colorMode = useColorMode();

const toggleDark = () => {
  colorMode.preference = colorMode.value === "dark" ? "light" : "dark";
};

const modalCreate = useShowModalCreate();

const route = useRoute();

const logout = async () => {
  await client.auth.signOut();
  navigateTo("/");
};
</script>

<template>
  <div
    class="flex items-center md:justify-between justify-center py-1.5 px-4 border-b dark:border-gray-700"
  >
    <div class="text-lg font-bold">{{ route.meta.title }}</div>
    <div class="flex items-center gap-3">
      <ColorScheme>
        <UToggle
          size="lg"
          on-icon="i-heroicons-moon-20-solid"
          off-icon="i-heroicons-sun-20-solid"
          :model-value="colorMode.value === 'dark'"
          @update:model-value="
            $colorMode.preference = $event ? 'dark' : 'light'
          "
        />
      </ColorScheme>

      <UButton size="lg" class="px-10" @click="modalCreate = !modalCreate">
        Create Link
      </UButton>
    </div>
    <ModalCreate />
  </div>
</template>
