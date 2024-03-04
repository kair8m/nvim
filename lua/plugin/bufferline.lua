local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        max_prefix_length = 8,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true, -- use a 'true' to enable the default, or set your own character
            },
        },
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "   " or "   "
            return " " .. icon .. count
        end,
        indicator = {
            style = "underline",
        },
        separator_style = "slope",
    },
})
