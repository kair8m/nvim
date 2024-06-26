local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.load_extension("fzf")
telescope.load_extension("lsp_handlers")
telescope.load_extension("harpoon")
telescope.load_extension("dap")
telescope.load_extension("media_files")
telescope.load_extension("recent_files")
telescope.load_extension("live_grep_args")

local telescope_history_db_file = vim.env.HOME .. "/.local/share/nvim/databases/telescope_history.sqlite3"

local history_opts = {}

local _, err = io.open(telescope_history_db_file, "w")
if err ~= nil then
    print(string.format("Failed to create {%s}: %s", telescope_history_db_file, err))
end
if vim.fn.filereadable(telescope_history_db_file) then
    history_opts = {
        path = telescope_history_db_file,
        limit = 100,
    }
end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        dynamic_preview_title = true,
        -- use fd to 'find files' and return absolute paths
        find_command = { "fd", "-t=f", "-a", "-i" },
        path_display = { "truncate" },
        wrap_results = true,
        prompt_prefix = "🔍 ",
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        mappings = {
            i = {
                ["<C-j>"] = {
                    actions.move_selection_next,
                    type = "action",
                },
                ["<C-k>"] = {
                    actions.move_selection_previous,
                    type = "action",
                },
                ["<C-h>"] = {
                    actions.preview_scrolling_up,
                    type = "action",
                },
                ["<C-l>"] = {
                    actions.preview_scrolling_down,
                    type = "action",
                },
                ["<C-d>"] = {
                    actions.results_scrolling_down,
                    type = "action",
                },
                ["<C-u>"] = {
                    actions.results_scrolling_up,
                    type = "action",
                },
                ["<PageDown>"] = {
                    actions.cycle_history_next,
                    type = "action",
                },
                ["<PageUp>"] = {
                    actions.cycle_history_prev,
                    type = "action",
                },
            },
        },
        history = history_opts,
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or 'ignore_case' or 'respect_case'
            -- the default case_mode is 'smart_case'
        },
        lsp_handlers = {
            disable = {},
            location = {
                telescope = {},
                no_results_message = "No references found",
            },
            symbol = {
                telescope = {},
                no_results_message = "No symbols found",
            },
            call_hierarchy = {
                telescope = {},
                no_results_message = "No calls found",
            },
            code_action = {
                telescope = require("telescope.themes").get_dropdown({}),
            },
            file_browser = {
                theme = "ivy",
                hijack_netrw = true,
            },
        },
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "jpg", "mp4", "webm", "pdf", "svg" },
            -- find command (defaults to `fd`)
            find_cmd = "rg",
        },
        recent_files = {
            only_cwd = true,
        },
    },
})
telescope.load_extension("smart_history")
telescope.load_extension("file_browser")
vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
