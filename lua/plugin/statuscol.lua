local status, statuscol = pcall(require, "statuscol")
if not status then
    return
end
local builtin = require("statuscol.builtin")
statuscol.setup({
    relculright = true,
    ft_ignore = { "man", "starter", "TelescopePrompt", "neo-tree" },
    segments = {
        -- Diagnostics
        {
            sign = {
                name = { "diagnostic.signs" },
                namespace = { "diagnostic.signs" },
                maxwidth = 1,
            },
        },

        -- Folds
        {
            text = { builtin.foldfunc },
        },

        -- Relative Line Numbers
        {
            text = { builtin.lnumfunc },
            condition = { true, builtin.not_empty },
        },

        -- Gitsigns
        {
            sign = {
                namespace = { "gitsigns" },
                maxwidth = 1,
                colwidth = 1,
                fillchar = "┃",
                wrap = true,
            },
        },
    },
})
