local M = {}

M.setup = function(_, capabilities, on_attach)
    local typescript_setup, typescript = pcall(require, "typescript")
    if not typescript_setup then
        return
    end
    typescript.setup({
        server = {
            capabilities = capabilities,
            on_attach = on_attach,
        },
    })
end

return M
