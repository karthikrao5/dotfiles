# Neovim 0.12 Upgrade Guide

## Overview

Three areas need changes: the archived nvim-treesitter plugin, a removed LSP API, and a compatibility shim that can be simplified. Everything else (LSP setup, diagnostics, all other plugins) works as-is.

---

## 1. `lua/plugins/nvim-treesitter.lua` — Required

The nvim-treesitter repo was archived in April 2026 because Neovim 0.12 ships treesitter built-in. The plugin's API changed.

**Changes:**
- Add `branch = "main"` to the lazy spec
- Change `require("nvim-treesitter.configs").setup({...})` → `require("nvim-treesitter").setup({...})`
- Remove these keys (they no longer exist):
  - `ensure_installed` — gone; install parsers manually with `:TSInstall <lang>`
  - `sync_install`, `auto_install`, `modules = {}`
  - `highlight = { enable = true }` — now handled by Neovim built-in + the `pcall(vim.treesitter.start)` FileType autocmd already in `autocmds.lua:190`
  - `indent = { enable = true }` — same
- **Keep:** `incremental_selection` and `textobjects` blocks — still supported

After updating, run `:TSInstall lua typescript python bash` (and any other parsers you use) since `ensure_installed` no longer auto-installs them.

**Result:**

```lua
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter").setup({
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>vv",
                        node_incremental = "+",
                        scope_incremental = false,
                        node_decremental = "_",
                    },
                },
                textobjects = {
                    -- (keep your existing textobjects config unchanged)
                },
            })
        end,
    },
}
```

---

## 2. `lua/config/autocmds.lua:132` — Required

`vim.lsp.buf.range_code_action` was removed in 0.12.

**Before:**
```lua
{ "<leader>lA", vim.lsp.buf.range_code_action, desc = "Range Code Actions" },
```

**After:**
```lua
{ "<leader>lA", vim.lsp.buf.code_action, desc = "Range Code Actions", mode = { "n", "v" } },
```

`vim.lsp.buf.code_action` handles visual-mode ranges natively.

---

## 3. `lua/config/autocmds.lua:148–154` — Optional cleanup

The `client_supports_method` compat shim checks for `nvim-0.11`. On 0.12+ only the colon syntax exists, so the else branch is dead code.

**Before:**
```lua
local function client_supports_method(client, method, bufnr)
    if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr)
    else
        return client.supports_method(method, { bufnr = bufnr })
    end
end
```

**After:**
```lua
local function client_supports_method(client, method, bufnr)
    return client:supports_method(method, bufnr)
end
```

---

## 4. `lua/plugins/git-signs.lua` — Cleanup (unrelated to upgrade)

There are two gitsigns files: `git-signs.lua` (minimal stub) and `gitsigns.lua` (full config). The stub causes lazy.nvim to load the plugin twice. Delete `git-signs.lua`.

---

## What does NOT need changing

| Area | Status |
|---|---|
| `lua/core/lsp.lua` | Already uses `vim.lsp.enable()` — the 0.11+ native API |
| Diagnostic config | Already uses `vim.diagnostic.config()` with `signs.text` |
| telescope, oil, blink, mason | No breaking changes in 0.12 |
| lualine, harpoon, which-key | No breaking changes in 0.12 |
| Comment.nvim, flutter-tools | No breaking changes in 0.12 |
| `autocmds.lua:190` `pcall(vim.treesitter.start)` | Already the correct 0.12 pattern |

---

## Verification

1. `:checkhealth` — check treesitter and LSP sections
2. Open a Lua/TypeScript/Python file — confirm syntax highlighting
3. Test textobjects: `vaf` (select around function), `]f` (jump to next function)
4. Test incremental selection: `<leader>vv` then `+`
5. Test LSP: `:LspInfo`, `K` for hover, `<leader>la` for code action
6. In visual mode, confirm `<leader>lA` triggers code actions without error
