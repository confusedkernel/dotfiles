# Plugin Layout

This directory is the plugin spec entrypoint for this Neovim config.

## How It Is Organized

- `init.lua`: imports each domain spec file and merges them into one list for `lazy.nvim`.
- `helpers.lua`: shared helper for loading config modules (`plugin_config("...")`).
- Domain spec files:
  - `ui.lua`
  - `lsp.lua`
  - `editing.lua`
  - `git.lua`
  - `telescope.lua`
  - `treesitter.lua`
  - `tools.lua`
- Most runtime plugin setup lives in `lua/plugins/config/*.lua`.

## Plugin Catalog (All Plugins)

### UI (`ui.lua`)

- `nvim-lualine/lualine.nvim`: statusline.
- `f-person/auto-dark-mode.nvim`: auto-switches light/dark theme by system appearance.
- `nvim-tree/nvim-web-devicons`: filetype icons used by multiple UI plugins.
- `catppuccin/nvim`: light theme base (`catppuccin-latte`).
- `AlexvZyl/nordic.nvim`: dark theme base.
- `romgrk/barbar.nvim`: buffer/tab line management.
- `Bekaboo/dropbar.nvim`: breadcrumb winbar/navigation bar.
- `nvim-telescope/telescope-fzf-native.nvim` (dependency): native fzf sorter for Telescope.
- `nvim-tree/nvim-tree.lua`: file explorer tree.
- `confusedkernel/nvchad-ui.nvim`: dashboard/theming UI layer.

### LSP (`lsp.lua`)

- `mrcjkb/rustaceanvim`: Rust LSP tooling integration.
- `mrcjkb/haskell-tools.nvim`: Haskell LSP/repl tooling integration.
- `folke/lazydev.nvim`: Lua/Neovim dev library typing support.
- `neovim/nvim-lspconfig`: LSP client/server configuration backbone.
- `williamboman/mason.nvim` (dependency): LSP/tool installer UI.
- `williamboman/mason-lspconfig.nvim` (dependency): Mason bridge for `lspconfig`.
- `hrsh7th/cmp-nvim-lsp` (dependency): LSP completion capabilities for `nvim-cmp`.
- `j-hui/fidget.nvim` (dependency): LSP progress notifications.
- `lukas-reineke/lsp-format.nvim`: LSP formatting helper.

### Editing (`editing.lua`)

- `numToStr/Comment.nvim`: comment toggling.
- `windwp/nvim-autopairs`: auto-close bracket/quote pairs.
- `mg979/vim-visual-multi`: multi-cursor editing.
- `tpope/vim-surround`: surround text objects.
- `mbbill/undotree`: undo history tree view.
- `andyg/leap.nvim` (Codeberg): fast two-character motions.
- `tpope/vim-repeat` (dependency): repeat plugin actions with `.`.
- `lukas-reineke/indent-blankline.nvim`: indent guides.
- `chrisgrieser/nvim-origami`: fold UX enhancements.
- `hrsh7th/nvim-cmp`: completion menu engine.
- `L3MON4D3/LuaSnip`: snippet engine.
- `saadparwaiz1/cmp_luasnip` (dependency): snippet source for `nvim-cmp`.
- `rafamadriz/friendly-snippets` (dependency): snippet collection.
- `tpope/vim-sleuth`: auto-detect indentation style.
- `folke/which-key.nvim`: keymap hint popup.

### Git (`git.lua`)

- `lewis6991/gitsigns.nvim`: inline git change signs and hunk actions.
- `tpope/vim-fugitive`: git commands and status buffers.
- `sindrets/diffview.nvim`: side-by-side git diff UI.
- `nvim-lua/plenary.nvim` (dependency): Lua utility library used by git plugins.
- `wintermute-cell/gitignore.nvim`: generate `.gitignore` templates.

### Telescope (`telescope.lua`)

- `nvim-telescope/telescope.nvim`: fuzzy finder and picker framework.
- `nvim-lua/plenary.nvim` (dependency): shared Lua utility library.
- `debugloop/telescope-undo.nvim` (dependency): undo history picker extension.
- `nvim-telescope/telescope-file-browser.nvim` (dependency): file browser extension.
- `nvim-telescope/telescope-fzf-native.nvim` (dependency): native sorter extension.

### Treesitter (`treesitter.lua`)

- `nvim-treesitter/nvim-treesitter`: syntax tree parsing/highlighting engine.
- `OXY2DEV/markview.nvim`: markdown/typst/latex inline preview renderer.
- `nvim-tree/nvim-web-devicons` (dependency): icons for markdown rendering.

### Tools (`tools.lua`)

- `krivahtoo/silicon.nvim`: create code screenshots.
- `lukoshkin/highlight-whitespace`: visualize whitespace issues.
- `uga-rosa/ccc.nvim`: color picker/highlighter.
- `sbdchd/neoformat`: external formatter dispatcher.
- `akinsho/toggleterm.nvim`: floating/split terminal management.
- `folke/todo-comments.nvim`: highlight and search TODO-like comments.
- `nvim-lua/plenary.nvim` (dependency): utility library used by tools.
- `nvim-pack/nvim-spectre`: project-wide search/replace UI.
- `RaafatTurki/hex.nvim`: open/edit files in hex mode.
- `obsidian-nvim/obsidian.nvim`: Obsidian vault integration.

## Notes

- Plugin-specific options usually go in `lua/plugins/config/<name>.lua`; trivial plugins may use `opts = {}` directly in specs.
- Shared keymaps are centralized in `lua/keymap.lua` with plugin-labeled sections.
