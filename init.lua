vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.clipboard:append('unnamedplus')

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.backspace = 'indent,eol,start'
vim.opt.iskeyword:append('-')
vim.cmd[[set termguicolors]]
vim.cmd[[set guicursor=n-v-c-sm:blinkon100,i-ci-ve:ver25blinkon100,r-cr-o:hor20blinkon100]]
vim.cmd[[hi Cursor gui=reverse guibg=reverse guifg=reverse]]
vim.cmd[[hi CursorLine gui=reverse guibg=reverse guifg=reverse]]
vim.cmd[[hi TermCursor gui=reverse guibg=reverse guifg=reverse cterm=reverse]]
vim.cmd[[hi TermCursorNC gui=reverse guibg=reverse guifg=reverse cterm=reverse]]
vim.cmd[[set cursorline]]

vim.api.nvim_set_keymap('n', '<ESC>', '<CMD>noh<CR>', {silent = true})

require('packer-init')
