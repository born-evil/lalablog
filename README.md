# Yasmin minimal blog

A blog-first Astro site for writing, art, and photography, designed with a very
minimal black-and-white aesthetic and set up for deployment on Cloudflare Pages.

## What is included

- Homepage displaying the newest post
- Blog index and individual post pages
- Gallery page for art and photography
- Astro content collections for `blog` and `gallery`
- Sample posts and placeholder gallery images

## Local setup

This machine did not have `node` or `npm` installed during implementation, so
dependencies could not be installed or verified here. Once Node is available:

```bash
npm install
npm run dev
```

Then open the local Astro URL shown in the terminal.

## Content workflow

### Add a blog post

Create a Markdown file in `src/content/blog/` with frontmatter like:

```md
---
title: "Post title"
date: 2026-03-30
description: "One-sentence summary"
tags:
  - writing
cover: "/images/your-cover.jpg"
---
```

### Add artwork or photography

1. Place the image in `src/assets/gallery/`.
2. Create a Markdown file in `src/content/gallery/` with frontmatter like:

```md
---
title: "Piece title"
date: 2026-03-30
image: "../../assets/gallery/your-file.jpg"
caption: "Optional caption"
category: "art"
---
```

Use `category: "photography"` for photo entries.

### Add an image inside a blog post

1. Place the image in `src/content/blog/images/`.
2. In the post Markdown file, insert it with a relative path like:

```md
![Alt text](./images/your-file.jpg)
```

Gallery and blog images now go through Astro's image pipeline instead of being
served raw from `public/`, which gives you automatic resizing/optimization and a
safer default setup.

## Cloudflare Pages deployment

1. Create a GitHub repository and push this project.
2. In Cloudflare Pages, create a new project connected to that GitHub repo.
3. Use these build settings:
   - Framework preset: `Astro`
   - Build command: `npm run build`
   - Build output directory: `dist`
4. Add your custom domain in Cloudflare Pages.
5. In `astro.config.mjs`, replace `https://example.com` with your real domain.
6. If you want both apex and `www`, set one as the primary domain and configure
   the redirect in Cloudflare.

## Suggested next edits

- Replace the sample posts with your own writing
- Replace the placeholder gallery SVGs with your actual images
