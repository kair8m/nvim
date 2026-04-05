return {
    "RRethy/vim-illuminate",
    config = function()
        require("illuminate").configure({
            providers = {
                "lsp",
                "regex",
            },
            delay = 100,
            filetype_overrides = {},
            undercurl = true,
            min_count_to_highlight = 1,
        })
    end,
}
