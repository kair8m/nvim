return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "onsails/lspkind.nvim",
        "glepnir/lspsaga.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "andersevenrud/cmp-tmux",
        "saadparwaiz1/cmp_luasnip",
    },
    opts = {
        automatic_enable = true,
    },
    config = function()
        require("mason").setup()

        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

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

        local ok, lspsaga = pcall(require, "lspsaga")
        if not ok then
            return
        end

        lspsaga.setup({
            definition = {
                keys = {
                    edit = "<CR>",
                },
                save_pos = true,
            },
            finder = {
                max_height = 0.5,
                min_width = 30,
                force_max_height = false,
                methods = {
                    "textDocument/typeDefinition",
                },
                keys = {
                    edit = "<CR>",
                },
                silent = true,
            },
            request_timeout = 5000,
            rename = {
                quit = "<Esc>",
            },
            ui = {
                border = "rounded",
            },
            outline = {
                auto_resize = true,
                keys = {
                    expand_or_jump = "<CR>",
                    quit = "q",
                },
            },
            lightbulb = {
                sign = false,
            },
        })

        vim.opt.completeopt = { "menu", "menuone", "noselect" }
        vim.o.pumheight = 10

        local from_vscode_ok = pcall(require, "luasnip.loaders.from_vscode")
        if from_vscode_ok then
            require("luasnip.loaders.from_vscode").lazy_load()
        end

        local cmp_ok, cmp = pcall(require, "cmp")
        if not cmp_ok then
            return
        end

        local luasnip_ok, luasnip = pcall(require, "luasnip")
        if not luasnip_ok then
            return
        end
        luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

        local lspkind_ok, lspkind = pcall(require, "lspkind")
        if not lspkind_ok then
            return
        end

        local select_opts = { behavior = cmp.SelectBehavior.Select }
        local MAX_WIDTH = 40

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.None,
            completion = { completeopt = "menu,menuone,noselect" },
            experimental = { ghost_text = true },
            sources = {
                {
                    name = "nvim_lsp_signature_help",
                    priority = 10,
                    group_index = 1,
                },
                {
                    name = "nvim_lsp",
                    priority = 10,
                    group_index = 1,
                },
                {
                    name = "copilot",
                    group_index = 1,
                    priority = 10,
                },
                {
                    name = "luasnip",
                    option = {
                        use_show_condition = true,
                        show_autosnippets = true,
                    },
                    priority = 9,
                    group_index = 1,
                },
                {
                    name = "nvim_lua",
                    priority = 10,
                    group_index = 1,
                },
                {
                    name = "tmux",
                    priority = 8,
                    group_index = 2,
                    option = {
                        all_panes = true,
                    },
                },
                {
                    name = "buffer",
                    priority = 7,
                    group_index = 2,
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                {
                    name = "path",
                    priority = 6,
                    group_index = 2,
                },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = MAX_WIDTH,
                    ellipsis_char = "...",
                    mode = "symbol_text",
                    preset = "default",
                    show_labelDetails = true,
                    before = function(_, vim_item)
                        if vim_item.menu ~= nil then
                            if string.len(vim_item.menu) >= MAX_WIDTH then
                                vim_item.menu = string.sub(vim_item.menu, 1, 40) .. "..."
                                local first = vim_item.menu:sub(1, 1)
                                if
                                    first == "{"
                                    or first == "["
                                    or first == "("
                                    or first == "<"
                                    or first == "'"
                                    or first == '"'
                                then
                                    vim_item.menu = vim_item.menu
                                        .. (
                                            first == "{" and "}"
                                            or first == "[" and "]"
                                            or first == "(" and ")"
                                            or first == "<" and ">"
                                            or first == "'" and "'"
                                            or '"'
                                        )
                                end
                            end
                        end
                        return vim_item
                    end,
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
                ["<Down>"] = cmp.mapping.select_next_item(select_opts),
                ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
                ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
                ["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
                ["<C-j>"] = cmp.mapping.select_next_item(select_opts),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm(),
                ["<C-l>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local col = vim.fn.col(".") - 1
                    if cmp.visible() then
                        cmp.select_next_item(select_opts)
                    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(select_opts)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
        })

        local cmdline_mappings = {
            ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                local col = vim.fn.col(".") - 1
                if cmp.visible() then
                    cmp.select_next_item()
                elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                    fallback()
                else
                    cmp.complete()
                end
            end, { "i", "c" }),
        }

        for _, token in ipairs({ "?", "/" }) do
            cmp.setup.cmdline(token, {
                mapping = cmdline_mappings,
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }, {
                    { name = "nvim_lua" },
                }),
            })
        end

        cmp.setup.cmdline(":", {
            mapping = cmdline_mappings,
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })
        vim.lsp.inlay_hint.enable(true)

        require("mason-lspconfig").setup()
    end,
}
