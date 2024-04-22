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

const org = await supabase
  .from("links")
  .select()
  .eq("org_id", route.params.org_id)
  .order("updated_at", { ascending: false });
</script>

<template>
  <div id="app">
    <UContainer class="py-4">
      <div id="link-lists" class="space-y-2">
        <UCard v-for="link in org.data" :key="link.id">
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
