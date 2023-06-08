-- plugins.lua

local fn = vim.fn

-- Automatically install packer.
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end


-- Reload neovim whenever plugins.lua is written.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Packer uses a popup window.
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    git = {
        clone_timeout = 20, -- Timeout, in seconds, for git clones
    },
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer manages itself

  -- Language Server Protocol
  use {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      lspconfig.gopls.setup{}
      lspconfig.pyright.setup {}
      lspconfig.rust_analyzer.setup {
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
          ['rust-analyzer'] = {},
        },
      }
      lspconfig.tsserver.setup {}
    end,
  }

  -- Utilities
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'neovim/nvim-lspconfig'},
      {'sharkdp/fd'},
      {'nvim-tree/nvim-web-devicons'},
      {'nvim-telescope/telescope-fzf-native.nvim'},
    },
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- Autocompletion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
      'quangnguyen30192/cmp-nvim-ultisnips', 'hrsh7th/cmp-nvim-lua',
      'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
      'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
    }
  }

  -- Snippets
 -- use 'norcalli/snippets.nvim'

  -- Text Manipulation
 -- use 'rstacruz/vim-closer'
 -- use 'tpope/vim-surround'
  -- use 'windwp/nvim-spectre'

  -- Treesitter

  -- Color Schemes
  use {'dracula/vim', as = 'dracula'}
  use {'folke/tokyonight.nvim', as = 'tokyonight'}
  use {'rose-pine/neovim', as = 'rose-pine'}
  use({
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup({
        -- ...
      })

      vim.cmd('colorscheme github_light')
    end
  })


--  use  "mbbill/undotree"

 -- use 'mfussenegger/nvim-dap'


--   use 'sharkdp/fd'
--  use 'nvim-tree/nvim-web-devicons'

  -- Go
  use 'fatih/vim-go'

  -- Python
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require("null-ls")

      -- register any number of sources simultaneously
      local sources = {
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
      }

      null_ls.setup({ sources = sources })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  }
end)
