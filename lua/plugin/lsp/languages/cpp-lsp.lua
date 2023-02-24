local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
	capabilities.offsetEncoding = { "utf-16" }
	lspconfig["clangd"].setup({
		init_options = {
			clangdFileStatus = true,
		},
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

return M
