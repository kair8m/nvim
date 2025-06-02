local M = {}


M.setup = function(capabilities, on_attach)
    vim.lsp.config.kotlin_language_server = {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    vim.lsp.enable("kotlin_language_server")
end

return M
