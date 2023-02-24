local ts_context_status, ts_context = pcall(require, "treesitter-context")

if not ts_context_status then
	return
end

ts_context.setup()
