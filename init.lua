vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.clipboard:append("unnamedplus")

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

vim.g.editorconfig = true
vim.cmd("filetype indent on")

vim.cmd([[xnoremap p P]])
vim.cmd([[
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\027[38;2;%lu;%lu;%lum"
  let &t_8b = "\027[48;2;%lu;%lu;%lum"
endif
]])
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Highlight yanked text",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})
vim.diagnostic.config({ virtual_text = true })

require("core.keybindings")
require("lazy-init")
require("core.colorscheme")
require("core.cursor")
require("core.spacing")
