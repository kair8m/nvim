return {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
            node_with_only_children = true,
            digets_repeat = true,
        })
    end,
}
