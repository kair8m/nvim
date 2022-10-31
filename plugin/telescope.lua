local status_ok, telescope = pcall(require,'telescope')
if not status_ok then
    return
end

telescope.load_extension('fzf')
telescope.load_extension('lsp_handlers')

telescope.setup({
    defaults = {
        -- use fd to "find files" and return absolute paths
        find_command = { "fd", "-t=f", "-a" },
        path_display = { "smart" },
        wrap_results = true
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        lsp_handlers = {
            disable = {},
            location = {
                telescope = {},
                no_results_message = 'No references found',
            },
            symbol = {
                telescope = {},
                no_results_message = 'No symbols found',
            },
            call_hierarchy = {
                telescope = {},
                no_results_message = 'No calls found',
            },
            code_action = {
                telescope = require('telescope.themes').get_dropdown({}),
            },
        },
    }

})

local telescope_api = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', telescope_api.find_files, {})
vim.keymap.set('n', '<C-f>', telescope_api.live_grep, {})
