local status, neotree = pcall(require, "neo-tree")
if not status then
    return
end

neotree.setup({
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function(_)
                vim.cmd([[ setlocal number ]])
                vim.cmd([[ setlocal relativenumber ]])
            end,
        },
    },
})
