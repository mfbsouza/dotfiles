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
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/SmiteshP/nvim-navic' },
  { src = 'https://github.com/folke/trouble.nvim' },
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
    title_flags = false,
    border = 'single',
    preview = {
      title = false,
      layout = 'vertical',
      vertical = 'down:65%',
    },
  },
  files = {
    file_icons = false,
    previewer = false,
    winopts = {
      width = 0.40,
      height = 0.50,
    },
  },
  buffers = {
    file_icons = false,
    previewer = false,
    winopts = {
      width = 0.40,
      height = 0.50,
    },
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
          { 'label', 'label_description', gap = 1 },
        },
      }
    },
  },
  sources = {
    default = { 'lsp', 'path' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  keymap = {
    preset = 'default',
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
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

require('neo-tree').setup({
  hide_root_node = true,
  close_if_last_window = true,
  enable_diagnostics = false,
  renderers = {
    file = {
      { 'indent' },
      { 'name', use_git_status_colors = true },
      { 'bufnr' },
      { 'modified', zindex = 20, align = 'right' },
    },
  },
})
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle reveal<CR>')
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function()
    vim.opt_local.buflisted = false
  end,
  desc = 'Prevent neo-tree from appearing in the buffer list',
})

local trouble = require('trouble')
trouble.setup({})
vim.api.nvim_set_hl(0, 'TroubleNormal', { bg = '#282828' })
vim.api.nvim_set_hl(0, 'TroubleNormalNC', { bg = '#282828' })
vim.api.nvim_set_hl(0, 'TroubleCount', { bg = '#282828' })
local navic = require('nvim-navic')
navic.setup({
  lsp = {
    auto_attach = true,
  },
})

local custom_theme = require('lualine.themes.gruvbox')
local static_color = { bg = '#282828', fg = '#ebdbb2' }

custom_theme.normal.a = static_color
custom_theme.normal.b = static_color
custom_theme.normal.c = static_color
custom_theme.insert.a = static_color
custom_theme.insert.b = custom_theme.normal.b
custom_theme.insert.c = custom_theme.normal.c
custom_theme.visual.a = static_color
custom_theme.visual.b = custom_theme.normal.b 
custom_theme.visual.c = custom_theme.normal.c 
custom_theme.replace.a = static_color
custom_theme.replace.b = custom_theme.normal.b
custom_theme.replace.c = custom_theme.normal.c
custom_theme.command.a = static_color
custom_theme.command.b = custom_theme.normal.b
custom_theme.command.c = custom_theme.normal.c

require('lualine').setup({
  options = {
    theme = custom_theme,
    disabled_filetypes = {
      statusline = { 'neo-tree', 'fzf' },
      winbar = { 'neo-tree', 'fzf' },
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'filename', path = 1, shorting_target = 40,
        cond = function()
          return vim.bo.filetype ~= 'neo-tree' and vim.bo.filetype ~= 'fzf'
        end
      },
    },
    lualine_c = {
      {
        function() return navic.get_location() end,
        cond = function() return navic.is_available() end,
      },
    },
    lualine_x = {
      { 'lsp_status' },
      {
        'diagnostics',
        on_click = function()
          trouble.toggle({
          mode = "diagnostics",
          filter = {
            buf = 0,
          },
        }) 
        end,
      },
    },
    lualine_y = {},
    lualine_z = { 'branch' },
  },
})

require('nvim-autopairs').setup()
require('Comment').setup()
require('gitsigns').setup()

vim.cmd('colorscheme gruvbox')
vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#282828' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#282828' })

