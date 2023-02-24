local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.load_extension("fzf")
telescope.load_extension("lsp_handlers")
telescope.load_extension("harpoon")

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		-- use fd to 'find files' and return absolute paths
		find_command = { "fd", "-t=f", "-a", "-i" },
		path_display = { "smart" },
		wrap_results = true,
		prompt_prefix = "🔍 ",
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		mappings = {
			i = {
				["<C-j>"] = {
					actions.move_selection_next,
					type = "action",
				},
				["<C-k>"] = {
					actions.move_selection_previous,
					type = "action",
				},
				["<C-h>"] = {
					actions.preview_scrolling_up,
					type = "action",
				},
				["<C-l>"] = {
					actions.preview_scrolling_down,
					type = "action",
				},
				["<PageDown>"] = {
					actions.cycle_history_next,
					type = "action",
				},
				["<PageUp>"] = {
					actions.cycle_history_prev,
					type = "action",
				},
			},
		},
		history = {
			path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
			limit = 100,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or 'ignore_case' or 'respect_case'
			-- the default case_mode is 'smart_case'
		},
		lsp_handlers = {
			disable = {},
			location = {
				telescope = {},
				no_results_message = "No references found",
			},
			symbol = {
				telescope = {},
				no_results_message = "No symbols found",
			},
			call_hierarchy = {
				telescope = {},
				no_results_message = "No calls found",
			},
			code_action = {
				telescope = require("telescope.themes").get_dropdown({}),
			},
		},
	},
})
telescope.load_extension("smart_history")
vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
