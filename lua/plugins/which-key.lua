return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        plugins = {
            presets = {
                operators = true,
                motions = true,
                text_objects = true,
                windows = true,
                nav = true,
                z = true,
                g = true,
            },
        },
    },
}
