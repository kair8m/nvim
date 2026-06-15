return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            enable_diagnostics = true,
            enable_git_status = true,
            enable_modified_markers = true,
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                },
                follow_current_file = {
                    enabled = false,
                },
                use_libuv_file_watcher = true,
            },
            window = {
                position = "left",
                width = 40,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = {
                        "toggle_node",
                        nowait = false,
                    },
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["l"] = "focus_preview",
                    ["h"] = "close_node",
                },
            },
        })
        vim.keymap.set("n", "<leader>o", "<CMD>Neotree reveal<CR>", { desc = "Open file in explorer" })
        vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle<CR>", { desc = "File Explorer" })
    end,
}
