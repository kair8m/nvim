return {
    "glepnir/lspsaga.nvim",
    config = function()
        local ok, lspsaga = pcall(require, "lspsaga")
        if not ok then
            return
        end

        lspsaga.setup({
            definition = {
                keys = {
                    edit = "<CR>",
                },
                save_pos = true,
            },
            finder = {
                max_height = 0.5,
                min_width = 30,
                force_max_height = false,
                methods = {
                    "textDocument/typeDefinition",
                },
                keys = {
                    edit = "<CR>",
                },
                silent = true,
            },
            request_timeout = 5000,
            rename = {
                quit = "<Esc>",
            },
            ui = {
                border = "rounded",
            },
            outline = {
                auto_resize = true,
                keys = {
                    expand_or_jump = "<CR>",
                    quit = "q",
                },
            },
            lightbulb = {
                sign = false,
            },
        })
    end,
}
