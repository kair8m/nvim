vim.opt.number = true
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

vim.api.nvim_set_keymap('n', '<ESC>', '<CMD>noh<CR>', {silent = true})

require('packer-init')

require('core.keybindings')
require('core.colorscheme')
require('core.cursor')
require('core.spacing')


require('plugin.autopairs')
require('plugin.bufferline')
require('plugin.cursorline')
require('plugin.diagnostics')
require('plugin.fidget')
require('plugin.gitsigns')
require('plugin.indent-blankline')
require('plugin.lsp-colors')
require('plugin.lualine')
require('plugin.neoscroll')
require('plugin.nvim-bufdel')
require('plugin.nvim-cmp')
require('plugin.nvim-comment')
require('plugin.nvim-transparent')
require('plugin.nvim-tree')
require('plugin.surround')
require('plugin.telescope')
require('plugin.toggleterm')
require('plugin.treesitter')
require('plugin.trouble')

require('plugin.lsp.mason')
require('plugin.lsp.lspsaga')
require('plugin.lsp.lspconfig')
require('plugin.lsp.null-ls')
