vim.g.mapleader = " "                                   -- change leader to a space
vim.g.maplocalleader = " "                              -- change localleader to a space

vim.g.loaded_netrw = 1                                  -- disable netrw
vim.g.loaded_netrwPlugin = 1                            --  disable netrw


vim.opt.clipboard = "unnamedplus"                       -- allows neovim to access the system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
vim.opt.mouse = "a"                                     -- allow the mouse to be used in neovim
vim.opt.showmode = false                                -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                                 -- always show tabs
vim.opt.smartcase = true                                -- smart case
vim.opt.smartindent = true                              -- make indenting smarter again
vim.opt.termguicolors = true
vim.opt.undofile = true                                 -- enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"     -- set an undo directory
vim.opt.shiftwidth = 2                                  -- the number of spaces inserted for each indentation
vim.opt.relativenumber = true                           -- set relative numbered lines
vim.opt.numberwidth = 4                                 -- set number column width to 2 {default 4}


vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme catppuccin]])
