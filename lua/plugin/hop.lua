local status, hop = pcall(require, "hop")
if not status then
	return
end
hop.setup({ keys = "etovxqpdygfblzhckisuran" })
vim.api.nvim_set_keymap("n", "s", ":HopChar1<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
