vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    return
end
nvim_tree.setup({
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
                    arrow_closed = "➤",
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

local status_ok2, nvim_tree_api = pcall(require, 'nvim-tree.api')
if not status_ok2 then
    return
end

-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
    local t = 0
    for _, v in pairs(bufs) do
        if v.name:match("NvimTree_") == nil then
            t = t + 1
        end
    end
    return t
end

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and
            vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil and
            modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0 then
            vim.cmd "quit"
        end
    end
})

