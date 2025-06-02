local M = {}

M.setup = function(capabilities, on_attach)
    vim.lsp.config.dockerls = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            docker = {
                languageserver = {
                    formatter = {
                        ignoreMultilineInstructions = true,
                    },
                },
            },
        },
    }
    vim.lsp.config.docker_compose_language_service = {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    vim.lsp.enable({ "dockerls", "docker_compose_language_service" })
end

return M
