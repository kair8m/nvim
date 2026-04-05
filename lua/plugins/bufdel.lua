return {
    "ojroques/nvim-bufdel",
    config = function()
        require("bufdel").setup({
            next = "alternate",
            quit = false,
        })
    end,
}
