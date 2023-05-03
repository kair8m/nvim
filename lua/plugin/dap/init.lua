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

local persistent_breakpoints_status, persistent_breakpoints = pcall(require, "persistent-breakpoints")
if persistent_breakpoints_status then
	persistent_breakpoints.setup({})
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
	handlers = {
		function(config)
			-- all sources with no handler get passed here
			-- Keep original functionality
			require("mason-nvim-dap").default_setup(config)
		end,
		python = function(config)
			config.adapters = {
				type = "executable",
				command = "python",
				args = {
					"-m",
					"debugpy.adapter",
				},
			}
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

dapui.setup()

require("dap.ext.vscode").load_launchjs(".nvim/launch.json", {
	cppdbg = {
		"c",
		"cpp",
	},
})
