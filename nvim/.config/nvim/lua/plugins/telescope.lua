return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-symbols.nvim',
    'nvim-tree/nvim-web-devicons'
  },
  defaults = {
    file_ignore_patterns = {
      "^node_modules/",
      ".history/"
    }
  },
  config = function()
    -- require("telescope").load_extension("flutter")

    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")
    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
    telescope.setup({
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })
  end,
  keys = {                  -- disable the keymap to grep files
    { "<leader>/", false }, -- change a keymap
    {
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      desc = "Find Files"
    }, -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({
          cwd = require("lazy.core.config").options.root
        })
      end,
      desc = "Find Plugin File"
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Find live grep"
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Find buffers"
    },
    {
      "<leader>gs",
      function()
        require("telescope.builtin").grep_string({
          search = vim.fn.input("Grep > ")
        })
      end,
      desc = "Grep string search"
    },
    {
      "<leader>gf",
      function()
        require("telescope.builtin").live_grep({
          search = vim.fn.input("Grep > ")
        })
      end,
      desc = "Search in files"
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Buffers find"
    } }
}
