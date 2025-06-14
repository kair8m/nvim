-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "neovim/nvim-lspconfig" }, -- Configurations for Nvim LSP
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol" },
    { "saadparwaiz1/cmp_luasnip" },
    { "andersevenrud/cmp-tmux" },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    {
        "mihyaeru21/nvim-lspconfig-bundler",
        dependencies = { "neovim/nvim-lspconfig" },
    },
    { "nvim-treesitter/nvim-treesitter" }, -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    { "nvim-lua/plenary.nvim" }, -- Collection of useful lua libraries

    { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },

    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.8",
        -- or                            , branch = '0.1.x',
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },

    {
        "akinsho/bufferline.nvim",
        branch = "main",
        dependencies = "nvim-tree/nvim-web-devicons",
    },

    { "gbrlsnchs/telescope-lsp-handlers.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
    { "smartpde/telescope-recent-files",       dependencies = { "nvim-telescope/telescope.nvim" } },
    { "kkharji/sqlite.lua" },

    {
        "nvim-telescope/telescope-frecency.nvim",
    },

    { "lewis6991/gitsigns.nvim" },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "akinsho/toggleterm.nvim" },

    { "windwp/nvim-autopairs" },

    { "mfussenegger/nvim-dap" },
    { "folke/neodev.nvim" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },
    { "theHamsta/nvim-dap-virtual-text" },

    { "nvim-telescope/telescope-dap.nvim" },
    { "nvim-telescope/telescope-media-files.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "jay-babu/mason-nvim-dap.nvim" },
    { "onsails/lspkind.nvim" },

    { "glepnir/lspsaga.nvim" },

    { "WhoIsSethDaniel/mason-tool-installer.nvim" },

    {
        "kylechui/nvim-surround",
        version = "*",
    },

    { "ojroques/nvim-bufdel" },

    { "nvimtools/none-ls.nvim" },

    { "jayp0521/mason-null-ls.nvim" },

    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
    },

    { "folke/which-key.nvim" },

    { "simrat39/rust-tools.nvim" },

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    { "mbbill/undotree" },

    { "ThePrimeagen/harpoon" },

    { "kair8m/git-worktree.nvim" },

    { "toppair/peek.nvim",       build = "deno task --quiet build:fast" },

    { "peterhoeg/vim-qml" },

    {
        "willothy/flatten.nvim",
        lazy = false,
        priority = 1001,
    },

    { "f-person/git-blame.nvim" },

    { "chrisgrieser/nvim-spider" },

    { "Wansmer/treesj" },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
        },
    },

    {
        "folke/noice.nvim",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },

    { "ray-x/starry.nvim" },

    { "catppuccin/nvim",            name = "catppuccin", priority = 1000 },

    { "luukvbaal/statuscol.nvim" },

    { "norcalli/nvim-colorizer.lua" },

    { "andrewferrier/wrapping.nvim" },

    -- integrated testing plugins
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
        },
    },
    { "alfaix/neotest-gtest" },

    { "phaazon/hop.nvim",     branch = "v2" },

    { "tpope/vim-fugitive" },

    { "RRethy/vim-illuminate" },
    {
        "m4xshen/smartcolumn.nvim",
        opts = {},
    },

    {
        "numToStr/Comment.nvim",
        opts = {},
    },

    {
        "ethanholz/nvim-lastplace",
        opts = {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            lastplace_open_folds = true,
        },
    },
    {
        "utilyre/sentiment.nvim",
        version = "*",
        opts = {},
    },
    {
        "windwp/nvim-ts-autotag",
    },
    {
        "haringsrob/nvim_context_vt",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = { disable_virtual_lines = true },
    },
    {
        "nacro90/numb.nvim",
        opts = {},
    },
    {
        "sindrets/diffview.nvim",
    },

    { "akinsho/git-conflict.nvim", version = "*" },

    {
        "RaafatTurki/hex.nvim",
        opts = {},
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup({})
        end,
    },
}, {
    install = {
        colorscheme = { "catppuccin-frappe" },
    },
    ui = {
        border = "double",
    },
})
