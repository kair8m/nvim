local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
    return
end

local status_ok2, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok2 then
    return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local lsp_defaults = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    end
}

lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults
)

-- Set up lspconfig.
lspconfig['pyright'].setup { capabilities = capabilities }
lspconfig['clangd'].setup {
    init_options = {
        clangdFileStatus = true,
    },
    capabilities = capabilities
}
lspconfig['tsserver'].setup { capabilities = capabilities }
lspconfig.sumneko_lua.setup({
    { capabilities = capabilities },
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

local status_ok3, from_vscode = pcall(require, 'luasnip.loaders.from_vscode')
if not status_ok3 then
    return
end

from_vscode.lazy_load()

vim.api.nvim_create_autocmd('User', {
    pattern = 'LspAttached',
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end
        -- Displays hover information about the symbol under the cursor
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        -- Jump to the definition
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        -- Jump to declaration
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        -- Lists all the implementations for the symbol under the cursor
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        -- Jumps to the definition of the type symbol
        bufmap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        -- Lists all the references
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
        -- Displays a function's signature information
        bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        -- Renames all references to the symbol under the cursor
        bufmap('n', '<C-r>', '<cmd>lua vim.lsp.buf.rename()<cr>')
        -- Selects a code action available at the current cursor position
        bufmap('n', '<C-a>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', '<C-s>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
        -- Show diagnostics in a floating window
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        -- Move to the previous diagnostic
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        -- Move to the next diagnostic
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
})

