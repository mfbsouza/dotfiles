vim.pack.add({
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/saghen/blink.cmp', version = 'v1' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/numtostr/comment.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  { src = 'https://github.com/typicode/bg.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})

local fzf = require('fzf-lua')
fzf.setup({
  winopts = {
    border = 'single',
    preview = {
      layout = "vertical",
      vertical = "down:65%",
    },
  },
  files = {
    file_icons = false,
    previewer = false,
  },
  buffers = {
    file_icons = false,
    previewer = false,
  },
})
vim.keymap.set('n', 'ff', fzf.files, { desc = 'fzf find files' })
vim.keymap.set('n', 'fg', fzf.live_grep, { desc = 'fzf live grep' })
vim.keymap.set('n', 'fb', fzf.buffers, { desc = 'fzf buffers' })
vim.keymap.set('n', 'fo', fzf.lsp_document_symbols, { desc = 'fzf document symbols' })
vim.keymap.set('n', 'fz', fzf.builtin, { desc = 'fzf builtin' })

require('blink-cmp').setup({
  completion = {
    documentation = { auto_show = false },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
        },
      }
    },
  },
  sources = {
    default = { "lsp", "path" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  keymap = {
    preset = "default",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ['<CR>'] = { 'accept', 'fallback' },
  },
  cmdline = {
    keymap = {
      ['<CR>'] = { 'accept', 'fallback' },
    },
  },
})

require('nvim-treesitter').setup({
  ensure_installed = { "c", "lua", "python", "go" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})

require('ibl').setup({
  indent = { char = "▏" },
  scope = { enabled = false },
})

require('nvim-autopairs').setup()
require('Comment').setup()
require('gitsigns').setup()

vim.cmd('colorscheme tokyonight-night')

