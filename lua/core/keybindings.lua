vim.g.mapleader = " "
vim.g.localmapleader = " "

vim.keymap.set("n", "<Space>", "", {})
vim.keymap.set("n", "<F1>", "", {})
vim.keymap.set("n", "Q", "")
vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>", { silent = true })
vim.keymap.set("n", "<A-c>", "<CMD>BufDel<CR>", { silent = true })
vim.keymap.set("n", "<C-c>", "<CMD>BufDel<CR>", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "<F8>", "<CMD>lua require('dap').continue()<CR>")
vim.keymap.set("n", "<F9>", "<CMD>lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<F10>", "<CMD>lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<F11>", "<CMD>lua require('dap').step_out()<CR>")

vim.keymap.set("n", "<leader>L", "<CMD>Lazy<CR>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>M", "<CMD>Mason<CR>", { desc = "Mason" })
vim.keymap.set("n", "<leader>c", "<CMD>BufDel<CR>", { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>ha", "<CMD>lua require('harpoon.mark').add_file()<CR>", { desc = "Add mark" })
vim.keymap.set("n", "<leader>he", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Show menu" })
vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = false })
end, { desc = "Format file with LSP" })

local opts = { buffer = 0, silent = true }

-- Remap navigation keys to pass cleanly to the terminal
vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", opts)
vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", opts)
vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", opts)
vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", opts)
