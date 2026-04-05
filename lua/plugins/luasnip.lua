return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local ok, _ = pcall(require, "luasnip")
        if not ok then
            return
        end
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
