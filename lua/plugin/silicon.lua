local silicon_status, silicon = pcall(require, 'silicon')
if not silicon_status then
    return
end
silicon.setup({
    font = 'Hack=20',
    theme = 'Dracula',
    background = '#676cb5',
    shadow = {
        blur_radius = 0.0,
        offset_x = 0,
        offset_y = 0,
        color = '#555'
    },
    pad_horiz = 100,
    pad_vert = 80,
    line_number = true,
    line_pad = 2,
    line_offset = 1,
    tab_width = 4,
    round_corner = true,
    window_controls = true,
    watermark = {
        text = nil, -- add this to enable watermark on the bottom-right.
        color = '#222',
        style = 'bold', -- possible values: 'bold' | 'italic' | 'bolditalic' | anything else defaults to 'regular'.
    },
})

