-- automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP =
    fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
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
      return require("packer.util").float {border = "rounded"}
    end
  }
}

-- Install plugins
return packer.startup(function(use)
  -- packer manage it self
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  
  use "typicode/bg.nvim"
  use "folke/tokyonight.nvim"
  
  use {
    "neovim/nvim-lspconfig",
    requires = {
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"L3MON4D3/LuaSnip"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"hrsh7th/cmp-nvim-lsp-signature-help"},
      {"saadparwaiz1/cmp_luasnip"},
    }
  }
  
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"}
    }
  }
  
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    requires = {
      {"nvim-treesitter/nvim-treesitter-context"}
    }
  }
  
  use {
    "romgrk/barbar.nvim",
    requires = {
      {"nvim-tree/nvim-web-devicons"},
      {"lewis6991/gitsigns.nvim"},
    }
  }

  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  })

  use {
    "numToStr/Comment.nvim",
    config = function() require('Comment').setup() end
  }

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }
  
  if PACKER_BOOTSTRAP then
      require("packer").sync()
  end
end)
