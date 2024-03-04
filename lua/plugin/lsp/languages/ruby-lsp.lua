local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
    lspconfig["ruby_ls"].setup({
        cmd = { "bundle", "exec", "ruby-lsp" },
        capabilities = capabilities,
        on_attach = function(client, buffer)
            on_attach(client, buffer)
        end,
    })
end

return M
