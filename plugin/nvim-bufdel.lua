vim.api.nvim_set_keymap('n', '<A-c>', '<CMD>BufDel<CR>', { silent = true })

require('bufdel').setup {
    next = 'tabs', -- or 'cycle, 'alternate'
    quit = true, -- quit Neovim when last buffer is closed
}

