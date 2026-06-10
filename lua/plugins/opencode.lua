return {
    "nickjvandyke/opencode.nvim",
    version = "*",
    lazy = false,
    config = function()
        vim.g.opencode_opts = {
            server = {
                port = nil,
                start = function()
                    require("opencode.terminal").open("opencode --port", {
                        split = "right",
                        width = math.floor(vim.o.columns * 0.35),
                    })
                end,
                stop = function()
                    require("opencode.terminal").close()
                end,
                toggle = function()
                    require("opencode.terminal").toggle("opencode --port", {
                        split = "right",
                        width = math.floor(vim.o.columns * 0.35),
                    })
                end,
            },
        }

        vim.o.autoread = true

        vim.keymap.set({ "n", "x" }, "<leader>ca", function()
            require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask opencode…" })

        vim.keymap.set({ "n", "x" }, "<leader>cs", function()
            require("opencode").select()
        end, { desc = "Execute opencode action…" })

        vim.keymap.set({ "n" }, "<leader>ct", function()
            require("opencode").toggle()
        end, { desc = "Toggle opencode" })

        vim.keymap.set({ "n", "x" }, "<leader>co", function()
            return require("opencode").operator("@this ")
        end, { desc = "Add range to opencode", expr = true })

        vim.keymap.set("n", "<leader>cO", function()
            return require("opencode").operator("@this ") .. "_"
        end, { desc = "Add line to opencode", expr = true })

        vim.keymap.set("n", "<leader>ci", function()
            require("opencode").command("session.interrupt")
        end, { desc = "Interrupt opencode" })

        vim.keymap.set("n", "<leader>cn", function()
            require("opencode").command("session.new")
        end, { desc = "New opencode session" })
    end,
}
