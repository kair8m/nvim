vim.opt.termguicolors = true

local bufferline = require('bufferline')

vim.api.nvim_set_keymap('n', '<A-,>', '<CMD>BufferLineCyclePrev<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<A-.>', '<CMD>BufferLineCycleNext<CR>', { silent = true })

bufferline.setup({
    highlights = {
        buffer_selected = { bold = true },
        diagnostic_selected = { bold = true },
        info_selected = { bold = true },
        info_diagnostic_selected = { bold = true },
        warning_selected = { bold = true },
        warning_diagnostic_selected = { bold = true },
        error_selected = { bold = true },
        error_diagnostic_selected = { bold = true },
    },
    options = {
        show_close_icon = false,
        diagnostics = 'nvim_lsp',
        max_prefix_length = 8,
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                highlight = 'Directory',
                separator = true -- use a 'true' to enable the default, or set your own character
            }
        }
    },
})
