local M = {}

local jdtls_path = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

M.setup = function(lspconfig, capabilities, on_attach)
    lspconfig["jdtls"].setup({
        cmd = { jdtls_path },
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

return M
