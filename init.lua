vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.swapfile = false

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.api.nvim_set_keymap('n', '<ESC>', '<CMD>noh<CR>', {silent = true})

require('packer-init')
