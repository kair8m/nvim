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
	},
	renderer = {
		highlight_git = true,
		highlight_opened_files = "all",
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
				git = false,
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
