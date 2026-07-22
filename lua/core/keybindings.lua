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

local function get_file_path(modifier)
    local file_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), modifier)
    if file_path == "" then
        vim.notify("Current buffer has no file path", vim.log.levels.WARN)
        return nil
    end

    return file_path
end

local function copy_file_path(modifier, include_selection)
    local file_path = get_file_path(modifier)
    if not file_path then
        return
    end

    local text = file_path
    if include_selection then
        local start_pos = vim.fn.getpos("v")
        local end_pos = vim.fn.getpos(".")
        if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
            start_pos, end_pos = end_pos, start_pos
        end

        text = string.format(
            "%s (L%d C%d - L%d C%d)",
            file_path,
            start_pos[2],
            start_pos[3],
            end_pos[2],
            end_pos[3]
        )
    end

    vim.fn.setreg("+", text)
    vim.notify("Copied: " .. text)
end

vim.keymap.set("n", "<leader>y", function()
    copy_file_path(":.")
end, { desc = "Copy relative file path" })
vim.keymap.set("n", "<leader>Y", function()
    copy_file_path(":p")
end, { desc = "Copy absolute file path" })
vim.keymap.set("x", "<leader>y", function()
    copy_file_path(":.", true)
end, { desc = "Copy relative file path and selection" })
vim.keymap.set("x", "<leader>Y", function()
    copy_file_path(":p", true)
end, { desc = "Copy absolute file path and selection" })

vim.keymap.set("n", "<leader>ha", "<CMD>lua require('harpoon.mark').add_file()<CR>", { desc = "Add mark" })
vim.keymap.set("n", "<leader>he", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Show menu" })
vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = false })
end, { desc = "Format file with LSP" })
