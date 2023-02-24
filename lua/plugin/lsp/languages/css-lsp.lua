local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
	lspconfig["cssls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig["tailwindcss"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

return M
