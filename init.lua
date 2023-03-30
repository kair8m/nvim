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

vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "90"

vim.g.editorconfig = true
vim.g.editorconfig_root = true

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
require("plugin.fidget")
require("plugin.gitsigns")
require("plugin.indent-blankline")
require("plugin.lsp-colors")
require("plugin.lualine")
require("plugin.nvim-bufdel")
require("plugin.nvim-cmp")
require("plugin.nvim-comment")
require("plugin.nvim-transparent")
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
require("plugin.symbols-outline")
require("plugin.peek-nvim")

require("plugin.dap.init")

require("plugin.startup")
require("plugin.image")
