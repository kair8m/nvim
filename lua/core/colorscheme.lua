local nightfox_status, _ = pcall(require, "nightfox")
if not nightfox_status then
	return
end

vim.cmd("colorscheme duskfox")
