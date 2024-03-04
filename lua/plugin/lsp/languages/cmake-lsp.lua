local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
    local configs = require("lspconfig.configs")
    configs.neocmake = {
        default_config = {
            cmd = { "neocmakelsp", "--stdio" },
            filetypes = { "cmake" },
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end,
            single_file_support = true, -- suggested
            on_attach = on_attach, -- on_attach is the on_attach function you defined
            capabilities = capabilities,
        },
    }
    lspconfig["neocmake"].setup({})
end

return M
