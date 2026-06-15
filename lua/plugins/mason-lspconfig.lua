vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
            hint = { enable = true },
        },
    },
}

vim.lsp.config.htmlls = {}

vim.lsp.config.ts_ls = {}

vim.lsp.config.cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss" },
    root_markers = { "package.json", ".git" },
    init_options = { provideFormatter = true },
}

vim.lsp.config.tailwindcssls = {
    cmd = { "tailwindcss-language-server", "--stdio" },
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
            classAttributes = {
                "class",
                "className",
                "class:list",
                "classList",
                "ngClass",
            },
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

vim.lsp.config.basedpyright = {
    name = "basedpyright",
    filetypes = { "python" },
    cmd = { "basedpyright-langserver", "--stdio" },
    settings = {
        python = { venvPath = vim.fn.expand("~") .. "/.virtualenvs" },
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                inlayHints = {
                    variableTypes = true,
                    callArgumentNames = true,
                    functionReturnTypes = true,
                    genericTypes = true,
                },
            },
        },
    },
}

local clangd_path = vim.fn.stdpath("data") .. "/mason/bin/clangd"
vim.lsp.config.clangd = {
    cmd = {
        clangd_path,
        "--background-index",
        "--clang-tidy",
        "--completion-style=bundled",
        "--cross-file-rename",
        "--header-insertion=iwyu",
        "--inlay-hints=true",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
        inlayHints = true,
    },
}

local neocmakelsp_path = vim.fn.stdpath("data") .. "/mason/bin/neocmakelsp"
vim.lsp.config.neocmake = {
    cmd = { neocmakelsp_path, "--stdio" },
    filetypes = { "cmake" },
    single_file_support = true,
}

vim.lsp.config.bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh", "zsh" },
}

local jdtls_path = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
vim.lsp.config.jdtls = { cmd = { jdtls_path } }

vim.lsp.config.kotlin_language_server = {}

vim.lsp.config.dockerls = {
    settings = {
        docker = {
            languageserver = {
                formatter = { ignoreMultilineInstructions = true },
            },
        },
    },
}

vim.lsp.config.docker_compose_language_service = {}

vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    workspace_required = true,
    settings = {
        autoformat = false,
        ["rust-analyzer"] = { check = { command = "clippy" } },
    },
}

vim.lsp.enable({
    "lua_ls",
    "htmlls",
    "ts_ls",
    "cssls",
    "tailwindcssls",
    "basedpyright",
    "clangd",
    "neocmake",
    "bashls",
    "jdtls",
    "kotlin_language_server",
    "dockerls",
    "docker_compose_language_service",
    "rust_analyzer",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            local opts = { noremap = true, silent = true, buffer = args.buf }
            vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts)
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            vim.keymap.set("n", "gy", "<cmd>Lspsaga peek_type_definition<cr>", opts)
            vim.keymap.set("n", "gr", "<cmd>Lspsaga finder tyd+ref+imp+def<cr>", opts)
            vim.keymap.set("n", "rn", "<cmd>Lspsaga rename<cr>", opts)
            vim.keymap.set("n", "<C-a>", "<cmd>Lspsaga code_action<cr>", opts)
            vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", opts)
            vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
            vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
            vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
        end
    end,
})

vim.lsp.inlay_hint.enable(true)

return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        automatic_enable = true,
    },
    dependencies = {
        { "williamboman/mason.nvim", opts = {} },
        { "neovim/nvim-lspconfig", lazy = false },
    },
}
