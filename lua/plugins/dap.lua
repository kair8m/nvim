return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        local dap_mason_status, dap_mason = pcall(require, "mason-nvim-dap")
        local dap_status, dap = pcall(require, "dap")
        local dapui_status, dapui = pcall(require, "dapui")

        if not (dap_status and dapui_status) then
            return
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

        if dap_mason_status then
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
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    python = function(config)
                        config.adapters = {
                            type = "executable",
                            command = "python",
                            args = { "-m", "debugpy.adapter" },
                        }
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })
        end

        dapui.setup()

        vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
        vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
        vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })
    end,
}
