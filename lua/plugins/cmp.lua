return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "andersevenrud/cmp-tmux",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
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
                                if first == "{" or first == "[" or first == "(" or first == "<" or first == "'" or first == '"' then
                                    vim_item.menu = vim_item.menu .. (first == "{" and "}" or first == "[" and "]" or first == "(" and ")" or first == "<" and ">" or first == "'" and "'" or '"')
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
    end,
}
