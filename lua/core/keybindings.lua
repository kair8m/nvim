vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

local cycle_next = '<CMD>BufferLineCyclePrev<CR>'
local cycle_prev = '<CMD>BufferLineCycleNext<CR>'
local close_other_buffers = '<CMD>BufferLineCloseLeft<CR><CMD>BufferLineCloseRight<CR>'
local close_current_buffer = '<CMD>BufDel<CR>'
map('n', '<Space>', '', {})
map('n', '<ESC>', '<CMD>noh<CR>', { silent = true })
map('n', '<A-,>', cycle_next, { silent = true })
map('n', '<A-.>', cycle_prev, { silent = true })
map('n', '<A-t>', close_other_buffers, { silent = true })
map('n', '<A-c>', close_current_buffer, { silent = true })

local whichkey_status, whichkey = pcall(require, 'which-key')
if not whichkey_status then
    return
end
local mappings = {
    e = { '<CMD>NvimTreeToggle<CR>', 'File Explorer' },
    o = { '<CMD>NvimTreeFindFile<CR>', 'Open file in explorer' },
    p = { '<CMD>lua require("telescope.builtin").find_files({find_command = { "fd", "-t=f", "-H" }})<CR>', 'Search files' },
    f = { '<CMD>Telescope live_grep<CR>', 'Search in files' },
    g = { '<cmd>lua LAZYGIT_TOGGLE()<CR>', 'Toggle lazygit' },
    S = { '<cmd>Silicon<CR>', 'Take screenshot' },
    [','] = { cycle_next, 'Cycle to next buffer' },
    ['.'] = { cycle_prev, 'Cycle to previous buffer' },
    t = { close_other_buffers, 'Close other buffers' },
    c = { close_current_buffer, 'Close current buffer' }
}

local opts = {
    prefix = '<leader>'
}

whichkey.register(mappings, opts)
