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
local show_references_command = '<cmd>Lspsaga lsp_finder<cr>'
local peek_definition_command = '<cmd>Lspsaga peek_definition<cr>'
local show_declaration_command = '<cmd>lua vim.lsp.buf.declaration()<cr>'
local show_implementation_command = '<cmd>lua vim.lsp.buf.implementation()<cr>'
local show_type_definition_command = '<cmd>lua vim.lsp.buf.type_definition()<cr>'
local code_actions_command = '<cmd>Lspsaga code_action<cr>'
local rename_command = '<cmd>Lspsaga rename<cr>'
local hover_doc_command = '<cmd>Lspsaga hover_doc<cr>'

local show_diagnostics_command = '<cmd>TroubleRefresh<cr><cmd>TroubleToggle<cr>'
local show_line_diagnostics = '<cmd>Lspsaga show_line_diagnostics<cr>'
local show_cursor_diagnostics = '<cmd>Lspsaga show_cursor_diagnostics<cr>'
local jump_to_next_diagnostics_finding = '<cmd>Lspsaga diagnostic_jump_next<cr>'
local jump_to_prev_diagnostics_finding = '<cmd>Lspsaga diagnostic_jump_prev<cr>'
local jump_to_next_error = function ()
    require('lspsaga.diagnostic').goto_next({
        severity = vim.diagnostic.severity.ERROR
    })
end
local jump_to_prev_error = function ()
    require('lspsaga.diagnostic').goto_prev({
        severity = vim.diagnostic.severity.ERROR
    })
end

local lsp_mappings_whichkey = {
    l = {
        name = 'LSP',
        g = {
            name = 'Go to...',
            r = { show_references_command, 'Show references' },
            d = { peek_definition_command, 'Peek definition' },
            D = { show_declaration_command, 'Show declaration' },
            i = { show_implementation_command, 'Show implementation' },
            y = { show_type_definition_command, 'Show type definition' }
        },
        r = { rename_command, 'Rename' },
        a = { code_actions_command, 'Code actions' },
        k = { hover_doc_command, 'Show documentation' }
    },
    d = {
        name = 'LSP Diagnostics',
        a = { show_diagnostics_command, 'Toggle diagnostics results' },
        l = { show_line_diagnostics, 'Show line diagnostics' },
        c = { show_cursor_diagnostics, 'Show cursor diagnostics' },
        n = { jump_to_next_error, 'Jump to next error' },
        p = { jump_to_prev_error, 'Jump to previous error' }
    }
}

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local bufmap = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    -- Use LSP as the handler for formatexpr.
    -- See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', hover_doc_command)
    -- Jump to the definition
    bufmap('n', 'gd', peek_definition_command)
    -- Jump to declaration
    bufmap('n', 'gD',show_declaration_command)
    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', show_implementation_command)
    -- Jumps to the definition of the type symbol
    bufmap('n', 'gy', show_type_definition_command)
    -- Lists all the references
    bufmap('n', 'gr', show_references_command)
    -- Renames all references to the symbol under the cursor
    bufmap('n', 'rn', rename_command)
    -- Selects a code action available at the current cursor position
    bufmap('n', '<C-a>', code_actions_command)
    -- Show diagnostics in a floating window
    bufmap('n', 'gl', show_line_diagnostics)
    -- Move to the previous diagnostic
    bufmap('n', '[d', jump_to_prev_diagnostics_finding)
    -- Move to the next diagnostic
    bufmap('n', ']d', jump_to_next_diagnostics_finding)

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    if client.name == 'tsserver' then
        bufmap('n', '<leader>rf', '<CMD>TypescriptRenameFile<CR>')
    end

    local whichkey = require('which-key')
    whichkey.register(lsp_mappings_whichkey, { prefix = '<leader>' })
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

lspconfig['bashls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}

-- lspconfig['rust_analyzer'].setup {
--     capabilities = capabilities,
--     on_attach = on_attach
-- }

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

local rust_tools_status, rust_tools = pcall(require, 'rust-tools')
if not rust_tools_status then
    return
end
rust_tools.setup({
	server = {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			if client.name == "rust_analyzer" then
				vim.keymap.set("n", "gq", "<CMD>RustFmt<CR>", { buffer = bufnr })
				-- Displays hover information about the symbol under the cursor
				vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
				-- Selects a code action available at the current cursor position
				vim.keymap.set("n", "<leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
			end
		end,
	},
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			show_parameter_hints = true,
		},
	},
})
