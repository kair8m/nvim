local M = {}

local codelldp_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

M.setup = function(_, _, on_attach)
    local rust_tools_status, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status then
        return
    end
    rust_tools.setup({
        server = {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                if client.name == "rust_analyzer" then
                    vim.keymap.set("n", "gq", "<CMD>RustFmt<CR>", { buffer = bufnr })
                    -- Displays hover information about the symbol under the cursor
                    vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
                    -- Selects a code action available at the current cursor position
                    vim.keymap.set(
                        "n",
                        "<leader>la",
                        rust_tools.code_action_group.code_action_group,
                        { buffer = bufnr }
                    )
                end
            end,
        },
        tools = {
            runnables = {
                use_telescope = true,
            },
            inlay_hints = {
                auto = true,
                show_parameter_hints = true,
            },
        },
        dap = {
            type = "executable",
            name = "rt_lldb",
            command = codelldp_path,
        },
    })
end

return M
