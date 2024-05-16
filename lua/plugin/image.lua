local status, image = pcall(require, "image")
if not status then
    return
end

image.setup({
    render = {
        min_padding = 5,
        show_label = true,
        use_dither = true,
        foreground_color = false,
        background_color = false,
    },
    events = {
        update_on_nvim_resize = true,
    },
})
