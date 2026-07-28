vim.pack.add({
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = 'v1'
  },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main'
  },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/numtostr/comment.nvim' },
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/SmiteshP/nvim-navic' },
  { src = 'https://github.com/folke/trouble.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  { src = 'https://github.com/rebelot/kanagawa.nvim' },
  { src = 'https://github.com/typicode/bg.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})
