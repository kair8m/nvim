local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
    lspconfig.ts_ls.setup({
        server = {
            capabilities = capabilities,
            on_attach = on_attach,
        },
    })
end

return M
