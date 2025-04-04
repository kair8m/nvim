vim.diagnostic.config({
    severity_sort = true,
    float = {
        border = "rounded",
        header = "",
        prefix = "",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
        },
    },
    virtual_text = {
        prefix = "",
        format = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return string.format("✘ %s", diagnostic.message)
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                return string.format("▲ %s", diagnostic.message)
            elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                return string.format("⚑ %s", diagnostic.message)
            elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                return string.format(" %s", diagnostic.message)
            else
                return diagnostic.message
            end
        end,
    },
})
