local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim' -- Packagemanager
    use 'Mofiqul/dracula.nvim' -- Colorscheme
    use 'EdenEast/nightfox.nvim' -- Packer

    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'folke/lsp-colors.nvim'
    use {
        'L3MON4D3/LuaSnip',
        tag = 'v<CurrentMajor>.*'
    }
    use 'rafamadriz/friendly-snippets'

    use {
        'nvim-tree/nvim-tree.lua', -- NERD Tree analog
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use {
        'nvim-treesitter/nvim-treesitter', -- Syntax highlighting
        'nvim-treesitter/nvim-treesitter-textobjects',
        run = ':TSUpdate'
    }

    use 'nvim-lua/plenary.nvim' -- Collection of usefull lua libraries

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'yamatsum/nvim-cursorline'

    -- using packer.nvim
    use { 'akinsho/bufferline.nvim', tag = 'v3.*', requires = 'kyazdani42/nvim-web-devicons' }

    -- Lua
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
    }

    use {
        'gbrlsnchs/telescope-lsp-handlers.nvim',
        requires = {
            'nvim-telescope/telescope.nvim'
        }
    }

    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'lukas-reineke/indent-blankline.nvim'

    use 'akinsho/toggleterm.nvim'

    use 'karb94/neoscroll.nvim'

    use 'terrortylor/nvim-comment'

    use 'windwp/nvim-autopairs'

    use 'j-hui/fidget.nvim'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'jose-elias-alvarez/typescript.nvim'
    use 'onsails/lspkind.nvim'

    use{  'glepnir/lspsaga.nvim', branch ='main' }

    use 'WhoIsSethDaniel/mason-tool-installer.nvim'

    use {
        'kylechui/nvim-surround',
        rag = '*'
    }

    use 'ojroques/nvim-bufdel'

    use 'xiyaowong/nvim-transparent'

    use 'jose-elias-alvarez/null-ls.nvim'

    use 'jayp0521/mason-null-ls.nvim'

    use 'windwp/nvim-ts-autotag'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

