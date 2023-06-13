local status, highlight_undo = pcall(require, "highlight-undo")
if not status then
	return
end
highlight_undo.setup({
	hlgroup = "HighlightUndo",
	duration = 500,
	keymaps = {
		{ "n", "u", "undo", {} },
		{ "n", "<C-r>", "redo", {} },
	},
})
