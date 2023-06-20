local status, hlchunk = pcall(require, "hlchunk")
if not status then
	return
end
hlchunk.setup({
	blank = {
		enable = false,
	},
})
