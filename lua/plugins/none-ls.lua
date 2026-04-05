return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.diagnostics.cmake_lint,
            },
        })

        require("which-key").register({
            { "<leader>lf", function() vim.lsp.buf.format() end, desc = "Format file using lsp" },
        })
    end,
}
