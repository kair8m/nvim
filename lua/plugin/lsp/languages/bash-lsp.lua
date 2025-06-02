local M = {}

M.setup = function(capabilities, on_attach)
    vim.lsp.config.bashls = {
        cmd = { "bash-language-server", "start" },
        filetypes = { "bash", "sh", "zsh" },
        capabilities = capabilities,
        on_attach = on_attach,
    }
    vim.lsp.enable("bashls")
end

return M
