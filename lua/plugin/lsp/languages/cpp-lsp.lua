local M = {}

local clangd_path = vim.fn.stdpath("data") .. "/mason/bin/clangd"

local function switch_source_header(bufnr)
    local method_name = "textDocument/switchSourceHeader"
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
    if not client then
        return vim.notify(
            ("method %s is not supported by any servers active on the current buffer"):format(method_name)
        )
    end
    local params = vim.lsp.util.make_text_document_params(bufnr)
    client:request(method_name, params, function(err, result)
        if err then
            error(tostring(err))
        end
        if not result then
            vim.notify("corresponding file cannot be determined")
            return
        end
        vim.cmd.edit(vim.uri_to_fname(result))
    end, bufnr)
end

M.setup = function(capabilities, on_attach)
    capabilities.offsetEncoding = { "utf-16" }
    vim.lsp.config.clangd = {
        cmd = {
            -- see clangd --help-hidden
            clangd_path,
            "--background-index",
            -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
            -- to add more checks, create .clang-tidy file in the root directory
            -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
            "--clang-tidy",
            "--completion-style=bundled",
            "--cross-file-rename",
            "--header-insertion=iwyu",
            "--inlay-hints=true",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        capabilities = capabilities,
        init_options = {
            clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
            inlayHints = true,
        },
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, "ClangdSwitchSourceHeader", function()
                switch_source_header(bufnr)
            end, { desc = "Switch between source/header" })
        end,
    }
    vim.lsp.enable("clangd")
end

return M
