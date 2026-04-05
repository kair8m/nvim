return {
    "andrewferrier/wrapping.nvim",
    config = function()
        require("wrapping").setup({
            min_space = 20,
            max_width = 80,
            wrap_type = "WORD",
            display_text_for_octothorpe = true,
            display_text_for_leading_whitespace = true,
            reformat_on_normalize = true,
        })
    end,
}
