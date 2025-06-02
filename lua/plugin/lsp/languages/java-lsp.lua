local M = {}

local jdtls_path = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

M.setup = function(capabilities, on_attach)
    vim.lsp.config.jdtls = {
        cmd = { jdtls_path },
        capabilities = capabilities,
        on_attach = on_attach,
    }
    vim.lsp.enable({ "jdtls" })
end

return M
