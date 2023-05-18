local startup_status, startup = pcall(require, "startup")
if not startup_status then
	return
end

local quote = require("startup.functions").quote()
local settings = {
	-- every line should be same width without escaped \
	header = {
		type = "text",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Header",
		margin = 0,
		content = {
			" ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⠀⢀⠎⠀⠀⠀⠘⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⢠⣾⡖⢦⣰⣿⢲⠸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⢨⠻⢷⣟⠙⠿⠞⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⢸⠦⠤⠷⠶⠶⠂⠀⢸⠀⠀⠀⠀⠀⠀⢀⢀⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⡆⡄⢸⠀⠀⠀⠀⠀⢠⠃⢸⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⡇⡇⢸⣇⡀⠀⠀⡠⠁⢠⠃⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⣸⠃⢻⠈⠈⠉⢙⣳⣥⣄⣀⠔⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⠸⡆⠀⠀⠰⣧⣶⠌⠂⠀⠀⠉⠁⠀⠀⠉⠳⡄⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⠀⠹⢦⣀⣀⣀⡀⠀⢀⣀⣀⡀⠀⢀⣀⡠⠚⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠉⡹⠉⠉⠉⠉⢉⠇⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⠰⡉⠑⠁⢠⠃⠀⠀⣟⠓⠋⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
			" ⠀⠀⠀⠀⠀⠀⠀⠈⠛⠒⠁⠀⠀⠀⠈⠓⠒⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
		},

		highlight = "Statement",
		default_color = "",
		oldfiles_amount = 0,
	},
	-- name which will be displayed and command
	body = {
		type = "mapping",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Basic Commands",
		margin = 5,
		content = {
			{
				" Find File",
				"Telescope find_files",
				"<leader>ff",
			},
			{
				" Find Word",
				"Telescope live_grep",
				"<leader>lg",
			},
			{
				" Recent Files",
				"lua require('telescope').extensions.recent_files.pick({only_cwd=true})",
				"<leader>of",
			},
			{
				" File Browser",
				"Telescope file_browser",
				"<leader>fb",
			},
			{
				" Colorschemes",
				"Telescope colorscheme",
				"<leader>cs",
			},
			{
				" New File",
				"lua require'startup'.new_file()",
				"<leader>nf",
			},
		},
		highlight = "String",
		default_color = "",
		oldfiles_amount = 0,
	},
	body_2 = {
		type = "text",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "",
		margin = 5,
		content = quote,
		highlight = "Statement",
		default_color = "",
		oldfiles_amount = 0,
	},
	footer = {
		type = "text",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Footer",
		margin = 25,
		content = { "@kair8m" },
		highlight = "Number",
		default_color = "",
		oldfiles_amount = 0,
	},
	options = {
		mapping_keys = true,
		cursor_column = 0.5,
		empty_lines_between_mappings = true,
		disable_statuslines = true,
		paddings = { 6, 3, 3, 6 },
	},
	mappings = {
		execute_command = "<CR>",
		open_file = "o",
		open_file_split = "<c-o>",
		open_section = "<TAB>",
		open_help = "?",
	},
	colors = {
		background = "#1f2227",
		folded_section = "#56b6c2",
	},
	parts = {
		"header",
		"body",
		"body_2",
		"footer",
	},
}
startup.setup(settings)
