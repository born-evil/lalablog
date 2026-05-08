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
    z
      .object({
        type: z.enum(["image", "video"]).default("image"),
        title: z.string(),
        date: z.coerce.date(),
        image: image().optional(),
        thumbnail: z.string().optional(),
        video: z.string().optional(),
        caption: z.string().optional(),
        category: z.enum(["art", "photography"])
      })
      .superRefine((data, ctx) => {
        if (data.type === "image" && !data.image) {
          ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: "Image gallery entries need an image."
          });
        }

        if (data.type === "video" && !data.video) {
          ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: "Video gallery entries need a video path."
          });
        }
      })
});

export const collections = {
  blog,
  gallery
};
