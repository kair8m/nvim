local peek_status, peek = pcall(require, "peek")
if not peek_status then
	return
end

vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
vim.api.nvim_create_user_command("PeekClose", peek.close, {})
