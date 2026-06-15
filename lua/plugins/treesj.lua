return {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
            node_with_only_children = true,
            digets_repeat = true,
        })
        vim.keymap.set("n", "<leader>s", function()
            require("treesj").toggle()
        end, { desc = "Join the object under cursor" })
    end,
}
