local status_ok, bufdel = pcall(require, 'bufdel')
if not status_ok then
    return
end
bufdel.setup {
    next = 'tabs', -- or 'cycle, 'alternate'
    quit = true, -- quit Neovim when last buffer is closed
}
vim.api.nvim_set_keymap('n', '<A-c>', '<CMD>BufDel<CR>', { silent = true })

