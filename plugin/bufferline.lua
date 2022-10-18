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
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            if context.buffer:current() then
                return ''
            end
            if level:match('error') then
                return ' ' .. vim.g.diagnostic_icons.Error
            elseif level:match('warning') then
                return ' ' .. vim.g.diagnostic_icons.Warning
            end
            return ''
        end,
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
