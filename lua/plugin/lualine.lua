local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local frappe = require("catppuccin.palettes").get_palette("frappe")

-- Color table for highlights
-- stylua: ignore
local colors = {
    fg      = frappe.white,
    yellow  = frappe.yellow,
    cyan    = frappe.cyan,
    green   = frappe.green,
    orange  = frappe.orange,
    violet  = frappe.mauve,
    magenta = frappe.magenta,
    blue    = frappe.blue,
    red     = frappe.red,
    bg      = frappe.base,
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "-- Recording @" .. recording_register .. " --"
    end
end

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        theme = "catppuccin",
        disabled_filetypes = { "packer", "neo-tree" },
        disabled_buftypes = { "quickfix", "prompt" },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

local function change_mode_color()
    -- auto change color according to neovims mode
    local mode_color = {
        n = { fg = colors.bg, bg = colors.blue }, --      Normal
        no = { fg = colors.bg, bg = colors.blue }, --      Operator-pending
        nov = { fg = colors.bg, bg = colors.blue }, --      Operator-pending (forced charwise |o_v|)
        noV = { fg = colors.bg, bg = colors.blue }, --     Operator-pending (forced linewise |o_V|)
        ["noCTRL-V"] = { fg = colors.bg, bg = colors.blue }, -- Operator-pending (forced blockwise |o_CTRL-V|)
        niI = { fg = colors.bg, bg = colors.blue }, --     Normal using |i_CTRL-O| in |Insert-mode|
        niR = { fg = colors.bg, bg = colors.blue }, --     Normal using |i_CTRL-O| in |Replace-mode|
        niV = { fg = colors.bg, bg = colors.blue }, --     Normal using |i_CTRL-O| in |Virtual-Replace-mode|
        nt = { fg = colors.bg, bg = colors.blue }, --     Normal in |terminal-emulator| (insert goes to Terminal mode)
        ntT = { fg = colors.bg, bg = colors.blue }, --     Normal using |t_CTRL-_CTRL-O| in |Terminal-mode|
        v = { fg = colors.bg, bg = colors.yellow }, --     Visual by character
        vs = { fg = colors.bg, bg = colors.yellow }, --     Visual by character using |v_CTRL-O| in Select mode
        V = { fg = colors.bg, bg = colors.yellow }, --     Visual by line
        Vs = { fg = colors.bg, bg = colors.yellow }, --     Visual by line using |v_CTRL-O| in Select mode
        ["CTRL-V"] = { fg = colors.bg, bg = colors.yellow }, --  Visual blockwise
        ["CTRL-Vs"] = { fg = colors.bg, bg = colors.yellow }, -- Visual blockwise using |v_CTRL-O| in Select mode
        s = { fg = colors.bg, bg = colors.blue }, --     Select by character
        S = { fg = colors.bg, bg = colors.blue }, --     Select by line
        ["CTRL-S"] = { fg = colors.bg, bg = colors.blue }, --  Select blockwise
        i = { fg = colors.bg, bg = colors.green }, --     Insert
        ic = { fg = colors.bg, bg = colors.green }, --     Insert mode completion |compl-generic|
        ix = { fg = colors.bg, bg = colors.green }, --     Insert mode |i_CTRL-X| completion
        R = { fg = colors.bg, bg = colors.red }, --     Replace |R|
        Rc = { fg = colors.bg, bg = colors.red }, --     Replace mode completion |compl-generic|
        Rx = { fg = colors.bg, bg = colors.red }, --     Replace mode |i_CTRL-X| completion
        Rv = { fg = colors.bg, bg = colors.red }, --     Virtual Replace |gR|
        Rvc = { fg = colors.bg, bg = colors.red }, --     Virtual Replace mode completion |compl-generic|
        Rvx = { fg = colors.bg, bg = colors.red }, --     Virtual Replace mode |i_CTRL-X| completion
        c = { fg = colors.bg, bg = colors.violet }, --     Command-line editing
        cv = { fg = colors.bg, bg = colors.violet }, --     Vim Ex mode |gQ|
        r = { fg = colors.bg, bg = colors.violet }, --     Hit-enter prompt
        rm = { fg = colors.bg, bg = colors.violet }, --     The -- more -- prompt
        ["r?"] = { fg = colors.bg, bg = colors.violet }, --     A |:confirm| query of some sort
        ["!"] = { fg = colors.bg, bg = colors.violet }, --     Shell or external command is executing
        t = { fg = colors.bg, bg = colors.violet }, --     Terminal mode: keys go to the job
    }
    return mode_color[vim.fn.mode()]
end

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left({
    "mode",
    fmt = function(str)
        return str:sub(1, 6)
    end,
    color = change_mode_color,
})

ins_left({
    "macro-recording",
    fmt = show_macro_recording,
    color = change_mode_color,
})

ins_left({
    "filesize",
    cond = conditions.buffer_not_empty,
})

ins_left({
    "filename",
    cond = conditions.buffer_not_empty,
    file_status = true, -- Displays file status (readonly status, modified status)
    newfile_status = true, -- Display new file status (new file means no write after created)
    -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as the home directory
    -- 4: Filename and parent dir, with tilde as the home directory
    path = 1,
    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
    symbols = {
        modified = "[+]", -- Text to show when the file is modified.
        readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "[No Name]", -- Text to show for unnamed buffers.
        newfile = "[New]", -- Text to show for newly created file before first write
    },
    color = { fg = colors.green, gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
    function()
        return "%="
    end,
})

ins_left({
    -- Lsp server name .
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = " LSP:",
    color = { fg = "#ffffff", gui = "bold" },
})

-- Add components to right sections
ins_right({
    "o:encoding", -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = "bold" },
})

ins_right({
    "fileformat",
    fmt = string.upper,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = colors.green, gui = "bold" },
})

ins_right({
    "branch",
    icon = "",
    color = { fg = colors.fg, gui = "bold" },
})

ins_right({
    "diff",
    -- symbols = { added = " ", modified = "M ", removed = " " },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
})

-- Now don't forget to initialize lualine
lualine.setup(config)

vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        lualine.refresh({
            place = { "statusline" },
        })
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        -- This is going to seem really weird!
        -- Instead of just calling refresh we need to wait a moment because of the nature of
        -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
        -- still show a recording occurring because `vim.fn.reg_recording` hasn't emptied yet.
        -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
        -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
        local timer = vim.loop.new_timer()
        if not timer then
            return
        end
        timer:start(
            50,
            0,
            vim.schedule_wrap(function()
                lualine.refresh({
                    place = { "statusline" },
                })
            end)
        )
    end,
})
