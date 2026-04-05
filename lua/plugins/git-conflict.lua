return {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
        require("git-conflict").setup({
            default_mappings = {
                ours = "<leader>co",
                theirs = "<leader>ct",
                none = "<leader>c0",
                both = "<leader>cb",
                prev = "[x",
                next = "]x",
            },
        })
    end,
}
