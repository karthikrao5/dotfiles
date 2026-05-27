# Neovim Configuration

Neovim 0.11+ config using lazy.nvim. Lua-only, no Vimscript.

## Structure

```
nvim/.config/nvim/
├── init.lua              # Entry point — loads core modules in order
├── lsp/                  # Per-server LSP configs (used by vim.lsp.enable)
└── lua/
    ├── core/
    │   ├── lsp.lua       # LSP setup, diagnostics, statusline, user commands
    │   ├── options.lua   # Editor options
    │   ├── lazy.lua      # Plugin manager bootstrap
    │   └── keymap.lua    # Global keymaps (buffers, etc.)
    ├── config/
    │   ├── autocmds.lua  # Autocommands (LSP attach, spell, highlights, etc.)
    │   └── utils.lua     # Shared utility functions
    └── plugins/          # One file per plugin, each returns a lazy spec
```

Load order in `init.lua`: `core.lsp` → `core.options` → `config.autocmds` → `core.lazy` → `core.keymap`

## LSP

Uses Neovim 0.11 built-in `vim.lsp` (no nvim-lspconfig). Servers are enabled via `vim.lsp.enable()` in `core/lsp.lua`. Per-server configs live in `lsp/<server-name>.lua` and are picked up automatically.

Enabled servers: `lua_ls`, `pyright`, `ts_ls`, `tailwindcss`, `bash-language-server`, `prisma-language-server`.

To add a server:
1. Create `lsp/<server-name>.lua` with `return { cmd = {...}, filetypes = {...}, root_markers = {...} }`
2. Add `vim.lsp.enable("<server-name>")` in `core/lsp.lua`
3. Add the server to mason's `ensure_installed` list in `plugins/mason.lua`

LSP keymaps are attached in `config/autocmds.lua` on the `LspAttach` event (not in individual server configs).

## Adding a Plugin

Create `lua/plugins/<name>.lua` returning a lazy spec table. lazy.nvim auto-discovers all files under `lua/plugins/`. No registration step needed.

## Key Conventions

- Leader: `<Space>`
- Completion: blink.cmp with Copilot integration (`plugins/blink.lua`)
- File explorer: oil.nvim (`-` opens parent, `<Space>-` floating)
- Fuzzy finder: telescope.nvim (`<leader>ff/fg/fb`)
- Buffer navigation: `<C-k>`/`<C-j>` (next/prev), `<C-x>` (close)
- Quick file access: harpoon v2 (`<leader>a` add, `<C-e>` menu)
- Formatting/linting: via mason-installed tools (stylua, prettier, black, eslint_d, etc.)

## Utility Functions (`config/utils.lua`)

- `toggle_go_test()` — switch between Go file and its `_test.go` counterpart
- `copyFilePathAndLineNumber()` — copy `file:line` or GitHub URL if in a git repo; bound to `<leader>lc`

## Statusline

Defined in `core/lsp.lua` (not lualine). Shows: git branch · filename · modified · linter · formatter · LSP clients · line:col · percentage. lualine (`plugins/lualine.lua`) is also present and may be active — check which is configured.

## Colorscheme

catppuccin, loaded with `priority = 1000` in `plugins/colorscheme.lua`.
