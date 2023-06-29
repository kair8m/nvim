local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		formatting.prettier,
		formatting.stylua,
		formatting.clang_format,
		formatting.cmake_format,
		formatting.autopep8,
		formatting.shfmt,
		formatting.beautysh,
		formatting.rustfmt,
		diagnostics.eslint,
		diagnostics.cmake_lint,
		-- diagnostics.codespell,
		-- diagnostics.cpplint,
	},
})

local whichkey = require("which-key")
whichkey.register({
	l = { f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format file using lsp" } },
}, { prefix = "<leader>" })
