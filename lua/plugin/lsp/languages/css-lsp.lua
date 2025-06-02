local M = {}

M.setup = function(capabilities, on_attach)
    vim.lsp.config.cssls = {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss" },
        root_markers = { "package.json", ".git" },
        init_options = {
            provideFormatter = true,
        },
    }

    vim.lsp.config.tailwindcssls = {
        cmd = { "tailwindcss-language-server", "--stdio" },
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
            "ejs",
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        root_markers = {
            "tailwind.config.js",
            "tailwind.config.cjs",
            "tailwind.config.mjs",
            "tailwind.config.ts",
            "postcss.config.js",
            "postcss.config.cjs",
            "postcss.config.mjs",
            "postcss.config.ts",
            "package.json",
            "node_modules",
        },
        settings = {
            tailwindCSS = {
                classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                includeLanguages = {
                    eelixir = "html-eex",
                    eruby = "erb",
                    htmlangular = "html",
                    templ = "html",
                },
                lint = {
                    cssConflict = "warning",
                    invalidApply = "error",
                    invalidConfigPath = "error",
                    invalidScreen = "error",
                    invalidTailwindDirective = "error",
                    invalidVariant = "error",
                    recommendedVariantOrder = "warning",
                },
                validate = true,
            },
        },
    }
    vim.lsp.enable({ "cssls", "tailwindcssls" })
end

return M
