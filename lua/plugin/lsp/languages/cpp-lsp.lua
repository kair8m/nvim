local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
	capabilities.offsetEncoding = { "utf-16" }
	lspconfig["clangd"].setup({
		cmd = {
			-- see clangd --help-hidden
			"clangd",
			"--background-index",
			-- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
			-- to add more checks, create .clang-tidy file in the root directory
			-- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
			"--clang-tidy",
			"--completion-style=bundled",
			"--cross-file-rename",
			"--header-insertion=iwyu",
		},
		capabilities = capabilities,
		init_options = {
			clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
			usePlaceholders = true,
			completeUnimported = true,
			semanticHighlighting = true,
		},
		on_attach = on_attach,
	})
end

return M
