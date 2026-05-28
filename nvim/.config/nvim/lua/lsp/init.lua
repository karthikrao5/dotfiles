local servers = { "luals" }

-- =========================================
--  Autocompletion (nvim-cmp) ΓÇö must come BEFORE LSP config
-- =========================================
local cmp = require("cmp")


for _, server in ipairs(servers) do
  local cfg = require("lsp.servers." .. server)
  local capabilities = require("cmp_nvim_lsp").default_capabilities() -- Γ£à Now safe to call

  vim.lsp.config(server, vim.tbl_deep_extend('force', cfg, {
    capabilities = capabilities
  }))
  vim.lsp.enable(server)
end
