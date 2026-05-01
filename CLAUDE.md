# Dotfiles

GNU Stow-managed dotfiles for macOS. Each top-level directory is a stow package that mirrors the target home directory structure.

## Repository structure

```
dotfiles/
├── .zshrc          # Zsh config (stowed directly to ~/)
├── nvim/           # Neovim package → ~/.config/nvim/
│   └── .config/nvim/
└── tmux/           # Tmux package → ~/.config/tmux/ (currently empty)
    └── .config/tmux/
```

## Stow usage

From the repo root, symlink a package:
```sh
stow nvim      # links nvim/.config/nvim → ~/.config/nvim
stow tmux
```

Remove symlinks:
```sh
stow -D nvim
```

## Shell (`~/.zshrc`)

- **Framework:** oh-my-zsh, theme `robbyrussell`
- **Plugins:** `git`, `aws`, `z`
- **Aliases:** `vim` → `nvim`, `zshconfig` → `nvim ~/.zshrc`
- **Runtimes managed:** nvm, pyenv, conda (miniconda3), Flutter (`~/flutter/bin`), gcloud SDK
- **Other:** LM Studio CLI on PATH, `fastfetch` runs on shell start

## Neovim (`nvim/.config/nvim/`)

### Entry point

`init.lua` loads in order: `core.lsp` → `core.options` → `config.autocmds` → `core.lazy` → `core.keymap`

### Plugin manager

`lazy.nvim` (auto-installed on first run). Plugins live in `lua/plugins/`, each file returns a lazy spec.

### LSP

Built-in `vim.lsp` (Neovim 0.11+) managed by Mason. Enabled servers:

| Server | Language |
|---|---|
| `lua_ls` | Lua |
| `pyright` | Python |
| `ts_ls` | TypeScript / JavaScript |
| `tailwindcss` | Tailwind CSS |
| `bash-language-server` | Bash |
| `prisma-language-server` | Prisma |

Custom LSP user commands: `:LspInfo`, `:LspStatus`, `:LspRestart`, `:LspCapabilities`, `:LspDiagnostics`

### Plugins

| Plugin | Purpose |
|---|---|
| `telescope.nvim` | Fuzzy finder (files, grep, buffers) |
| `oil.nvim` | File explorer (edit filesystem like a buffer) |
| `harpoon` | File bookmarks / quick navigation |
| `blink.nvim` | Completion |
| `nvim-treesitter` | Syntax highlighting / parsing |
| `gitsigns.nvim` | Git gutter signs |
| `lualine.nvim` | Status line |
| `which-key.nvim` | Keymap hint popup |
| `nvim-autopairs` | Auto bracket/quote pairing |
| `Comment.nvim` | Code commenting |
| `mason.nvim` | LSP/tool installer |
| `lazydev.nvim` | Lua development for Neovim config |
| `buffer_manager` | Buffer list management |
| `indent-blankline` | Indent guides |
| `flutter-tools.nvim` | Flutter / Dart support |
| `claude-code.nvim` | Claude Code terminal integration |

### Key options

- Leader: `<Space>`
- Relative line numbers, 2-space indent, system clipboard, persistent undo
- `netrw` disabled (oil.nvim used instead)
- Spell checking enabled for `.txt`, `.md`, `.tex`

### Keymaps

| Key | Action |
|---|---|
| `<C-k>` / `<C-j>` | Next / previous buffer |
| `<C-x>` | Save and close (`:x`) |
| `-` | Open parent directory in Oil |
| `<Space>-` | Toggle Oil floating window |
| `<leader>ff` | Telescope find files |
| `<leader>fg` | Telescope live grep |
| `<leader>fb` | Telescope buffers |
| `<leader>gs` | Grep string |
| `<leader>la` | LSP code action |
| `<leader>lr` | LSP rename |
| `<leader>lf` | LSP format |
| `<leader>v` | Go to definition in vertical split |
| `<leader>cc` | Toggle Claude Code terminal |
| `<C-,>` | Toggle Claude Code (normal + terminal mode) |
| `<leader>cC` | Claude Code with `--continue` |
| `K` | Hover documentation |
| `gl` | Open diagnostic float |
| `gD` | Go to declaration |
| `gi` | Go to implementation |

### Statusline

Custom statusline (defined in `core/lsp.lua`) showing: git branch · filename · modified · linter · formatter · LSP clients · line:col · percentage.

## Tmux (`tmux/.config/tmux/`)

Config directory exists but `tmux.conf` is currently empty.
