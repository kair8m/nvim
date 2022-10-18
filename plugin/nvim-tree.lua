require('nvim-tree').setup({
    update_cwd = true,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        highlight_git = true,
        highlight_opened_files = 'all',
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            webdev_colors = true,
            show = {
                git = false
            },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
})

nvim_tree_api = require('nvim-tree.api')

vim.keymap.set({'n', 'i'}, '<C-n>', function()
    -- proj_root = vim.fn.system('git rev-parse --show-toplevel 2> /dev/null')
    --if not (proj_root == nil or proj_root == '') then
    --    nvim_tree_api.tree.change_root(proj_root)
    --end
    nvim_tree_api.tree.toggle()
end)
