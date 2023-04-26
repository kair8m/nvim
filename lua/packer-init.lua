local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim") -- Packagemanager
	use("Mofiqul/dracula.nvim") -- Colorscheme
	use("EdenEast/nightfox.nvim") -- Packer

	use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-nvim-lsp-document-symbol")
	use({ "saadparwaiz1/cmp_luasnip" })
	use({
		"L3MON4D3/LuaSnip",
		tag = "v1.2.1",
	})
	use("rafamadriz/friendly-snippets")

	use({
		"nvim-tree/nvim-tree.lua", -- NERD Tree analog
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	use("nvim-treesitter/nvim-treesitter") -- Syntax highlighting
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/playground")
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		opt = true,
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
	use({
		"windwp/nvim-ts-autotag",
		opt = true,
		requires = { "nvim-treesitter/nvim-treesitter" },
	})

	use("nvim-lua/plenary.nvim") -- Collection of useful lua libraries

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- using packer.nvim
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "kyazdani42/nvim-web-devicons" })

	-- Lua
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use({
		"gbrlsnchs/telescope-lsp-handlers.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
		},
	})

	use("kkharji/sqlite.lua")

	use({
		"nvim-telescope/telescope-smart-history.nvim",
		requires = {
			"kkharji/sqlite.lua",
		},
	})

	use({
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use("akinsho/toggleterm.nvim")

	use("terrortylor/nvim-comment")

	use("windwp/nvim-autopairs")

	use("mfussenegger/nvim-dap")
	use("folke/neodev.nvim")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "theHamsta/nvim-dap-virtual-text" })
	use({ "Weissle/persistent-breakpoints.nvim" })

	use("nvim-telescope/telescope-dap.nvim")
	use({ "nvim-telescope/telescope-media-files.nvim", requires = { "nvim-telescope/telescope.nvim" } })

	use("ldelossa/nvim-dap-projects")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jay-babu/mason-nvim-dap.nvim")
	use("jose-elias-alvarez/typescript.nvim")
	use("onsails/lspkind.nvim")

	use({ "glepnir/lspsaga.nvim", branch = "main" })

	use("WhoIsSethDaniel/mason-tool-installer.nvim")

	use({
		"kylechui/nvim-surround",
		tag = "*",
	})

	use("ojroques/nvim-bufdel")

	use("jose-elias-alvarez/null-ls.nvim")

	use("jayp0521/mason-null-ls.nvim")

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	use("folke/which-key.nvim")

	use("simrat39/rust-tools.nvim")
	use("simrat39/inlay-hints.nvim")

	use("rust-lang/rust.vim")

	use("christoomey/vim-tmux-navigator")

	use("simrat39/symbols-outline.nvim")

	use("mbbill/undotree")

	use("ThePrimeagen/harpoon")

	use("segeljakt/vim-silicon")

	use("ThePrimeagen/git-worktree.nvim")

	use({ "toppair/peek.nvim", run = "deno task --quiet build:fast" })

	use({
		"startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})

	use({ "m00qek/baleia.nvim", tag = "v1.2.0" })

	use({
		"samodostal/image.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	use("peterhoeg/vim-qml")

	use("willothy/flatten.nvim")

	use("f-person/git-blame.nvim")

	use({ "chrisgrieser/nvim-spider" })

	use("bennypowers/splitjoin.nvim")

	use("koenverburg/peepsight.nvim")

	-- Packer
	use({
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				-- add any options here
			})
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})

	use("ray-x/starry.nvim")

	use("ahmedkhalf/project.nvim")

	use({ "catppuccin/nvim", as = "catppuccin" })

	use("luukvbaal/statuscol.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
