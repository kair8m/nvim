vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

map('n', '<Space>', '', {})
map('n', '<ESC>', '<CMD>noh<CR>', { silent = true })
map('n', '<A-,>', '<CMD>BufferLineCyclePrev<CR>', { silent = true })
map('n', '<A-.>', '<CMD>BufferLineCycleNext<CR>', { silent = true })
map('n', '<A-t>', '<CMD>BufferLineCloseLeft<CR><CMD>BufferLineCloseRight<CR>', { silent = true })
map('n', '<A-c>', '<CMD>BufDel<CR>', { silent = true })

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
    S = { '<cmd>Silicon<CR>', 'Take screenshot' }
}

local opts = {
    prefix = '<leader>'
}

whichkey.register(mappings, opts)

