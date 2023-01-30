local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
    lspconfig['clangd'].setup {
        init_options = {
            clangdFileStatus = true,
        },
        capabilities = capabilities,
        on_attach = on_attach
    }
end

return M
