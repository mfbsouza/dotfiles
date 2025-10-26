return {
  {
    "folke/tokyonight.nvim",
    dependencies = { "typicode/bg.nvim" },
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight-night")
    end
  }
}

