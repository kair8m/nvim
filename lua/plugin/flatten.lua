local flatten_status, flatten = pcall(require, "flatten")
if not flatten_status then
    return
end

flatten.setup({
    window = {
        open = "alternate",
    },
    hooks = {
        post_open = function(bufnr, _, ft, is_blocking)
            if is_blocking then
                -- Hide the terminal while it's blocking
                require("toggleterm").toggle(0)
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == "gitcommit" then
                vim.api.nvim_create_autocmd("BufWritePost", {
                    buffer = bufnr,
                    once = true,
                    callback = function()
                        -- This is a bit of a hack, but if you run bufdelete immediately
                        -- the shell can occasionally freeze
                        vim.defer_fn(function()
                            vim.api.nvim_buf_delete(bufnr, {})
                        end, 50)
                    end,
                })
            end
        end,
        block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            require("toggleterm").toggle(0)
        end,
    },
    one_per = {
        kitty = false,
    },
})
