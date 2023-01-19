local saga_status, lspsaga = pcall(require, 'lspsaga')
if not saga_status then
    return
end

lspsaga.setup({
    definition = {
        tabe = '<CR>'
    },
    finder = {
        tabe = '<CR>'
    },
    request_timeout = 5000, -- for really large projects
    rename = {
        quit = '<Esc>'
    },
    ui = {
        border = 'double',
    }
})

vim.wo.winbar = require('lspsaga.symbolwinbar'):get_winbar()
