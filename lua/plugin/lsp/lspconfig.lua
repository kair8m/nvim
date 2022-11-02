local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then
    return
end

local nvim_cmp_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not nvim_cmp_lsp_status then
    return
end

local typescript_setup, typescript = pcall(require, 'typescript')
if not typescript_setup then
    return
end

local navic_staus, navic = pcall(require, 'nvim-navic')
if not navic_staus then
    return
end

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local bufmap = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>Lspsaga hover_doc<cr>')
    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>Lspsaga peek_definition<cr>')
    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    -- Jumps to the definition of the type symbol
    bufmap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    -- Lists all the references
    bufmap('n', 'gr', '<cmd>Lspsaga lsp_finder<cr>')
    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    -- Renames all references to the symbol under the cursor
    bufmap('n', 'rn', '<cmd>Lspsaga rename<cr>')
    -- Selects a code action available at the current cursor position
    bufmap('n', '<C-a>', '<cmd>Lspsaga code_action<cr>')
    bufmap('x', '<C-s>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>')
    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>')

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    if client.name == 'tsserver' then
        bufmap('n', '<leader>rf', '<CMD>TypescriptRenameFile<CR>')
    end
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig['html'].setup({
    capabilities = capabilities,
    on_attach = on_attach
})

typescript.setup({
    server = {
        capabilities = capabilities,
        on_attach = on_attach
    }
})

lspconfig['cssls'].setup({
    capabilities = capabilities,
    on_attach = on_attach
})

lspconfig['tailwindcss'].setup({
    capabilities = capabilities,
    on_attach = on_attach
})

lspconfig['sumneko_lua'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }

})

lspconfig['pyright'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
lspconfig['clangd'].setup {
    init_options = {
        clangdFileStatus = true,
    },
    capabilities = capabilities,
    on_attach = on_attach
}

navic.setup({
    icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' '
    }

})
