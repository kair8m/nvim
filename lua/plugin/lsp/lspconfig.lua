local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local nvim_cmp_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not nvim_cmp_lsp_status then
    return
end

local navic_status, navic = pcall(require, "nvim-navic")
if not navic_status then
    return
end
local show_references_command = "<cmd>Lspsaga finder tyd+ref+imp+def<cr>"
local peek_definition_command = "<cmd>Lspsaga peek_definition<cr>"
local show_declaration_command = "<cmd>lua vim.lsp.buf.declaration()<cr>"
local show_implementation_command = "<cmd>lua vim.lsp.buf.implementation()<cr>"
local show_type_definition_command = "<cmd>Lspsaga peek_type_definition<cr>"
local code_actions_command = "<cmd>Lspsaga code_action<cr>"
local rename_command = "<cmd>Lspsaga rename<cr>"
local hover_doc_command = "<cmd>Lspsaga hover_doc<cr>"

local show_line_diagnostics = "<cmd>Lspsaga show_line_diagnostics<cr>"
local jump_to_next_diagnostics_finding = "<cmd>Lspsaga diagnostic_jump_next<cr>"
local jump_to_prev_diagnostics_finding = "<cmd>Lspsaga diagnostic_jump_prev<cr>"
local jump_to_next_error = function()
    require("lspsaga.diagnostic").goto_next({
        severity = vim.diagnostic.severity.ERROR,
    })
end
local jump_to_prev_error = function()
    require("lspsaga.diagnostic").goto_prev({
        severity = vim.diagnostic.severity.ERROR,
    })
end

local lsp_mappings_whichkey = {
    { "<leader>D", group = "Debugging" },
    {
        "<leader>DB",
        "<CMD>lua require('dap').set_breakpoint(vim.fn.input('[Condition] > '))<CR>",
        desc = "Set conditional breakpoint",
    },
    {
        "<leader>Db",
        "<CMD>lua require('dap').toggle_breakpoint()<CR>",
        desc = "Toggle breakpoint",
    },
    {
        "<leader>Dc",
        "<CMD>lua require('dap').clear_breakpoints()<CR>",
        desc = "Clear breakpoints",
    },
    {
        "<leader>Dlp",
        '<CMD>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
        desc = "Set log point conditional breakpoint",
    },
    {
        "<leader>Do",
        "<CMD>lua require('dapui').toggle()<CR>",
        desc = "Toggle DAP ui",
    },
    { "<leader>d", group = "LSP Diagnostics" },
    {
        "<leader>dc",
        "<cmd>Lspsaga show_cursor_diagnostics<cr>",
        desc = "Show cursor diagnostics",
    },
    {
        "<leader>dl",
        "<cmd>Lspsaga show_line_diagnostics<cr>",
        desc = "Show line diagnostics",
    },
    {
        "<leader>dn",
        jump_to_next_error,
        desc = "Jump to next error",
    },
    {
        "<leader>dp",
        jump_to_prev_error,
        desc = "Jump to previous error",
    },
    {
        "<leader>dw",
        "<cmd>Trouble<cr>",
        desc = "[w]orkspace diagnostics",
    },
    { "<leader>l", group = "LSP" },
    {
        "<leader>la",
        "<cmd>Lspsaga code_action<cr>",
        desc = "Code actions",
    },
    { "<leader>lg", group = "Go to..." },
    {
        "<leader>lgD",
        "<cmd>lua vim.lsp.buf.declaration()<cr>",
        desc = "Show declaration",
    },
    {
        "<leader>lgd",
        "<cmd>Lspsaga peek_definition<cr>",
        desc = "Peek definition",
    },
    {
        "<leader>lgi",
        "<cmd>lua vim.lsp.buf.implementation()<cr>",
        desc = "Show implementation",
    },
    {
        "<leader>lgr",
        "<cmd>Lspsaga finder tyd+ref+imp+def<cr>",
        desc = "Show references",
    },
    {
        "<leader>lgy",
        "<cmd>Lspsaga peek_type_definition<cr>",
        desc = "Show type definition",
    },
    {
        "<leader>lk",
        "<cmd>Lspsaga hover_doc<cr>",
        desc = "Show documentation",
    },
    {
        "<leader>lo",
        "<cmd>Lspsaga outline<cr>",
        desc = "Show outline",
    },
    {
        "<leader>lr",
        "<cmd>Lspsaga rename<cr>",
        desc = "Rename",
    },
    {
        "<leader>ls",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Show workspace symbols",
    },
    { "<leader>t", group = "Telescope" },
    {
        "<leader>td",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Show dynamic workspace symbols",
    },
}

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local bufmap = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    -- Displays hover information about the symbol under the cursor
    bufmap("n", "K", hover_doc_command)
    -- Jump to the definition
    bufmap("n", "gd", peek_definition_command)
    -- Jump to declaration
    bufmap("n", "gD", show_declaration_command)
    -- Lists all the implementations for the symbol under the cursor
    bufmap("n", "gi", show_implementation_command)
    -- Jumps to the definition of the type symbol
    bufmap("n", "gy", show_type_definition_command)
    -- Lists all the references
    bufmap("n", "gr", show_references_command)
    -- Renames all references to the symbol under the cursor
    bufmap("n", "rn", rename_command)
    -- Selects a code action available at the current cursor position
    bufmap("n", "<C-a>", code_actions_command)
    -- Show diagnostics in a floating window
    bufmap("n", "gl", show_line_diagnostics)
    -- Move to the previous diagnostic
    bufmap("n", "[d", jump_to_prev_diagnostics_finding)
    -- Move to the next diagnostic
    bufmap("n", "]d", jump_to_next_diagnostics_finding)
    -- Toggle inlay hints
    --
    bufmap("n", "<leader>h", function()
        print("Toggling inlay hints for current buffer")
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end)

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    local whichkey = require("which-key")
    whichkey.add(lsp_mappings_whichkey)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

navic.setup({
    icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
    },
})

local neodev_status, neodev = pcall(require, "neodev")
if neodev_status then
    neodev.setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
    })
end

vim.g.inlay_hints_visible = true

require("plugin.lsp.languages.html-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.js-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.css-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.lua-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.python-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.cpp-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.cmake-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.bash-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.rust-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.java-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.kotlin-lsp").setup(lspconfig, capabilities, on_attach)

require("plugin.lsp.languages.docker-lsp").setup(lspconfig, capabilities, on_attach)

local bundler_status, lspconfig_bundler = pcall(require, "lspconfig-bundler")
if bundler_status then
    lspconfig_bundler.setup()
    require("plugin.lsp.languages.ruby-lsp").setup(lspconfig, capabilities, on_attach)
end
