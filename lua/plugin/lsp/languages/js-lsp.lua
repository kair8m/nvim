local M = {}

M.setup = function(capabilities, on_attach)
    vim.lsp.config.ts_ls = {
        server = {
            capabilities = capabilities,
            on_attach = on_attach,
        },
    }
    vim.lsp.enable("ts_ls")
end

return M
