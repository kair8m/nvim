vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
local mapset = vim.keymap.set

map('n', '<Space>', '', {})
map('n', '<ESC>', '<CMD>noh<CR>', { silent = true })
map('n', '<A-,>', '<CMD>BufferLineCyclePrev<CR>', { silent = true })
map('n', '<A-.>', '<CMD>BufferLineCycleNext<CR>', { silent = true })
map('n', '<A-t>', '<CMD>BufferLineCloseLeft<CR><CMD>BufferLineCloseRight<CR>', { silent = true })
map('n', '<A-c>', '<CMD>BufDel<CR>', { silent = true })
mapset({ 'n' }, '<leader>p',
    '<CMD>lua require("telescope.builtin").find_files({find_command = { "fd", "-t=f", "-i" }})<CR>')
mapset({ 'n' }, '<leader>f', '<CMD>Telescope live_grep<CR>')
mapset({ 'n' }, '<leader>e', '<CMD>NvimTreeToggle<CR>')
mapset({ 'n' }, '<leader>o', '<CMD>NvimTreeFindFile<CR>')
map('n', '<leader>g', '<cmd>lua LAZYGIT_TOGGLE()<CR>', { noremap = true, silent = true })

