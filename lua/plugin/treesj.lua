local status, treesj = pcall(require, "treesj")
if not status then
	return
end

treesj.setup({
	-- If line after join will be longer than max value,
	-- node will not be formatted
	max_join_length = 1000,
})
