local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

configs.setup({
    ensure_installed = 'all',
    sync_install = false,
    ignore_instal = {''},
    autoinstall = true,
    highlight = {
        enable = true,
        disable = {''},
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = {'yaml'},
    },
})
