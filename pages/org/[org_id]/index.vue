<script setup lang="ts">
import type { Database } from "~/supabase/types";

definePageMeta({
  title: "Links",
  layout: "dashboard",
  middleware: ["auth", "org"],
});

const route = useRoute();
const url = useRequestURL();
const supabase = useSupabaseClient<Database>();
const { copy } = useCopyToClipboard();

const { pending, data: links } = useAsyncData("links_list", async () => {
  return supabase
    .from("links")
    .select()
    .eq("org_id", route.params.org_id)
    .order("updated_at", { ascending: false });
});
</script>

<template>
  <div id="app" class="overflow-y-auto">
    <UContainer class="py-4">
      <div id="link-placeholder" class="space-y-2" v-if="pending">
        <UCard v-for="link in 5" :key="link">
          <div class="flex items-center gap-2">
            <USkeleton class="h-12 w-12" :ui="{ rounded: 'rounded-full' }" />

            <div class="links flex-1">
              <div class="flex items-center gap-2">
                <USkeleton class="h-4 w-[200px]" />
              </div>
              <div
                class="text-xs text-gray-600 dark:text-gray-300 truncate mt-2"
              >
                <USkeleton class="h-4 w-[250px]" />
              </div>
            </div>
            <div class="link-stats">
              <USkeleton class="h-8 w-8" />
            </div>
          </div>
        </UCard>
      </div>
      <div v-else id="link-lists" class="space-y-2">
        <UCard v-for="link in links?.data" :key="link.id">
          <div class="flex items-center gap-2">
            <UAvatar
              alt="Link Icon"
              class="mr-2"
              :src="`https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=${link.url}&size=64`"
            />
            <div class="links flex-1">
              <div class="flex items-center gap-2">
                <ULink
                  :to="`/${link.slug}`"
                  noPrefetch
                  external
                  target="_blank"
                  class="font-semibold text-blue-700 dark:text-gray-200 text-sm"
                >
                  {{ url.origin }}/{{ link.slug }}
                </ULink>
                <UButton
                  icon="i-heroicons-clipboard-document"
                  variant="ghost"
                  color="blue"
                  size="xs"
                  @click="
                    copy(`${url.origin}/${link.slug}`, {
                      title: 'Link copied to clipboard',
                    })
                  "
                ></UButton>
              </div>
              <div
                class="text-xs text-gray-600 dark:text-gray-300 truncate w-1/4"
              >
                {{ link.url }}
              </div>
            </div>
            <div class="link-stats">
              <UButton
                :to="`stats?link=${link.id}`"
                variant="soft"
                class="flex items-center gap-2"
              >
                {{ link.clicks }}
                <UIcon name="i-heroicons-chart-bar" />
              </UButton>
            </div>
          </div>
        </UCard>
      </div>
    </UContainer>
  </div>
</template>
