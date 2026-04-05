return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            stages = "fade",
            timeout = 3000,
            max_width = 60,
            background_colour = "Normal",
        })
    end,
}
