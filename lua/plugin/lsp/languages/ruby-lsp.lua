local M = {}

M.setup = function(capabilities, on_attach)
    vim.lsp.config.ruby_lsp = {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    vim.lsp.enable("ruby_lsp")
end

return M
