<script setup lang="ts">
const user = useSupabaseUser();
const client = useSupabaseClient();

const items = [
  [
    {
      label: "Profile",
      avatar: {
        src: user.value?.user_metadata?.avatar_url,
      },
    },
  ],
  [
    {
      label: "Edit",
      icon: "i-heroicons-pencil-square-20-solid",
      shortcuts: ["E"],
      click: () => {
        console.log("Edit");
      },
    },
    {
      label: "Duplicate",
      icon: "i-heroicons-document-duplicate-20-solid",
      shortcuts: ["D"],
      disabled: true,
    },
  ],
  [
    {
      label: "Archive",
      icon: "i-heroicons-archive-box-20-solid",
    },
    {
      label: "Move",
      icon: "i-heroicons-arrow-right-circle-20-solid",
    },
  ],
  [
    {
      label: "Logout",
      icon: "i-heroicons-power-20-solid",
      click: async () => {
        await client.auth.signOut();
        navigateTo("/");
      },
    },
  ],
];
</script>

<template>
  <div class="sidebar-profile">
    <UDropdown
      class="w-full flex justify-between"
      :items="items"
      :popper="{ placement: 'bottom-start' }"
    >
      <UButton
        block
        variant="ghost"
        color="white"
        trailing-icon="i-heroicons-chevron-down-20-solid"
      >
        <template #leading>
          <div class="flex-1 flex items-center gap-2 text-left">
            <UAvatar
              v-if="user?.user_metadata?.avatar_url"
              size="xs"
              :src="user?.user_metadata?.avatar_url"
            />
            <span class="">
              {{ user?.user_metadata?.full_name ?? user?.email }}
            </span>
          </div>
        </template>
      </UButton>
    </UDropdown>
  </div>
</template>
