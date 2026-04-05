return {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 1001,
    config = function()
        local saved_terminal

        require("flatten").setup({
            window = {
                open = "alternate",
            },
            hooks = {
                pipe_path = function()
                    return vim.env.NVIM
                end,
                pre_open = function()
                    local ok, term = pcall(require, "toggleterm.terminal")
                    if ok then
                        local termid = term.get_focused_id()
                        saved_terminal = term.get(termid)
                    end
                end,
                post_open = function(bufnr, winnr, ft, is_blocking)
                    if is_blocking and saved_terminal then
                        saved_terminal:close()
                    else
                        vim.api.nvim_set_current_win(winnr)
                    end

                    if ft == "gitcommit" or ft == "gitrebase" then
                        vim.api.nvim_create_autocmd("BufWritePost", {
                            buffer = bufnr,
                            once = true,
                            callback = function()
                                vim.defer_fn(function()
                                    vim.api.nvim_buf_delete(bufnr, {})
                                end, 50)
                            end,
                        })
                    end
                end,
                block_end = function()
                    if saved_terminal then
                        vim.schedule(function()
                            saved_terminal:open()
                            saved_terminal = nil
                        end)
                    end
                end,
            },
        })
    end,
}
