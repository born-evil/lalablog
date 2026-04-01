# Website Workflow

This file is your simple guide for updating and publishing the site.

## Main idea

- Write and edit in **VS Code**
- Publish from **Terminal**
- GitHub stores the changes
- Cloudflare updates the live site automatically

## Where things go

- Blog posts: `src/content/blog/`
- Blog post images: `src/content/blog/images/`
- Gallery entry files: `src/content/gallery/`
- Gallery image files: `src/assets/gallery/`

## Add a new blog post

1. Open `src/content/blog/`
2. Create a new file like `april-02.md`
3. Paste this:

```md
---
title: "2 April 2026, Title Here"
date: 2026-04-02
description: "Short note"
tags:
  - writing
---

Write your post here.
```

4. Save the file

## Add an image inside a blog post

1. Put the image in `src/content/blog/images/`
2. Inside the post, use:

```md
![Alt text](./images/your-image.jpg)
```

## Add a new gallery image

1. Put the image in `src/assets/gallery/`
2. Open `src/content/gallery/`
3. Create a file like `gallery8.md`
4. Paste this:

```md
---
title: "2 April 2026"
date: 2026-04-02
image: "../../assets/gallery/your-image.jpg"
caption: ""
category: "photography"
---
```

Use `category: "art"` for artwork.

## Publish changes

Open Terminal and run:

```bash
cd "/Users/yasmin/Desktop/CODEX THING"
npm run build
git add .
git commit -m "Describe what you changed"
git push
```

Then wait a little and check:

- `https://dontlook.online`

## Formatting guide for blog posts

### Bold

```md
**bold text**
```

### Italic

```md
*italic text*
```

### Bold + italic

```md
***bold italic text***
```

### New paragraph

Leave a blank line between paragraphs.

```md
First paragraph.

Second paragraph.
```

### Soft line break

Put two spaces at the end of a line, then press return:

```md
first line.  
second line.
```

Or use:

```html
<br>
```

### Quote

```md
> quoted text
```

### Normal link

```md
[Link text](https://example.com)
```

### Link that opens in a new tab

```html
<a href="https://example.com" target="_blank" rel="noopener noreferrer">Link text</a>
```

### Smaller text

```html
<p style="font-size: 0.8em;">Smaller text here.</p>
```

### Centered text

```html
<p style="text-align: center;">Centered text here.</p>
```

### Centered block with left-aligned text

```html
<div style="max-width: 320px; margin: 0 auto; text-align: left;">
  first line<br>
  second line
</div>
```

### Smaller centered left-aligned block

```html
<div style="max-width: 320px; margin: 0 auto; text-align: left; font-size: 0.8em;">
  first line<br>
  second line
</div>
```

## Privacy reminder

- Writing is usually low-risk
- Photos are the main privacy concern
- If a photo is sensitive, export a clean copy before uploading it

## Site details

- Live site: `https://dontlook.online`
- GitHub repo: `https://github.com/born-evil/lalablog`
