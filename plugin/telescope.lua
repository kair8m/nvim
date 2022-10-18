local telescope = require('telescope')

telescope.setup({
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
})


require('telescope').load_extension('fzf')

local telescope_api = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', telescope_api.find_files, {})
vim.keymap.set('n', '<C-f>', telescope_api.live_grep, {})
