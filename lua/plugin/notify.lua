local status, notify = pcall(require, "notify")

if not status then
    return
end

local frappe = require("catppuccin.palettes").get_palette("frappe")
notify.setup({
    background_colour = frappe.base,
})
