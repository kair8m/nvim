vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end
nvim_tree.setup({
    update_cwd = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    view = {
        adaptive_size = true,
        number = true,
        relativenumber = true,
    },
    renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        indent_markers = {
            enable = true,
            inline_arrows = true,
        },
        icons = {
            webdev_colors = true,
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
                modified = true,
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
    },
})
