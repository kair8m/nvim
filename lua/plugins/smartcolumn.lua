return {
    "m4xshen/smartcolumn.nvim",
    config = function()
        require("smartcolumn").setup({
            colorcolumn = "999",
            disabled_filetypes = {
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "dap-repl",
                "dapui_scopes",
                "dapui_breakpoints",
                "dapui_console",
                "dapui_stacks",
                "help",
                "markdown",
                "text",
                "lspinfo",
                "toggleterm",
                "prompt",
            },
            scope = "file",
        })
    end,
}
