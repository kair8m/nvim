local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
    lspconfig["dockerls"].setup({
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
    })
    lspconfig["docker_compose_language_service"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

return M
