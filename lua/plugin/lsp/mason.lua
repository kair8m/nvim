local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
    return
end

mason.setup({
    ui = {
        border = "rounded",
    },
})

mason_lspconfig.setup({
    ensure_installed = {
        "clangd",
        "pyright",
        "tsserver",
        "html",
        "cssls",
        "eslint",
        "lua_ls",
        "tailwindcss",
        "bashls",
        "rust_analyzer",
        "neocmake",
        -- "ruby_ls",
    },
})

mason_null_ls.setup({
    ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
        "clang_format",
        "cmake_format",
        "html_lint",
        "fixjson",
        "black",
        "shellcheck",
        "cmakelang",
        "jsonlint",
        "markdownlint",
        "quick-lint-js",
        "shellcheck",
        "shfmt",
        "rustfmt",
        "cpplint",
        "codespell",
        "rubyfmt",
    },
})
