return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 1000,
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                map({ "n", "v" }, "<leader>ghP", gs.preview_hunk_inline, "Preview hunk")
                map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
                map({ "n", "v" }, "<leader>ghs", gs.select_hunk, "Select hunk")
                map({ "n", "v" }, "]g", function()
                    gs.nav_hunk("next")
                end, "Git next hunk")
                map({ "n", "v" }, "[g", function()
                    gs.nav_hunk("prev")
                end, "Git prev hunk")
                map({ "n", "v" }, "]G", function()
                    gs.nav_hunk("last")
                end, "Git last hunk")
                map({ "n", "v" }, "[G", function()
                    gs.nav_hunk("first")
                end, "Git first hunk")
            end,
        })
    end,
}
