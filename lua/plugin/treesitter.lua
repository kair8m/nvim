local configs_status, configs = pcall(require, 'nvim-treesitter.configs')
if not configs_status then
    return
end

configs.setup({
    ensure_installed = 'all',
    sync_install = false,
    ignore_instal = { '' },
    autoinstall = true,
    highlight = {
        enable = true,
        disable = { '' },
        additional_vim_regex_highlighting = true,
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    indent = {
        enable = true,
        disable = { 'yaml' },
    },
    autotag = {
        enable = true
    },
})
local install_status, install = pcall(require, 'nvim-treesitter.install')
if not install_status then
    return
end

install.update({
    with_sync = true
})
