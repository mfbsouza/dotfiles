-- automatically install packer

local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- safe call to check if packer is installed
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install plugins
return packer.startup(function(use)
  -- packer manage it self
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"

  -- colorschemes
  use "typicode/bg.nvim"
  use "folke/tokyonight.nvim"

  -- completion engine
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-signature-help"

  -- snippet engine
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"

  -- language server config
  use "neovim/nvim-lspconfig"
  use {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'}
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "mrcjkb/rustaceanvim"

  -- fuzzy finder
  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"

  -- git integration
  use "lewis6991/gitsigns.nvim"

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- bufferline
  use {
    "akinsho/bufferline.nvim", tag = "v3.*",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("bufferline").setup {} end
  }

  -- treeview
  use {
    "nvim-tree/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons"
  }

  -- autopairs
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  -- easily comment code out
  use {
    "numToStr/Comment.nvim",
    config = function() require('Comment').setup() end
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
