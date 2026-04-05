return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-gtest"),
            },
        })
    end,
}
