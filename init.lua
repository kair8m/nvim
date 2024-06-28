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
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

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
-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})

require("lazy-init")

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
require("plugin.nvim-tree")
require("plugin.surround")
require("plugin.telescope")
require("plugin.toggleterm")
require("plugin.treesitter")
require("plugin.treesitter-context")
require("plugin.trouble")

require("plugin.lsp.mason")
require("plugin.lsp.lspconfig")
require("plugin.lsp.lspsaga")
require("plugin.lsp.null-ls")
require("plugin.peek-nvim")

require("plugin.dap.init")

require("plugin.image")
require("plugin.peepsight")
require("plugin.notify")
require("plugin.noice")
require("plugin.statuscol")
require("plugin.treesj")
require("plugin.colorizer")
require("plugin.wrapping")
require("plugin.neotest")
require("plugin.hop")
require("plugin.illuminate")
require("plugin.gitconflict")
require("plugin.highlight-undo")
