return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "frappe",
            transparent_background = false,
            term_colors = true,
            compile = {
                enabled = true,
                path = vim.fn.stdpath("data") .. "/catppuccin",
            },
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
                neotree = true,
                noice = true,
                bufferline = true,
                which_key = true,
            },
        })
        vim.cmd("colorscheme catppuccin")
    end,
}
