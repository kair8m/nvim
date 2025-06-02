local M = {}

local neocmakelsp_path = vim.fn.stdpath("data") .. "/mason/bin/neocmakelsp"

M.setup = function(capabilities, on_attach)
    vim.lsp.config("neocmake", {
        cmd = { neocmakelsp_path, "--stdio" },
        filetypes = { "cmake" },
        single_file_support = true, -- suggested
        on_attach = on_attach,
        capabilities = capabilities,
    })
    vim.lsp.enable("neocmake")
end

return M
