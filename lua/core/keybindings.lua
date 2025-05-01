vim.g.mapleader = " "
vim.g.localmapleader = " "
local map = vim.api.nvim_set_keymap

local cycle_next = "<CMD>BufferLineCyclePrev<CR>"
local cycle_prev = "<CMD>BufferLineCycleNext<CR>"
local move_next = "<CMD>BufferLineMoveNext<CR>"
local move_prev = "<CMD>BufferLineMovePrev<CR>"
local close_other_buffers = "<CMD>BufferLineCloseOthers<CR>"
local close_current_buffer = "<CMD>BufDel<CR>"
map("n", "<Space>", "", {})
map("n", "<F1>", "", {})
map("n", "Q", "", {})
map("n", "<ESC>", "<CMD>noh<CR>", { silent = true })
map("n", "<A-,>", cycle_next, { silent = true })
map("n", "<A-.>", cycle_prev, { silent = true })
map("n", "<A-t>", close_other_buffers, { silent = true })
map("n", "<A-c>", close_current_buffer, { silent = true })
map("n", ",", cycle_next, { silent = true })
map("n", ".", cycle_prev, { silent = true })
map("n", "L", cycle_prev, { silent = true })
map("n", "H", cycle_next, { silent = true })
map("n", "<C-n>", move_prev, { silent = true })
map("n", "<C-m>", move_next, { silent = true })
map("n", "<C-t>", close_other_buffers, { silent = true })
map("n", "<C-c>", close_current_buffer, { silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "<F8>", '<CMD>lua require("dap").continue()<CR>')
vim.keymap.set("n", "<F9>", '<CMD>lua require("dap").step_into()<CR>')
vim.keymap.set("n", "<F10>", '<CMD>lua require("dap").step_over()<CR>')
vim.keymap.set("n", "<F11>", '<CMD>lua require("dap").step_out()<CR>')

local whichkey_status, whichkey = pcall(require, "which-key")
if not whichkey_status then
    return
end
local mappings = {
    {
        "<leader>,",
        "<CMD>BufferLineCyclePrev<CR>",
        desc = "Cycle to next buffer",
    },
    {
        "<leader>.",
        "<CMD>BufferLineCycleNext<CR>",
        desc = "Cycle to previous buffer",
    },
    {
        "<leader>L",
        "<CMD>Lazy<CR>",
        desc = "Lazy",
    },
    {
        "<leader>M",
        "<CMD>Mason<CR>",
        desc = "Mason",
    },
    {
        "<leader>b",
        "<CMD>Telescope buffers<CR>",
        desc = "Opened buffers",
    },
    {
        "<leader>c",
        "<CMD>BufDel<CR>",
        desc = "Close current buffer",
    },
    {
        "<leader>e",
        "<CMD>Neotree toggle<CR>",
        desc = "File Explorer",
    },
    {
        "<leader>f",
        "<CMD>Telescope live_grep_args<CR>",
        desc = "Search in files",
    },
    { "<leader>g", group = "Git" },
    {
        "<leader>gb",
        "<CMD>GitBlameToggle<CR>",
        desc = "Enable Git Blame",
    },
    { "<leader>gh", group = "Hunk" },
    {
        "<leader>ghP",
        "<CMD>Gitsigns preview_hunk<CR>",
        desc = "Preview hunk",
    },
    {
        "<leader>ghn",
        "<CMD>Gitsigns next_hunk<CR>",
        desc = "Next hunk",
    },
    {
        "<leader>ghp",
        "<CMD>Gitsigns prev_hunk<CR>",
        desc = "Previous hunk",
    },
    {
        "<leader>ghr",
        "<CMD>Gitsigns reset_hunk<CR>",
        desc = "Reset hunk",
    },
    {
        "<leader>ghs",
        "<CMD>Gitsigns select_hunk<CR>",
        desc = "Select hunk",
    },
    {
        "<leader>gl",
        "<cmd>lua LAZYGIT_TOGGLE()<CR>",
        desc = "Toggle lazygit",
    },
    { "<leader>gw", group = "Git Worktree" },
    {
        "<leader>gwc",
        '<CMD>lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>',
        desc = "Create a worktree",
    },
    {
        "<leader>gws",
        '<CMD>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>',
        desc = "Switch and delete a worktrees",
    },
    { "<leader>h", group = "Harpoon" },
    {
        "<leader>ha",
        '<CMD>lua require("harpoon.mark").add_file()<CR>',
        desc = "Add mark",
    },
    {
        "<leader>he",
        '<CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>',
        desc = "Show menu",
    },
    {
        "<leader>hm",
        "<CMD>Telescope harpoon marks<CR>",
        desc = "Show marks",
    },
    { "<leader>n", group = "Noice" },
    {
        "<leader>nd",
        "<CMD>Noice dismiss<CR>",
        desc = "Dismiss notifications",
    },
    {
        "<leader>o",
        "<CMD>Neotree reveal<CR>",
        desc = "Open file in explorer",
    },
    {
        "<leader>p",
        '<CMD>lua require("telescope.builtin").find_files({find_command = { "fd", "-t=f", "-H" }})<CR>',
        desc = "Search files",
    },
    {
        "<leader>r",
        "<CMD>Telescope frecency workspace=CWD<CR>",
        desc = "Recent files",
    },
    {
        "<leader>s",
        "<cmd>lua require('treesj').toggle()<CR>",
        desc = "Join the object under cursor",
    },
    {
        "<leader>t",
        "<CMD>BufferLineCloseOthers<CR>",
        desc = "Close other buffers",
    },
}

whichkey.add(mappings)
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n" }, "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "Git next hunk" })
vim.keymap.set({ "n" }, "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Git next hunk" })
local status, live_grep_args_shortcuts = pcall(require, "telescope-live-grep-args.shortcuts")
if status then
    vim.keymap.set(
        { "v" },
        "<C-f>",
        live_grep_args_shortcuts.grep_visual_selection,
        { desc = "Search visual selection" }
    )
    vim.keymap.set(
        { "n" },
        "<C-f>",
        live_grep_args_shortcuts.grep_word_under_cursor,
        { desc = "Search work under cursor" }
    )
end
