local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
	lspconfig["cmake"].setup({
		init_options = {
			buildDirectory = "build",
		},
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

return M
