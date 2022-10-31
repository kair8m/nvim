local status_ok, nvim_autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
    return
end

nvim_autopairs.setup({
    check_ts = true
})
