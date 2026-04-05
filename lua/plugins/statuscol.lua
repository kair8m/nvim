return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relfuncname = "statuscol.builtin",
            segments = {
                { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                {
                    text = { " ", builtin.foldfunc, " " },
                    condition = { builtin.not_empty, builtin.foldlevel },
                    click = "v:lua.ScFa",
                },
            },
        })
    end,
}
