local dap_mason_status, dap_mason = pcall(require, "mason-nvim-dap")
if not dap_mason_status then
	return
end

local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

local dapui_status, dapui = pcall(require, "dapui")
if not dapui_status then
	return
end

local dap_vtext_status, dap_vtext = pcall(require, "nvim-dap-virtual-text")
if dap_vtext_status then
    dap_vtext.setup()
end

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap_mason.setup({
	ensure_installed = {
		"python",
		"cppdbg",
		"codelldb",
		"node2",
		"bash",
		"stylua",
	},
	automatic_installation = true,
	automatic_setup = true,
})

dapui.setup()

dap_mason.setup_handlers()

local dap_project_status, dap_project = pcall(require, "nvim-dap-projects")
if not dap_project_status then
	return
end
dap_project.search_project_config()
