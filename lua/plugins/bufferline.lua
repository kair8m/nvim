return {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local status_ok, bufferline = pcall(require, "bufferline")
        if not status_ok then
            return
        end

        bufferline.setup({
            options = {
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = { error = "Error ", warn = "Warn " }
                    local error_count = diag.error or 0
                    local warn_count = diag.warning or 0
                    local count = error_count + warn_count
                    if error_count > 0 then
                        return icons.error .. count
                    elseif warn_count > 0 then
                        return icons.warn .. count
                    end
                    return ""
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true,
                    },
                },
                separator_style = "thin",
                indicator = {
                    style = "icon",
                },
            },
        })
        vim.keymap.set("n", "<A-,>", "<CMD>BufferLineCyclePrev<CR>", { silent = true })
        vim.keymap.set("n", "<A-.>", "<CMD>BufferLineCycleNext<CR>", { silent = true })
        vim.keymap.set("n", "<A-t>", "<CMD>BufferLineCloseOthers<CR>", { silent = true })
        vim.keymap.set("n", ",", "<CMD>BufferLineCyclePrev<CR>", { silent = true })
        vim.keymap.set("n", ".", "<CMD>BufferLineCycleNext<CR>", { silent = true })
        vim.keymap.set("n", "L", "<CMD>BufferLineCycleNext<CR>", { silent = true })
        vim.keymap.set("n", "H", "<CMD>BufferLineCyclePrev<CR>", { silent = true })
        vim.keymap.set("n", "<C-n>", "<CMD>BufferLineMoveNext<CR>", { silent = true })
        vim.keymap.set("n", "<C-m>", "<CMD>BufferLineMovePrev<CR>", { silent = true })
        vim.keymap.set("n", "<C-t>", "<CMD>BufferLineCloseOthers<CR>", { silent = true })
        vim.keymap.set("n", "<leader>,", "<CMD>BufferLineCyclePrev<CR>", { desc = "Cycle to next buffer" })
        vim.keymap.set("n", "<leader>.", "<CMD>BufferLineCycleNext<CR>", { desc = "Cycle to previous buffer" })
        vim.keymap.set("n", "<leader>t", "<CMD>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
    end,
}
