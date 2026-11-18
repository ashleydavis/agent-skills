---
description: Create a style guide for an app, with design tokens in CSS, written rules and a style explorer web app published on GitHub Pages, choosing every style with the human one step at a time.
argument-hint: <app name> [path to the app]
---

# Create a style guide

Create a style guide for the app named in `$ARGUMENTS`, in its own repository, and walk the human through choosing every part of the style. With no app named, ask which app before doing anything else.

The finished result for an earlier app is the Graft style guide: the repository https://github.com/ashleydavis/graft-style-guide and its live style explorer https://ashleydavis.github.io/graft-style-guide/. Look at both for what the end result looks like: the token file, the rules and the explorer's pages. Everything needed to follow the process is in this command.

## What the style guide is

- **Design tokens.** Every colour, size, font, corner radius, shadow, animation time and icon size gets a name, such as `--color-accent` or `--radius-md`, as a CSS variable in one file, `<app>.css`. Code uses the name, never the raw value. CSS needs no build step, so any web page can link it. No JSON token files.
- **Two layers of tokens.** Raw palette tokens hold values (`--gray-500`). Role tokens say what a value is for (`--color-panel`, `--color-text-muted`) and point at a raw palette token. Components and rules use role tokens only.
- **Light and dark.** Every role token has a light value (on `:root` and `.light`) and a dark value (under `.dark`), even when the two are the same. A page or one panel switches theme by setting the `light` or `dark` class. Every option, preview and rule covers both themes.
- **Rules.** `style-guide.md` holds the intent, which token to use when, the states every control has, the contrast table, the tone of UI text, patterns to avoid and a review checklist. `ux-rules.md` holds how the interface behaves and is laid out. An area with its own rules gets a file under `areas/`, which takes priority there.
- **The style explorer.** A web app in the same repository that shows every token and every component in light and dark, so each choice is judged on screen. It is published on GitHub Pages.

## How to work with the human

- One step per message. At each choice offer two or three options plus "Spot it", let the human pick by letter, and never pick for them unless they ask.
- When the human asks for a fix or a change, make it directly. Never turn it into a choice.
- The first choices come only from the human's intent and picks, and from the material the human points you at. Never read the app itself, its UI code or its screenshots unless the human asks in that message.
- `todo.md` holds only the steps of making the style. Repository setup, git, GitHub and tooling never go in it.
- Never invent a step the process does not have. Ask the human nothing that a step does not need from them: for example the human never describes the app's screens; the explorer builds up component by component.
- A message from the human starting `UX:` is a UX rule: add it to `ux-rules.md` in their own words, under the section it belongs to, and apply it straight away.
- After each set of choices is implemented in code, whether offered on the Choices page or picked into the token file, run the checks and commit. Never push unless the human asks.
- Keep `how-we-built-it.md` in the new repository up to date: after every pick, setup change, new tool or problem solved, add it there in simple terms, in the same reply. Tick `todo.md` items as they are done.

## Step 1: Create the project

Create `<app>-style-guide/` where the human says, beside the app's own repository by default. Build a stub: the complete explorer, no style choices and only two example components, a button and a text input.

### Tools

Use Bun, TypeScript, Vite, React, MUI, Tailwind, TanStack Router and Font Awesome, every version locked exactly, with Bun locked in `mise.toml`. When the app has a web frontend and the human allows it, a subagent reads the app's frontend setup without its styling, the human checks the list, and the explorer takes the same libraries at the same versions. Scripts in `package.json` run each tool by passing its script file to Bun (`bun node_modules/vite/bin/vite.js`), never with `bun --bun`, so the project needs only Bun.

### Files

- `<app>.css`: every token, all neutral grey placeholders so the explorer draws before any choice: a grey ramp, `--black-40` and `--black-60`, `--font-sans`, `--font-heading` and `--font-mono`, `--text-xs` to `--text-2xl`, three weights, `--leading-tight` and `--leading-normal`, `--space-1` to `--space-8`, `--radius-sm` to `--radius-full`, `--icon-sm` to `--icon-lg`, `--focus-ring-width` and `--focus-ring-offset`, three durations and `--ease-standard`, and role tokens for bg, panel, raised, border, control border, text, muted text, disabled text, hover, selected, disabled, accent, accent hover, on accent, focus, success, warning, danger, on danger, info, scrim, scrollbar thumb and track, raised and overlay shadows.
- `style-guide.md` with an Intent and a Contrast section, `ux-rules.md` holding the starting UX rules below, `process.md` (the steps below), `todo.md` (the list below), `how-we-built-it.md`, `README.md` and a terse `CLAUDE.md` holding the working rules of this command.
- `.gitignore` with `node_modules/`, `dist/`, `tmp/` and `.what-changed/`.

### The explorer

- **Pages.** One page per component under `src/pages/<page>/index.tsx`, listed in `src/explorer-pages.ts` with an id, title, search keywords and a sidebar group. The page is in the URL as `/page/<id>`; the bare URL opens the overview.
- **Sidebar.** A search box (Enter opens the first match), the style pages first (Overview, Choices, later Fonts), then "App features" and "Basic components" under headings that close and open, remembered in the browser. A search opens every group. A group with no pages is hidden. A button minimises the sidebar to a floating restore button.
- **Overview page.** Every token with a small example of its use: swatches that print the value each token resolves to in their theme, type, spacing, radius, shadows, icons, focus ring and motion.
- **Choices page.** One section per open choice, its options side by side, each option card setting its token values inline for the theme of the panel it sits in. Each choice names the preview its options are drawn on. Previews are built from the explorer's own components so far, such as the buttons and text boxes on a background and a panel, or the status colours as words and on the text box's error state. Never build a mock-up of the app's screens.
- **Themes.** A Configuration dropdown under a gear button at the top right sets Components (light, dark, or dark next to light) and Explorer (the frame's own theme). Both settings and the sidebar state are kept in the browser's storage, defaulting to dark components in a dark explorer. `index.html` reads the stored explorer theme and sets the class before first paint, and links the token file and paints the background from it. Every example section draws one panel per theme, each panel setting the `light` or `dark` class.
- **About.** An info button at the top right opens a popup sized to its text, linking the style guide's repository.
- **Mobile.** Below 1024px the sidebar is a drawer from a menu button that closes when a page is chosen. Every page fits a 390px-wide screen upright and on its side with no sideways scrolling. Floating buttons sit on the panel colour with the raised shadow, and page titles leave room for them on both sides.
- **Live reload.** Editing the token file updates the open page; components that print a token value read it again after each Vite update.
- **Styling order.** MUI components styled through the theme (`styleOverrides`, `variants`, `defaultProps`) all pointing at the CSS variables; then Tailwind classes; then plain CSS. A component MUI lacks is built in React with Tailwind first. Explorer code uses role tokens only, never a literal colour or size.

### The starting UX rules

Write these into `ux-rules.md` from the start, under these headings, and follow them in every page and component. The human can override any of them.

- **Dangerous operations** (an operation that loses work that cannot be brought back): the button is outlined, never filled, with its text, icon and border in `--color-danger` on a see-through background, and on hover its border thickens to 2px. An icon-only dangerous button follows the same rule. A disabled one takes the disabled colours. Its tooltip says what it does, how to undo it and its key. An action that can be undone takes effect straight away and asks nothing; the item plays a short animation, stays in view faded and struck through, and its button turns into Undo. A dangerous action has a key, Delete, that acts on what is selected and brings a deleted item back.
- **Buttons:** every button looks like a button, with a visible border and a hover effect, drawn as a 1px line inside the button where needed so every kind stays the same height. Icon buttons are square, with room between the icon and the border. Rows of a list, tree, sidebar or menu are rows to pick, not buttons: they show the hover and selected colours instead of a border.
- **Text:** no capitals for titles; sentence case. "Directory", not "Folder".
- **Toolbars:** a toolbar cluttered with configuration buttons or switches moves them into a configuration dropdown dialog opened from one button.
- **Placing actions:** non-destructive tools at the left, destructive ones at the right, so the width of a row lies between them. Destructive buttons stand apart and are slightly smaller, so they are harder to hit by accident. A destructive button shows only on the selected item and an item under the pointer; Undo shows on every deleted item.
- **Spacing around controls:** every control has `--space-2` or more between it and anything beside it, and between it and any border round it, including the edge of the example panels.
- **Search:** tables, trees, lists and other large content come with a search box, or, where that would clutter, a search mode opened with Ctrl+F: Enter applies, Escape leaves and hides it. Lists filter; text highlights matches with up and down buttons to move between them.
- **Screens:** every page and component works on desktop and mobile, upright and on its side.

### Checks and publishing

- **Playwright tests** in Chrome, starting their own dev server on a free port: opening pages, search, themes, Configuration, the stored theme before first paint, the sidebar, About, every role token having a light and a dark value (read from the token file), and each option drawing its own values. A second file runs as a touch mobile 390 by 844 upright and on its side: every page in every component mode fits the width, floating buttons clear the title, the drawer, Enter in its search, tapping outside, Configuration and About.
- **what-changed** (`what-changed.yaml`) lists the type check and the end-to-end tests and the files each watches. `scripts/test-everything.sh` runs the ones whose files changed. A pre-commit hook in `.githooks/pre-commit`, installed per clone by `scripts/install-hooks.sh`, runs it. A GitHub Actions workflow runs it on every push and uploads `tmp/` when it fails. Every script has a markdown file beside it.
- **Build.** `bun run build` deletes and writes `docs/` with hashed file names, plus `404.html` (a copy of `index.html`, so links to a page load), `.nojekyll` and a copy of the token file. The base path is `/<app>-style-guide/` for the build and `/` for the dev server. Commit `docs/` with every change to the token file or `src/`.
- **Dev server.** A fixed port that differs from other explorers on the machine, polling for file changes. Keep it running and the explorer open in Chrome (`google-chrome --new-window`).

### Problems already solved

- MUI's styles lose to Tailwind's base styles unless the layer order is declared through MUI (`StyledEngineProvider enableCssLayer` and a `GlobalStyles` holding `@layer theme, base, mui, components, utilities;`) as well as in the CSS.
- A flash from light to dark on refresh: set the theme class in `index.html` before anything draws.
- After a change to `vite.config.ts`, or moving, renaming or deleting a file under `src/`, stop the dev server process and start a new one, then check the open pages render. Vite's own restart leaves the browser on a closed server, and a moved file leaves a stale page that shows blank.
- Floating buttons jump as the scrollbar comes and goes: give `html` `scrollbar-gutter: stable`, and turn off MUI's scroll lock on popovers, menus and dialogs. Run headless Chrome with scrollbars shown so tests see it.
- Enter in the drawer's search box reopens the drawer: end the key press with `preventDefault` after using it.
- Tailwind scanning the whole repository reloads the page on every build: point it at `src/` only.
- Popups mount at the end of the page, outside the themed panel that opened them, and take the wrong theme: mount them beside their control.
- A screenshot taken before the web fonts load shows fallback fonts: wait for `document.fonts.ready`.

## Step 2: Intent

1. With the human's go-ahead, read the app's brand material: its README, docs, wiki, website and the website's assets, its logo, app icon and splash screens.
2. Summarise what they show in a few bullets: what the app is for, the brand colours with their hex values, the logo, the dark surfaces, the website's look and its fonts.
3. Offer five one-sentence intents, each a different emphasis, using the app's own words for what it is.
4. The human picks one or combines several. Write the result into `style-guide.md`, stating that it has light and dark themes. Every later choice is checked against it.

## Step 3 onward: choices

### How a choice works

- Offer choices in sets, several at once on the Choices page, in the order of `todo.md`. Draw every option on a preview built from the components so far, in light and dark.
- Options come from the intent and the brand material. Each has a letter, a short name and one sentence saying what it is like.
- Before showing any colour option, compute its contrast against WCAG 2.2 AA (4.5 to 1 for text, 3 to 1 for control edges and graphics) against every background it sits on, in both themes, and report the figures. Fix any option that fails, or say what fails and why it is acceptable, such as a gradient used only as decoration.
- The last option of every choice is "Spot it": the choice's tokens painted bright red so the human finds what the choice changes. A token that cannot be red takes a value that stands out instead: a plain serif for a font, one large size for text sizes, 0 for spacing and radius, a red ring for shadows.
- Each choice draws on the preview that shows what it changes: the components so far for colours, spacing and radius; every text size with a wrapped paragraph for the type scale; a raised panel with an overlay over it for shadows; a command, a hash and a path for a monospace font; blocks sliding back and forth at each duration for animation; icons beside text, in a button, a search box and an icon button for icon sizes; muted text on each surface for muted text. A state the pointer or keyboard sets, such as hover or focus, is drawn on a copy of the control beside one at rest, so it shows without pointing.
- A token family components should follow (such as icon sizes) is wired into the MUI theme before its choice is offered, so the options change every component at once.
- Once the raw palette and role tokens are picked, the next choices are the looks the button and text box leave open, each given its own tokens read by the MUI theme: button shape, text box fill, a glow under the main button, the danger button, button heights, the icon button style and how a text box looks with the keyboard in it.
- One choice decides one thing the preview shows plainly. Split a choice that changes several things at once.
- When the options look alike, explain what differs. The human can ask you to pick.
- A choice that needs a new token adds it to the token file with a placeholder value, to the overview page and to every theme.
- A font choice ships each font with the explorer as an `@fontsource` package at an exact version.
- Show the open choices to the human as a numbered list, one number per choice and a letter per option, with each option's key values and contrast figures, so they reply with a number and letter for each, such as "1A 2C 3C".
- After a pick: write the values into the token file as new raw palette tokens (named for their hue and step) with the role tokens pointing at them, add the new raw tokens to the overview page, remove the section from the Choices page and any preview no other choice uses, remove packages only the losing options needed (such as fonts), tick `todo.md`, add the pick with its contrast figures to `how-we-built-it.md`, rebuild `docs/`, look at a component page in both themes, run the checks and commit.
- Tick only what a pick covers. When a todo item covers more than the pick did, split it and leave the rest unticked.
- The end-to-end tests check the Choices page in whichever state it is in: an option drawing its own values while choices are open, and "No choices are open." while none are.
- When a check finds an earlier pick fails contrast, make the fix a choice of its own instead of changing the pick quietly.

### The order of choices

1. **Raw palette:** grey ramp, accent colour, status colours (success, warning, danger, info), the app's own colours (such as a brand gradient, used only where the intent allows), fonts, type scale with weights and line heights, spacing and density, corner radius, shadows, animation durations and easing, icon sizes.
2. **Role tokens:** focus ring, muted text, hover, selected, disabled and control border colours, each its own choice. Then a contrast check of every text and control colour against every background, in both themes, with the ratios recorded in a table in `style-guide.md`.
3. **Components:** agree with the human the components the app needs, list them in `todo.md` and build each page from MUI, styled in the theme. The looks components leave open become choices.
4. **App features:** agree which of the app's screens to rebuild in the explorer, built from the components, with example data, in both themes and on mobile.
5. **Rules:** write `style-guide.md` in full, grow `ux-rules.md` from the human's "UX:" rules and add `areas/` files.
6. **Review and apply:** review the whole explorer with the human in both themes and on mobile, adjust tokens, then, when the human asks, wire the token file into the app: imported once, Tailwind's `@theme` pointed at the variables, the MUI theme reading them and hard-coded values replaced.

## The todo list for the new project

Write `todo.md` with these sections and items, unticked, and grow it as the human agrees components and features:

- **Intent:** describe how the app should feel and pick an intent.
- **Raw palette:** one item per raw palette choice above.
- **Role tokens:** one item per role token choice above, then the contrast check.
- **Components:** review the button and the text box, agree the rest, build each page, pick the looks left open.
- **App features:** agree the screens, build each page.
- **Rules:** write `style-guide.md`, grow `ux-rules.md`, write `areas/` files.
- **Review and apply:** review together, wire the token file into the app.
