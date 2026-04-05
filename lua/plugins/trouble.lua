return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("trouble").setup({
            position = "bottom",
            height = 10,
            width = 50,
            icons = true,
            mode = "workspace_diagnostics",
            group = true,
            padding = true,
            filter = {},
            action_keys = {
                open = "o",
                close = "q",
                cancel = "<Esc>",
                refresh = "r",
                jump = { "<CR>", "<2-LeftMouse>" },
                toggle_mode = "m",
                toggle_preview = "P",
                hover = "h",
                preview = "p",
                close_folds = { "zM", "zm" },
                open_folds = { "zR", "zr" },
            },
        })
    end,
}
