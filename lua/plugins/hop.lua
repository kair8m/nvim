return {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
        require("hop").setup({
            keys = "etovxqpdygfblzhckisuran",
            term_seq_bias = 0.5,
        })
    end,
}
