local saga_status, lspsaga = pcall(require, "lspsaga")
if not saga_status then
	return
end

lspsaga.setup({
	definition = {
		keys = {
			edit = "<CR>",
		},
	},
	finder = {
		max_height = 0.5,
		min_width = 30,
		force_max_height = false,
		methods = {
			"textDocument/typeDefinition",
		},
		keys = {
			edit = "<CR>",
		},
	},
	request_timeout = 5000, -- for really large projects
	rename = {
		quit = "<Esc>",
	},
	ui = {
		border = "double",
		kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
	},
	outline = {
		auto_resize = true,
		keys = {
			expand_or_jump = "<CR>",
			quit = "q",
		},
	},
	lightbulb = {
		sign = false,
	},
})
