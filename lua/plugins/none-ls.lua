return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--editorconfig" },
                }),
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = function(params)
                        if params.bufname == "" then
                            return {}
                        end
                        local dir = vim.fn.fnamemodify(params.bufname, ":h")
                        if vim.fn.findfile(".clang-format", dir .. ";") ~= "" then
                            return {}
                        end
                        local sw = vim.bo[params.bufnr].shiftwidth
                        local ts = vim.bo[params.bufnr].tabstop
                        local et = vim.bo[params.bufnr].expandtab
                        local tw = vim.bo[params.bufnr].textwidth
                        local style = string.format(
                            "{IndentWidth: %d, UseTab: %s, TabWidth: %d, ColumnLimit: %d}",
                            sw, et and "Never" or "Always", ts,
                            tw > 0 and tw or 80
                        )
                        return { "--style=" .. style }
                    end,
                }),
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
