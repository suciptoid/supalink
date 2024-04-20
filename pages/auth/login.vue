<script setup lang="ts">
const user = useSupabaseUser();
const { auth } = useSupabaseClient();
const url = useRequestURL();

const redirectTo = `${url.origin}/auth/redirect`;

watchEffect(() => {
  if (user.value) {
    navigateTo("/org");
  }
});
</script>

<template>
  <div
    class="min-h-full flex flex-col justify-center py-12 sm:px-6 lg:px-8 items-center"
  >
    <UCard class="w-full max-w-sm p-8 shadow-sm border rounded-md">
      <h2 class="text-center text-xl font-extrabold u-text-white py-3">
        Sign in to your account
      </h2>
      <UButton
        class="mt-3"
        block
        variant="solid"
        color="black"
        label="Github"
        @click="
          auth.signInWithOAuth({ provider: 'github', options: { redirectTo } })
        "
      />
      <UButton
        class="mt-3"
        block
        variant="solid"
        color="red"
        label="Google"
        @click="
          auth.signInWithOAuth({ provider: 'google', options: { redirectTo } })
        "
      />
    </UCard>
  </div>
</template>
