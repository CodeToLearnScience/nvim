# Neovim configuration

A lightweight, modular Lua configuration managed by lazy.nvim, with tools for JavaScript, TypeScript, Rust, and Lua development.

## Features

| Area | Included functionality |
| --- | --- |
| Plugin management | lazy.nvim bootstraps itself and installs the configured plugins on first launch. |
| Editing | Persistent undo, yank highlighting, last-cursor-position restoration, selection-preserving indentation, absolute and relative line numbers, two-space indentation, spaces instead of tabs, smart indentation, case-insensitive search with smart case, and true-color support. |
| File navigation | Oil provides an editable directory buffer; Telescope searches files, file contents, open buffers, recent files, and help. |
| Build and test | Overseer manages Cargo commands and discovered project tasks/npm scripts; vim-test runs nearest tests, file tests, suites, and previous tests in a terminal split. |
| Project replacement | grug-far provides a searchable results preview and explicit replacement actions across project files. |
| Language support | Native Neovim LSP configurations enable `ts_ls`, `rust_analyzer`, `lua_ls`, and `eslint`, with hover, definitions, references, rename, code actions, and symbol search. Mason installs the servers automatically. Lazydev supplies Neovim API and plugin library support while editing Lua configuration files. |
| Diagnostics | Inline messages, gutter signs, underlines, severity sorting, floating details, and navigation between diagnostics. Diagnostics do not refresh during insert mode. |
| Completion | nvim-cmp offers language-server, snippet, buffer, and filesystem-path suggestions. |
| Snippets | LuaSnip loads VS Code-style snippets from friendly-snippets and supports expanding snippets and jumping through placeholders. |
| Editing helpers | Automatic bracket/quote pairing with nvim-autopairs and comment toggling with Comment.nvim. |
| Formatting | Conform formats Lua with StyLua, Rust with rustfmt, and web/configuration files with Prettier. Format a buffer or visual selection manually, with an attached LSP formatter as a fallback. Format-on-save is not configured. |
| Git | Gitsigns shows changes in the gutter and supports navigating, previewing, staging, and resetting hunks. Diffview adds changed-file review, revision comparison, file history, and conflict resolution. |
| Bookmarks | Harpoon keeps a small persistent list of files per working directory, with direct jumps and an editable menu. |
| Surround editing | nvim-surround adds, changes, and removes quotes, brackets, tags, and other delimiters. |
| Markdown rendering | render-markdown.nvim renders headings, code blocks, tables, lists, checkboxes, and callouts directly in markdown buffers. The cursor line shows raw markdown for editing. |
| Icons | nvim-web-devicons and mini.icons provide file-type icons for the status line, pickers, file explorer, Git review, and markdown code blocks. They require a Nerd Font in the terminal. |
| Health check | `:ConfigHealth` checks external executables, Tree-sitter CLI compatibility, configured Mason packages, and running language servers. |
| Terminal | ToggleTerm opens a horizontal terminal with a height of 15 lines. |
| Debugging | nvim-dap and nvim-dap-ui provide breakpoints, stepping, a debugger UI, Rust debugging through CodeLLDB, and JavaScript/compiled TypeScript debugging through the Node debug adapter. |
| Color scheme | Everforest dark with the medium-contrast grey background, loaded at startup so every plugin picks up its colors. |
| Centered layout | no-neck-pain.nvim centers the editing window at 120 columns automatically on startup and in new tabs, padding both sides with empty buffers. |
| Status line | Lualine displays mode, branch, diagnostics, filename, LSP status, filetype, progress, and cursor position. |
| Code navigation | Implementation/type jumps, call hierarchy, scoped search, persistent quickfix results, and Tree-sitter function/class/parameter text objects. |
| Sessions | Persistence automatically saves workspace sessions on exit, with manual project restore, session selection, and last-session restore. |
| Keybinding help | Which-key displays available mappings and groups for search, LSP, Git hunks, and debugging. |
| Tool management | Mason and mason-tool-installer automatically install missing language servers, formatters, and debug adapters from the list in `lua/plugins/mason.lua`. Existing tools are not automatically upgraded. |
| Project inspection | `:ProjectRoot` prints the nearest root containing `package.json`, `Cargo.toml`, or `.git`. It does not change the working directory. |
| Tree-sitter | Installs JavaScript, TypeScript, TSX, Rust, Lua, Vim, Vimdoc, query, Markdown, and inline Markdown parsers asynchronously and enables native syntax highlighting. Parsers are updated with the plugin through `:TSUpdate`. |

## Install on macOS

### 1. Install prerequisites

Install [Homebrew](https://brew.sh/) if needed, and follow its instructions to add `brew` to your shell's `PATH`. These steps work with Homebrew on Apple Silicon and Intel Macs.

Install Apple's command-line developer tools if they are not already present:

```sh
xcode-select --install
```

Then install Neovim and the supporting tools:

```sh
brew install neovim git ripgrep fd node stylua tree-sitter
nvim --version
```

Use Neovim 0.12 or newer for the configured Tree-sitter `main` branch, and Tree-sitter CLI 0.26.1 or newer. Check `nvim --version` and `tree-sitter --version` before launching. See the [Tree-sitter requirements](https://github.com/nvim-treesitter/nvim-treesitter#requirements).

`ripgrep` powers Telescope's live text search; `fd` supports file discovery. Node.js supplies the runtime and npm used by the TypeScript language server and JavaScript debugger. StyLua is the configured Lua formatter. A terminal with true-color support is recommended.

For Rust projects, also install the Rust toolchain using the instructions at [rustup.rs](https://rustup.rs/), then verify that `cargo` and `rustc` are available in your shell.

### 2. Back up an existing configuration

If `~/.config/nvim` already exists, move it aside before cloning:

```sh
mv ~/.config/nvim ~/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)
```

The commands below assume the default Neovim configuration path. If you set `XDG_CONFIG_HOME`, clone into `$XDG_CONFIG_HOME/nvim` instead.

### 3. Clone and launch

```sh
mkdir -p ~/.config
git clone https://github.com/CodeToLearnScience/nvim.git ~/.config/nvim
nvim
```

On first launch, lazy.nvim downloads itself and installs the plugins. An internet connection is required. Wait for installation and build tasks to finish, then restart Neovim. Use `:Lazy` to inspect installation status. The committed `lazy-lock.json` records plugin revisions; use `:Lazy restore` to return to those versions. Use `:Lazy update` only when you intend to upgrade plugins and review the resulting lockfile changes.

### 4. Let the development tools install

After plugins are installed, restart Neovim. mason-tool-installer checks for missing tools three seconds after startup and installs them asynchronously:

| Tools | Mason packages |
| --- | --- |
| Language servers | `typescript-language-server`, `rust-analyzer`, `lua-language-server`, `eslint-lsp` |
| Formatters | `stylua`, `prettier` |
| Debug adapters | `codelldb`, `js-debug-adapter` |

Open `:Mason` to watch progress. Keep Neovim open until installation completes, then restart it before opening your project so newly installed language servers can attach:

```sh
cd /path/to/your/project
nvim .
```

The tool list lives in `lua/plugins/mason.lua`. Existing tools are left at their installed versions. Use `:MasonToolsInstall` to retry missing installations immediately, or `:MasonToolsUpdate` to explicitly upgrade the listed tools. If installation fails, check `:MasonLog` and `:checkhealth mason`; Node.js/npm and other package-specific dependencies must be available. See [Mason's requirements](https://github.com/mason-org/mason.nvim#requirements) and [mason-tool-installer's commands](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim#commands).

Mason adds its executables to Neovim's `PATH`. Language-server configuration lives in `lua/plugins/lsp.lua`, which loads Mason and completion capabilities before enabling the servers. No mason-lspconfig integration is needed. Rust itself and rustfmt remain managed by rustup; install the formatter with `rustup component add rustfmt`. Homebrew/system tools such as Neovim, Node.js, ripgrep, fd, and the Tree-sitter CLI are installed separately using the prerequisites above.

`ts_ls`, `rust_analyzer`, `lua_ls`, and `eslint` are enabled here. Lua includes language-server completion and diagnostics, Neovim API support through lazydev, snippets, Tree-sitter highlighting, and StyLua formatting. To add another language server, install it and enable its configuration in `lua/plugins/lsp.lua`.

### 5. Check the setup

Run `:ConfigHealth` for the combined configuration report, or `:checkhealth`, `:checkhealth mason`, and `:checkhealth vim.lsp` to investigate missing tools. Use `:ConformInfo` to check formatter availability. Open a JavaScript, TypeScript, Rust, or Lua project file to check that its language server attaches.

Tree-sitter requires `tree-sitter`, a C compiler, `curl`, and `tar` on your `PATH`. The macOS prerequisites above provide these tools. Initial parser installation runs asynchronously; highlighting starts when installation completes. Use `:checkhealth nvim-treesitter` to diagnose installation problems and `:TSUpdate` to update parsers.

If parser installation reports `ENOENT` for `tree-sitter`, the CLI is missing from Neovim's `PATH`. On macOS, run `brew install tree-sitter`. With a Rust toolchain installed (including on Linux), you can instead run:

```sh
cargo install tree-sitter-cli --version 0.26.7 --locked
tree-sitter --version
```

Ensure `~/.cargo/bin` is on your shell's `PATH` for the Cargo installation. Restart Neovim and run `:TSInstall vimdoc` to retry the failed parser. Check `:echo exepath('tree-sitter')` if Neovim still cannot find the executable.

## Keybindings

The leader key is **Space**. Unless noted otherwise, these mappings are used in normal mode. LSP buffer mappings become available when a language server attaches.

### Files, search, and terminal

| Key | Action |
| --- | --- |
| `<Space>w` | Save the current file |
| `<Space>q` | Quit the current window |
| `<Space>e` | Open Oil file explorer |
| `<Space>ff` | Find files |
| `<Space>fg` | Search file contents with live grep |
| `<Space>fb` | Find open buffers |
| `<Space>fr` | Find recent files |
| `<Space>fh` | Search help tags |
| `<Space>t` | Toggle the horizontal terminal |

In an Oil buffer, edit directory entries and use `:w` to apply filesystem changes. In the terminal, use Neovim's `<C-\><C-n>` to return to normal mode before using normal-mode mappings.

### Navigation in large codebases

| Key | Action |
| --- | --- |
| `<Space>fw` | Search the word under the cursor across the project |
| `<Space>fd` | Prompt for a directory, then search its contents |
| `<Space>fG` | Find Git-tracked files (requires a Git repository) |
| `gi` | Go to implementations, such as implementations of a Rust trait |
| `gy` | Go to the type definition |
| `<Space>li` / `<Space>lo` | Show incoming / outgoing calls in Telescope |
| `<C-q>` in Telescope | Send selected results, or all results if none are selected, to quickfix and open it |
| `<Space>co` / `<Space>cc` | Open / close the quickfix results panel |
| `]q` / `[q` | Next / previous quickfix result |
| `<Space>cp` / `<Space>cn` | Older / newer quickfix result list |
| `<C-o>` / `<C-i>` | Back / forward through Neovim's jump history |
| `]m` / `[m` | Next / previous function start |
| `]M` / `[M` | Next / previous function end |
| `]c` / `[c` | Next / previous class-like construct |
| `af` / `if` | Around / inside a function text object |
| `ac` / `ic` | Around / inside a class text object |
| `aa` / `ia` | Around / inside a parameter text object |

Word and Git-file searches use the current file's Git root, falling back to its nearest Cargo/package root and then the working directory. Directory search accepts an absolute path or a path relative to Neovim's working directory. Text searches respect ripgrep's default ignore rules, so ignored build output and dependencies are excluded. Existing `<Space>fg` searches from the working directory.

In Telescope, use Tab to select multiple results, then Ctrl+q to keep them in quickfix while exploring files. The quickfix panel stays available until closed or replaced; its older lists can be revisited during the current session.

Implementation, type, and call navigation require an attached language server and support for the requested operation. Tree-sitter movement and text objects require an installed parser and the textobjects plugin's queries; supported constructs vary by language. Use text objects in visual mode or after an operator, for example `vaf` to select a function or `cia` to change a parameter. Movements record jump history, so Ctrl+o returns to your previous location. On some terminals Ctrl+i is the same key as Tab.

### Build tasks, tests, and project replacement

| Key | Action |
| --- | --- |
| `<Space>rr` | Select a discovered project task, including npm scripts |
| `<Space>ro` | Toggle the Overseer task list |
| `<Space>ra` | Select a task action, such as rerun, stop, or inspect output |
| `<Space>rc` / `<Space>rb` / `<Space>rt` | Run Cargo check / build / test |
| `<Space>Tn` | Run the nearest test |
| `<Space>Tf` | Run tests in the current file |
| `<Space>Ts` | Run the test suite |
| `<Space>Tl` | Rerun the last test |
| `<Space>Tv` | Return to the last test file |
| `<Space>le` | Apply available ESLint fixes in the current buffer |
| `<Space>fR` | Open project search and replace |

Task/test shortcuts save the current modified buffer before running. Save other edited files before testing changes across multiple files. Cargo task shortcuts use the current file's nearest `Cargo.toml`; the task picker uses its nearest Cargo/package/Git root, falling back to the working directory. Overseer exposes project-defined npm scripts so script names do not need to be hard-coded. Inspect task output and rerun or stop jobs through its task list.

Focused tests use vim-test's runner detection for Cargo and supported JavaScript/TypeScript frameworks, including Jest and Vitest. Install your project's test dependencies first and launch Neovim from the crate/package root. In monorepos, use `:cd path/to/package` when necessary. If detection is ambiguous, set `vim.g["test#javascript#runner"] = "vitest"` (or `"jest"`) for your project. Test output appears in a terminal split in normal mode. Rust file-level test selection uses module filters; behavior can vary for integration tests and unusual module layouts. This integration provides command execution and terminal output, rather than a structured test tree.

Mason automatically installs `eslint-lsp`, the language-server bridge. Each JS/TS project must also provide ESLint and a compatible configuration, for example via its existing development dependencies and `eslint.config.js`. The ESLint server supplies diagnostics and code actions alongside TypeScript. `<Space>le` applies supported ESLint fixes manually; no automatic fixes or format-on-save are enabled.

Project replacement opens grug-far scoped to the current file's Git root (or nearest Cargo/package root). Enter Search and Replace text, review matches, and use the buffer's action help to apply replacements. With the default local leader (`\`), `\r` applies replacement and `\q` sends results to quickfix. Ripgrep syntax and ignore rules apply. Replacement writes files on disk; save current edits before applying it. Use Git diffs to review the result.

### Editing conveniences

Undo history is saved across editor restarts using Neovim's undo directory (`:set undodir?` shows its location). Yanked text briefly highlights, and reopening an existing file restores its last cursor position when a valid saved mark exists. In visual mode, `<` and `>` indent while retaining the selection. Cursor marks are persisted by Neovim's normal ShaDa behavior; undo and cursor history are separate from workspace sessions.

### Sessions

Persistence starts saving sessions once an existing file is opened. On exit, it saves the workspace if at least one named file buffer is present. Restore is manual, so launching Neovim does not automatically reopen a previous workspace.

| Key | Action |
| --- | --- |
| `<Space>pr` | Restore the session for the current working directory and Git branch |
| `<Space>ps` | Select a saved project session |
| `<Space>pl` | Restore the most recently saved session |
| `<Space>pd` | Disable automatic session saving for this run |

Start Neovim from the project root so sessions are associated with that directory. Sessions are stored under `stdpath("state") .. "/sessions/"` (normally `~/.local/state/nvim/sessions/`), outside this repository. Git branch sessions are enabled; Persistence uses the directory session for `main`/`master` and as a fallback when a branch session does not exist. Selecting a session changes the working directory to that project.

Sessions use Neovim's `sessionoptions` to restore file buffers, windows, tabs, and cursor positions. They do not save unsaved file contents or resume running terminals and debugger processes. Save your edits before restoring another workspace. Session saving does not delete an existing session when disabled with `<Space>pd`.

### Windows and buffers

| Key | Action |
| --- | --- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Focus the window to the left / below / above / right |
| `<Space>sv` | Create a vertical split |
| `<Space>sh` | Create a horizontal split |
| `<Space>se` | Equalize window sizes |
| `<Space>sc` | Close the current window |
| `<C-Up>` / `<C-Down>` | Increase / decrease window height by two lines |
| `<C-Right>` / `<C-Left>` | Increase / decrease window width by two columns |
| `<Space>bn` / `<Space>bp` | Next / previous listed buffer |
| `<Space>bb` | Switch to the alternate (previously used) buffer |
| `<Space>bd` | Delete the current buffer with `:bdelete` |
| `<Space>z` | Toggle the centered layout (no-neck-pain) |

Window and buffer close actions do not force-discard unsaved changes. `:bdelete` can also close windows displaying that buffer. Use `<Space>fb` to choose a buffer with Telescope. On macOS, system shortcuts may intercept Ctrl-arrow keys; Neovim's built-in `<C-w>+`, `<C-w>-`, `<C-w>>`, and `<C-w><` also resize windows. These mappings apply in normal mode; leave terminal input mode first with `<C-\><C-n>`.

### Language support and diagnostics

| Key | Action |
| --- | --- |
| `K` | Show hover documentation |
| `gd` | Go to definition |
| `gr` | Find references using the native LSP action |
| `<Space>lD` | Find definitions with Telescope |
| `<Space>lr` | Rename symbol |
| `<Space>lR` | Find references with Telescope |
| `<Space>la` | Show code actions |
| `<Space>lf` | Format the buffer or visual selection with Conform, using LSP formatting as a fallback; available without an attached LSP |
| `<Space>ls` | Search document symbols |
| `<Space>lS` | Search workspace symbols |
| `[d` / `]d` | Previous / next diagnostic |
| `<Space>ld` | Show diagnostic details in a floating window |

Use `<Space>lr` for rename and `<Space>lR` for the Telescope references picker. `gr` also finds references using the native LSP action.

Formatting is manual: press `<Space>lf` in normal mode for the buffer, or in visual mode for a selection (when the formatter supports ranges). No attached language server is required. Prettier handles JavaScript/JSX, TypeScript/TSX, JSON/JSONC, CSS/SCSS, HTML, YAML, and Markdown. Conform prefers a project's `node_modules/.bin/prettier`, then falls back to Prettier on Neovim's `PATH`, including a Mason installation. Project formatter configuration files are respected.

Prettier and StyLua are installed automatically through Mason. You can also add Prettier to a project's development dependencies with `npm install --save-dev --save-exact prettier`. For Rust, install the formatter with `rustup component add rustfmt`. A Homebrew installation of StyLua is optional because Mason provides it. Use `:ConformInfo` to check executable availability; missing formatters produce a notification when no LSP fallback is available.

### Completion and snippets

These mappings apply in insert mode; Tab and Shift-Tab also work in snippet select mode.

| Key | Action |
| --- | --- |
| `<C-Space>` | Open completion suggestions |
| `<C-n>` / `<C-p>` | Select the next / previous suggestion |
| `<CR>` | Confirm an explicitly selected suggestion |
| `<C-e>` | Close completion suggestions |
| `<Tab>` | Select the next suggestion, otherwise expand or advance through a snippet, otherwise use normal Tab behavior |
| `<S-Tab>` | Select the previous suggestion, otherwise jump to the previous snippet placeholder, otherwise use normal Shift-Tab behavior |

Comment.nvim uses its default mappings: `gcc` toggles the current line comment, `gc` operates on a motion or visual selection, and `gbc` toggles a block comment.

### Git

| Key | Action |
| --- | --- |
| `[h` / `]h` | Previous / next Git hunk |
| `<Space>hp` | Preview the current hunk |
| `<Space>hs` | Stage the current hunk |
| `<Space>hu` | Reset the current hunk, discarding its unstaged changes |

### Git review and conflict resolution

| Key | Action |
| --- | --- |
| `<Space>gd` | Open changed-file review, including conflicts during a merge/rebase |
| `<Space>gc` | Close Diffview |
| `<Space>gb` | Prompt for a revision/range to compare, such as `origin/main...HEAD` |
| `<Space>gh` / `<Space>gf` | Project / current-file Git history |
| `<Space>gp` in a diff view | Focus the changed-files panel |
| Tab / Shift-Tab in Diffview | Next / previous entry |
| `]x` / `[x` in a diff view | Next / previous conflict |
| `<Space>gO` / `<Space>gT` in a diff view | Choose ours / theirs for the current conflict |

Requires Git 2.31 or newer. Use j/k and Enter in the file/history panels to select entries. During a merge or rebase, Diffview opens a three-way conflict view. Resolve the result buffer and save it, then stage the resolved file and continue the Git operation yourself. The mappings do not commit or continue a merge automatically. Existing `<Space>h` mappings still operate on Git hunks.

### Project bookmarks

| Key | Action |
| --- | --- |
| `<Space>ma` | Add the current file to bookmarks |
| `<Space>mm` | Open the editable bookmark menu |
| `<Space>m1` through `<Space>m4` | Jump to bookmark 1 through 4 |
| `<Space>mn` / `<Space>mp` | Next / previous bookmark |

Bookmarks are grouped by working directory and persisted by Harpoon outside the repository. Start Neovim from the project root to keep a consistent list. In the menu, edit/reorder/delete lines and close it to sync the list; Enter opens the selected file.

### Surround editing

Use normal-mode operators such as `ysiw"` to surround a word with double quotes, `cs"'` to change double quotes to single quotes, and `ds"` to remove surrounding double quotes. In visual mode, `S` followed by a delimiter surrounds the selection. See `:help nvim-surround` for bracket, tag, and custom delimiter operations.

### Markdown rendering

Markdown files render in the buffer automatically. Press `<Space>M` in a markdown buffer to toggle between rendered and raw views. See `:help render-markdown` for options.

### Debugging

| Key | Action |
| --- | --- |
| `<Space>db` | Toggle a breakpoint |
| `<Space>dc` | Start or continue debugging |
| `<Space>dn` | Step over |
| `<Space>di` | Step into |
| `<Space>do` | Step out |
| `<Space>dt` | Terminate the debug session |
| `<Space>du` | Toggle the debugger UI |

Wait for the automatic Mason adapter installations to finish before debugging. Open the debugger UI manually with `<Space>du`.

- **Rust:** Run `cargo build`, open a Rust source file, and start debugging. The launch configuration prompts for the executable, initially under the current directory's `target/debug/`. Start Neovim from the crate or workspace root.
- **JavaScript:** Open the JavaScript file to run and start debugging. The adapter launches the current file with Node.js, using the workspace directory.
- **TypeScript:** Compile the project to JavaScript with source maps enabled, open a TypeScript source file, and start debugging. Select the emitted JavaScript entry point when prompted (the default directory is `<project>/dist/`). This configuration launches compiled JavaScript, searches project JavaScript files for source maps, and stops on entry. It does not run TypeScript directly.

## Configuration layout

```text
init.lua                 Loads the core configuration and plugin manager
lua/config/options.lua   Editor options
lua/config/keymaps.lua   General, LSP, diagnostic, and debugger mappings
lua/config/diagnostics.lua Diagnostic display settings
lua/config/project.lua   :ProjectRoot command
lua/config/lazy.lua      lazy.nvim bootstrap and plugin discovery
lua/plugins/             Plugin specifications and feature configuration
```

Add or edit plugin specifications under `lua/plugins/`. Keep `lazy-lock.json` in Git alongside configuration changes so fresh installations use the recorded plugin revisions. Use `:Lazy restore` after pulling changes to match the lockfile, and `:Lazy update` for intentional upgrades. Review and commit lockfile changes with the corresponding configuration changes. This locks plugin code; Mason tools, project dependencies, and external executables have separate version management.
