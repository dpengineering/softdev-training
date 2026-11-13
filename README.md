# DPEA Softdev Training Docs

Source for https://dpengineering.github.io/softdev-training/. Every push to main rebuilds and deploys the site through GitHub Actions. It can take a few minutes to show up.

## Add a page

1. Make a .md file in the folder it belongs in (for example deploying_pi/).
2. Start it with front matter. Only title is required:

   ```yaml
   ---
   title: My New Page
   ---
   ```

3. Write the page in Markdown below the front matter.
4. Push to main, or open a PR first so the CI build checks it.

A .md file without front matter isn't turned into a page.

## Control where it shows in the sidebar

| Front matter | What it does |
|:--|:--|
| nav_order: 3 | Sets the position among its siblings. Pages without one go after numbered pages, sorted by title. |
| parent: Flash the SD Card | Nests the page under another page. Use that page's exact title. |
| has_children: true | Put this on the parent page. It also lists the child pages at the bottom. |
| nav_exclude: true | Hides the page from the sidebar. |

Example child page:

```yaml
---
title: Connect to Wi-Fi
parent: Flash the SD Card
nav_order: 1
---
```

## Images and videos

Put images in assets/Images/ and link them relative to the page. From a page one folder deep:

```markdown
![Deploy keys page](../assets/Images/deploy-keys.png)
```

Embed a YouTube video with its embed URL:

```html
<iframe width="720" height="405" src="https://www.youtube.com/embed/VIDEO_ID" frameborder="0" allowfullscreen></iframe>
```

## Callouts

Put one of note, tip, or warning on the line above a paragraph:

```markdown
{: .warning }
Never put Wi-Fi passwords in these docs. This site is public.
```

## Preview locally (optional)

Needs Ruby 3.1 or 3.2 (CI uses 3.1). Jekyll 4.3.2 crashes on Ruby 3.3 and newer.

```bash
bundle install
bundle exec jekyll serve
```

Then open http://localhost:4000. If bundle install says your platform isn't in the lockfile, run the bundle lock --add-platform command it prints.

## Credits

Built with [Just the Docs](https://just-the-docs.github.io/just-the-docs/), starting from the [just-the-docs-template](https://github.com/just-the-docs/just-the-docs-template).
