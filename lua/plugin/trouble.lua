local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end
trouble.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	position = "right",
	auto_open = false,
	use_diagnostics_signs = true,
	icons = true,
	signs = {
		-- icons / text used for a diagnostic
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠",
	},
})
