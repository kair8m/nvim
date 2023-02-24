local status_ok, cursorline = pcall(require, "nvim-cursorline")
if not status_ok then
	return
end

cursorline.setup({
	cursorline = {
		enable = true,
		timeout = 10,
		number = true,
	},
	cursorword = {
		enable = true,
		min_length = 3,
		hl = { underline = true },
	},
})
