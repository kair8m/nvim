return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
        local status_ok, telescope = pcall(require, "telescope")
        if not status_ok then
            return
        end

        telescope.load_extension("fzf")
        telescope.load_extension("frecency")
        telescope.load_extension("dap")
        telescope.load_extension("harpoon")

        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                dynamic_preview_title = true,
                find_command = { "fd", "-t=f", "-a", "-i" },
                path_display = { "truncate" },
                wrap_results = true,
                prompt_prefix = " ",
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                mappings = {
                    i = {
                        ["<C-j>"] = {
                            actions.move_selection_next,
                            type = "action",
                        },
                        ["<C-k>"] = {
                            actions.move_selection_previous,
                            type = "action",
                        },
                        ["<C-h>"] = {
                            actions.preview_scrolling_up,
                            type = "action",
                        },
                        ["<C-l>"] = {
                            actions.preview_scrolling_down,
                            type = "action",
                        },
                        ["<C-d>"] = {
                            actions.results_scrolling_down,
                            type = "action",
                        },
                        ["<C-u>"] = {
                            actions.results_scrolling_up,
                            type = "action",
                        },
                        ["<PageDown>"] = {
                            actions.cycle_history_next,
                            type = "action",
                        },
                        ["<PageUp>"] = {
                            actions.cycle_history_prev,
                            type = "action",
                        },
                    },
                },
            },
            pickers = {
                lsp_references = { theme = "dropdown" },
                lsp_definitions = { theme = "dropdown" },
                lsp_implementations = { theme = "dropdown" },
                lsp_document_symbols = { theme = "dropdown" },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                frecency = {
                    matcher = "fuzzy",
                },
            },
        })
        telescope.load_extension("live_grep_args")
        local status, live_grep_args_shortcuts = pcall(require, "telescope-live-grep-args.shortcuts")
        if status then
            vim.keymap.set(
                "v",
                "<C-f>",
                live_grep_args_shortcuts.grep_visual_selection,
                { desc = "Search visual selection" }
            )
            vim.keymap.set(
                "n",
                "<C-f>",
                live_grep_args_shortcuts.grep_word_under_cursor,
                { desc = "Search word under cursor" }
            )
        end
        local builtin_status, telescope_builtin = pcall(require, "telescope.builtin")
        if builtin_status then
            vim.keymap.set("n", "<leader>p", function()
                telescope_builtin.find_files({ find_command = { "fd", "-t=f", "-H" } })
            end, { desc = "Search files" })
            vim.keymap.set("n", "<leader>b", function()
                telescope_builtin.buffers()
            end, { desc = "Opened buffers" })
        end
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            telescope.extensions.live_grep_args.live_grep_args()
        end, { desc = "Search in files" })
        vim.keymap.set({ "n", "v" }, "<leader>m", function()
            telescope.extensions.harpoon.marks()
        end, { desc = "Show marks" })
        vim.keymap.set("n", "<leader>r", function()
            telescope.extensions.frecency.frecency({
                workspace = "CMD",
            })
        end, { desc = "Recent files" })

        vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
    end,
}
