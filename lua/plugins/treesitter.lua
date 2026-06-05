return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ok, nvim_treesitter = pcall(require, "nvim-treesitter")
        if not ok then
            return
        end
        nvim_treesitter.install(
            "lua",
            "vim",
            "vimdoc",
            "python",
            "cpp",
            "c",
            "javascript",
            "typescript",
            "html",
            "css",
            "json",
            "yaml",
            "markdown",
            "markdown_inline",
            "bash",
            "rust",
            "go",
            "ruby"
        )
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
}
