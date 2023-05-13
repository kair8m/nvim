local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Packer can manage itself
	{ "neovim/nvim-lspconfig" }, -- Configurations for Nvim LSP
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
	{ { "saadparwaiz1/cmp_luasnip" } },
	{
		"L3MON4D3/LuaSnip",
		version = "v1.2.1",
	},

	{
		"nvim-tree/nvim-tree.lua", -- NERD Tree analog
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		version = "nightly", -- optional, updated every week. (see issue #1193)
	},

	{ "nvim-treesitter/nvim-treesitter" }, -- Syntax highlighting
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{ "nvim-lua/plenary.nvim" }, -- Collection of useful lua libraries

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.0",
		-- or                            , branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	-- using packer.nvim
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	{ "gbrlsnchs/telescope-lsp-handlers.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "kkharji/sqlite.lua" },

	{
		"nvim-telescope/telescope-smart-history.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
		},
	},

	{ "lewis6991/gitsigns.nvim" },

	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "akinsho/toggleterm.nvim" },

	{ "terrortylor/nvim-comment" },

	{ "windwp/nvim-autopairs" },

	{ "mfussenegger/nvim-dap" },
	{ "folke/neodev.nvim" },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "Weissle/persistent-breakpoints.nvim" },

	{ "nvim-telescope/telescope-dap.nvim" },
	{ "nvim-telescope/telescope-media-files.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{ "jose-elias-alvarez/typescript.nvim" },
	{ "onsails/lspkind.nvim" },

	{ "glepnir/lspsaga.nvim" },

	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	{
		"kylechui/nvim-surround",
		version = "*",
	},

	{ "ojroques/nvim-bufdel" },

	{ "jose-elias-alvarez/null-ls.nvim" },

	{ "jayp0521/mason-null-ls.nvim" },

	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
	},

	{ "folke/which-key.nvim" },

	{ "simrat39/rust-tools.nvim" },
	{ "simrat39/inlay-hints.nvim" },

	{ "christoomey/vim-tmux-navigator" },

	{ "mbbill/undotree" },

	{ "ThePrimeagen/harpoon" },

	{
		"krivahtoo/silicon.nvim",
		build = "./install.sh build",
	},

	{ "ThePrimeagen/git-worktree.nvim" },

	{ "toppair/peek.nvim", build = "deno task --quiet build:fast" },

	{
		"startup-nvim/startup.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	{
		"samodostal/image.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{ "peterhoeg/vim-qml" },

	{ "willothy/flatten.nvim" },

	{ "f-person/git-blame.nvim" },

	{ "chrisgrieser/nvim-spider" },

	{ "Wansmer/treesj" },

	{ "koenverburg/peepsight.nvim" },

	-- Packer
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

	{ "ray-x/starry.nvim" },

	{ "catppuccin/nvim", name = "catppuccin" },

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

	{ "phaazon/hop.nvim", branch = "v2" },

	{ "tpope/vim-fugitive" },

	{ "RRethy/vim-illuminate" },
}, {
	ui = {
		border = "double",
	},
})