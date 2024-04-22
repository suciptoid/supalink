<script setup lang="ts">
import type { FormError, FormSubmitEvent } from "#ui/types";
import type { Database } from "~/supabase/types";

const isOpen = useShowModalCreate();
const isLoading = useState<boolean>("create_link_loading", () => false);
const url = useRequestURL();
const route = useRoute();
const supabase = useSupabaseClient<Database>();
const toast = useToast();

const refresh = () => refreshNuxtData("links_list");
const { copy } = useCopyToClipboard();

const state = reactive({
  link: "",
  slug: "",
});

const validate = (state: any): FormError[] => {
  const errors = [];
  if (!state.link) errors.push({ path: "link", message: "Link is required" });

  if (!state.slug)
    errors.push({ path: "slug", message: "Short URL is required" });
  return errors;
};

defineShortcuts({
  C: {
    handler: () => {
      isOpen.value = true;
    },
  },
});

async function onSubmit(event: FormSubmitEvent<any>) {
  isLoading.value = true;
  try {
    const orgId = route.params?.org_id?.toString();
    if (!orgId) {
      toast.add({
        id: "create_link_error",
        title: "Error create link",
        description: "Org id is required",
      });
      return;
    }
    const link = await supabase
      .from("links")
      .insert({
        org_id: orgId,
        url: state.link,
        slug: state.slug,
      })
      .select("id,slug")
      .single();

    if (link.error) {
      if (link.error.code === "23505") {
        toast.add({
          id: "create_link_error",
          title: "Error create link",
          description: "Link already in use",
        });
        return;
      }
      toast.add({
        id: "create_link_error",
        title: "Error create link",
        description: link.error.message,
      });
      return;
    } else {
      copy(`${url.origin}/${link.data!.slug}`, {
        title: "Link Created",
        description: "Link created and copied to clipboard",
      });

      refresh();

      isOpen.value = false;
    }
  } finally {
    isLoading.value = false;
  }
}
</script>

<template>
  <UModal v-model="isOpen">
    <UCard
      :ui="{
        ring: '',
        divide: 'divide-y divide-gray-100 dark:divide-gray-800',
      }"
    >
      <template #header>
        <div class="flex items-center justify-between">
          <h3
            class="text-base font-semibold leading-6 text-gray-900 dark:text-white"
          >
            Create Link
          </h3>
          <UButton
            color="gray"
            variant="ghost"
            icon="i-heroicons-x-mark-20-solid"
            class="-my-1"
            @click="isOpen = false"
          />
        </div>
      </template>
      <div class="p-4">
        <UForm id="create-link" :state="state" @submit="onSubmit">
          <UFormGroup label="Target Link" name="link">
            <UInput placeholder="https://supabase.com" v-model="state.link" />
          </UFormGroup>

          <UFormGroup label="Shortened URL" name="slug">
            <div class="flex">
              <div
                class="rounded-md rounded-r-none bg-gray-100 dark:bg-gray-900 dark:border-gray-700 border px-2 flex items-center"
              >
                {{ url.host }}
              </div>
              <UInput
                class="flex-1 border-l-0"
                autocomplete="off"
                placeholder="aX1dkd..."
                v-model="state.slug"
                :ui="{ rounded: 'rounded-l-none' }"
              >
              </UInput>
            </div>
          </UFormGroup>
        </UForm>
      </div>

      <template #footer>
        <div
          id="modal-create-footer"
          class="flex items-center justify-end gap-3"
        >
          <UButton
            color="gray"
            variant="ghost"
            size="lg"
            class="px-10"
            @click="isOpen = false"
          >
            Cancel
          </UButton>
          <UButton
            size="lg"
            variant="solid"
            class="px-10"
            type="submit"
            form="create-link"
            :loading="isLoading"
          >
            Create Short Link
          </UButton>
        </div>
      </template>
    </UCard>
  </UModal>
</template>
