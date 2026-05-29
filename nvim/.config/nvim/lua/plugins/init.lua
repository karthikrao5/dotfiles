vim.pack.add({
  { src = 'https://github.com/nvim-lua/plenary.nvim' }
})

vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

require('plugins.telescope')
require('plugins.blink')
require('plugins.oil')
require('plugins.treesitter')

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
	}
})
