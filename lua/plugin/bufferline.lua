local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	highlights = {
		buffer_selected = { bold = true },
		diagnostic_selected = { bold = true },
		info_selected = { bold = true },
		info_diagnostic_selected = { bold = true },
		warning_selected = { bold = true },
		warning_diagnostic_selected = { bold = true },
		error_selected = { bold = true },
		error_diagnostic_selected = { bold = true },
	},
	options = {
		show_close_icon = false,
		diagnostics = "nvim_lsp",
		max_prefix_length = 8,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true, -- use a 'true' to enable the default, or set your own character
			},
		},
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and "   " or "   "
			return " " .. icon .. count
		end,
		separator_style = "slope",
	},
})
