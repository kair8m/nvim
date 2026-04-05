return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
        local status_ok, lualine = pcall(require, "lualine")
        if not status_ok then
            return
        end

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
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

        local config = {
            options = {
                component_separators = "",
                section_separators = "",
                theme = "catppuccin-frappe",
                disabled_filetypes = { "packer", "neo-tree" },
                disabled_buftypes = { "quickfix", "prompt" },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left({
            "mode",
            fmt = function(str)
                return str:sub(1, 6)
            end,
        })

        ins_left({
            "macro-recording",
            fmt = show_macro_recording,
        })

        ins_left({
            "filesize",
            cond = conditions.buffer_not_empty,
        })

        ins_left({
            "filename",
            cond = conditions.buffer_not_empty,
            file_status = true,
            newfile_status = true,
            path = 1,
            shorting_target = 40,
            symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
            },
        })

        ins_left({ "location" })
        ins_left({ "progress" })

        ins_left({
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "Error ", warn = "Warn ", info = "Info " },
        })

        ins_left({
            function()
                return "%="
            end,
        })

        ins_left({
            function()
                local msg = "No Active Lsp"
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_clients()
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
            icon = "LSP:",
        })

        ins_right({
            "o:encoding",
            fmt = string.upper,
            cond = conditions.hide_in_width,
        })

        ins_right({
            "fileformat",
            fmt = string.upper,
            icons_enabled = false,
        })

        ins_right({
            "branch",
            icon = "",
        })

        ins_right({
            "diff",
            cond = conditions.hide_in_width,
        })

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
                local timer = assert(vim.uv.new_timer())
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
    end,
}
