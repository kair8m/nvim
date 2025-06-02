local M = {}

M.setup = function(capabilities, on_attach)
    vim.lsp.config.htmlls = {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    vim.lsp.enable("htmlls")
end

return M
