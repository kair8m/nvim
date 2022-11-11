local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
    return
end
lualine.setup({
    options = { theme = 'dracula' },
    sections = {
        lualine_a = {
            {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
        }

    }
})
