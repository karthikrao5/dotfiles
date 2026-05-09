return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		require("oil").setup {
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),

			vim.keymap.set("n", "<space>-", require("oil").toggle_float),

			view_options = {
				show_hidden = true,
			},

			win_options = {
				signcolumn = "yes:2"
			},

		}
	end

}
