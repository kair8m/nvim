local status_ok, fidget = pcall(require, 'fidget')
if not status_ok then
    return
end

fidget.setup({
    window = {
        relative = "win", -- where to anchor, either "win" or "editor"
        blend = 0, -- &winblend for the window
        zindex = 10, -- the zindex value for the window
        border = "rounded", -- style of border for the fidget window
    },
})

