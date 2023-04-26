vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.clipboard:append("unnamedplus")

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"
vim.opt.iskeyword:append("-")
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "90"

vim.g.editorconfig = true
vim.g.editorconfig_root = true
vim.g.gitblame_enabled = false
vim.cmd([[xnoremap p P]])
vim.cmd([[
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
]])

require("packer-init")

require("core.keybindings")
require("core.colorscheme")
require("core.cursor")
require("core.spacing")

require("plugin.flatten")
require("plugin.undotree")
require("plugin.autopairs")
require("plugin.bufferline")
require("plugin.diagnostics")
require("plugin.gitsigns")
require("plugin.lualine")
require("plugin.nvim-bufdel")
require("plugin.nvim-cmp")
require("plugin.nvim-comment")
require("plugin.nvim-tree")
require("plugin.surround")
require("plugin.telescope")
require("plugin.toggleterm")
require("plugin.treesitter")
require("plugin.treesitter-context")
require("plugin.trouble")

require("plugin.lsp.mason")
require("plugin.lsp.lspsaga")
require("plugin.lsp.lspconfig")
require("plugin.lsp.null-ls")
require("plugin.peek-nvim")

require("plugin.dap.init")

require("plugin.startup")
require("plugin.image")
require("plugin.peepsight")
require("plugin.noice")
require("plugin.statuscol")
require("plugin.treesj")
require("plugin.colorizer")
