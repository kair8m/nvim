local M = {}


M.setup = function(lspconfig, capabilities, on_attach)
    lspconfig["kotlin_language_server"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

return M
