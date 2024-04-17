<script setup lang="ts">
const client = useSupabaseClient();
const user = useSupabaseUser();
const colorMode = useColorMode();

const toggleDark = () => {
  colorMode.preference = colorMode.value === "dark" ? "light" : "dark";
};

const logout = async () => {
  await client.auth.signOut();
  navigateTo("/");
};
</script>

<template>
  <UContainer>
    <div class="flex items-center md:justify-between justify-center py-3">
      <div class="text-lg font-bold">SupaLink</div>
      <div class="flex items-center gap-3">
        <ColorScheme
          ><USelect
            v-model="$colorMode.preference"
            :options="['system', 'light', 'dark']"
        /></ColorScheme>
        {{ user?.email }}
        <UButton
          v-if="user"
          class="u-text-white"
          variant="transparent"
          @click="logout"
        >
          Logout
        </UButton>
      </div>
    </div>
  </UContainer>
</template>
