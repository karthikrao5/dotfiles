return {
	cmd = { "prisma-language-server", "--stdio" },
	filetypes = { "prisma" },
	root_markers = { "schema.prisma" },
	settings = {
		prisma = {
			prismaFmtBinPath = "",
		},
	},
	capabilities = vim.lsp.protocol.make_client_capabilities(),
}
