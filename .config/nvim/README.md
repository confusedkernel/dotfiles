# Neovim

Neovim setup managed with `yadm`, built around `lazy.nvim` and a domain-split plugin spec layout.

## Structure

```text
init.lua
lua/
  options.lua
  keymap.lua
  autocmds.lua
  commands.lua
  color-mode.lua
  plugins/
    init.lua
    helpers.lua
    ui.lua
    lsp.lua
    editing.lua
    git.lua
    telescope.lua
    treesitter.lua
    tools.lua
    config/
      *.lua
```

### Core Modules

- `lua/options.lua`: editor options only
- `lua/keymap.lua`: global keymaps
- `lua/autocmds.lua`: grouped autocommands
- `lua/commands.lua`: user commands (`UseLight`, `UseDark`, `ColorToggle`)
- `lua/color-mode.lua`: light/dark colorscheme helpers

### Plugin Layout

- Specs are split by domain in `lua/plugins/*.lua`
- Runtime plugin setup lives in `lua/plugins/config/*.lua`
- `lua/plugins/init.lua` merges all domain specs and is loaded by `init.lua`

## Plugin Management

- Bootstrap handled automatically in `init.lua`
- Open Neovim and run:
  - `:Lazy sync` to install/update plugins
  - `:Lazy clean` to remove unused plugins
  - `:Lazy profile` to inspect startup/load costs

## Key Behaviors

- Colors:
  - Default startup: `catppuccin-latte`
  - Auto dark mode plugin is enabled
  - Manual commands: `:UseLight`, `:UseDark`, `:ColorToggle`
- Formatting:
  - `Neoformat` runs on save only for selected filetypes (configured in `lua/plugins/config/lsp.lua`)
- Directory open:
  - Opening Neovim with a directory triggers Telescope file browser on startup

## Notes

- This repo is managed with `yadm`; use feature branches for refactors.
- If you add new plugins, place the spec in the matching domain file and create/update its config in `lua/plugins/config/`.
