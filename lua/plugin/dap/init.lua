local dap_mason_status, dap_mason = pcall(require, 'mason-nvim-dap')
if not dap_mason_status then
    return
end

local dap_status, dap = pcall(require, 'dap')
if not dap_status then
    return
end

local dapui_status, dapui = pcall(require, 'dapui')
if not dapui_status then
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

dap_mason.setup({
    ensure_installed = {
        'python',
        'cppdbg',
        'codelldb',
        'node2',
        'bash',
        'stylua'
    }
})

dap.adapters.lldb = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. "/mason/bin/codelldb",
    name = 'lldb',
    args = { '--port', '0' }
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
