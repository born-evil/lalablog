import { defineCollection, z } from "astro:content";

const blog = defineCollection({
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    description: z.string().optional(),
    tags: z.array(z.string()).default([]),
    cover: z.string().optional()
  })
});

const gallery = defineCollection({
  schema: ({ image }) =>
    z.object({
      title: z.string(),
      date: z.coerce.date(),
      image: image(),
      caption: z.string().optional(),
      category: z.enum(["art", "photography"])
    })
});

export const collections = {
  blog,
  gallery
};
