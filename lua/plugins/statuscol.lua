return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            setopt = true,
            segments = {
                {
                    sign = {
                        namespace = { "gitsigns.*" },
                        name = { "gitsigns.*" },
                    },
                },
                {
                    sign = {
                        namespace = { ".*" },
                        name = { ".*" },
                        auto = true,
                    },
                },
                {
                    text = { builtin.lnumfunc },
                    click = "v:lua.ScLa",
                },
            },
        })
    end,
}
