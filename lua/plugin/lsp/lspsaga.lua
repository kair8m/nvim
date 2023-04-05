local saga_status, lspsaga = pcall(require, "lspsaga")
if not saga_status then
	return
end

lspsaga.setup({
	definition = {
		edit = "<CR>",
		vsplit = "<C-c>v",
		split = "<C-c>i",
		tabe = "<C-c>t",
		quit = "q",
	},
	finder = {
		max_height = 0.5,
		min_width = 30,
		force_max_height = false,
		keys = {
			jump_to = "p",
			expand_or_jump = "<CR>",
			vsplit = "s",
			split = "i",
			tabe = "t",
			tabnew = "r",
			quit = { "q", "<ESC>" },
			close_in_preview = "<ESC>",
		},
	},
	request_timeout = 5000, -- for really large projects
	rename = {
		quit = "<Esc>",
	},
	ui = {
		border = "double",
	},
})

vim.wo.winbar = require("lspsaga.symbolwinbar"):get_winbar()
