local status, silicon = pcall(require, "silicon")
if not status then
	return
end
local _, _ = pcall(silicon.setup, {
	background = "#87f",
	theme = "Dracula",
	line_number = true,
	pad_vert = 80,
	pad_horiz = 50,
	watermark = {
		text = "@kair8m",
	},
	window_title = function()
		return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ":~:.")
	end,
})
