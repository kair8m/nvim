local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

local frappe = require("catppuccin.palettes").get_palette("frappe")
local selected_style = {
    bg = frappe.surface1,
}
bufferline.setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
            all = {
                buffer_selected = selected_style,
                close_button_selected = selected_style,
                tab_separator_selected = selected_style,
                diagnostic_selected = selected_style,
                hint_selected = selected_style,
                hint_diagnostic_selected = selected_style,
                info_selected = selected_style,
                info_diagnostic_selected = selected_style,
                warning_selected = selected_style,
                warning_diagnostic_selected = selected_style,
                error_selected = selected_style,
                error_diagnostic_selected = selected_style,
                modified_selected = selected_style,
                duplicate_selected = selected_style,
                separator_selected = selected_style,
                indicator_selected = selected_style,
                pick_selected = selected_style,
                tab_selected = selected_style,
            },
        },
    }),
    options = {
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        max_prefix_length = 8,
        offsets = {
            {
                filetype = "neo-tree",
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
            style = "icon",
        },
        separator_style = "thin",
    },
})
