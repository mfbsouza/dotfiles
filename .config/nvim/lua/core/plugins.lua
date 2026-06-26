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
  { src = 'https://github.com/navarasu/onedark.nvim' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  { src = 'https://github.com/typicode/bg.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

local colorscheme = 'kanagawa'

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})

local fzf = require('fzf-lua')
fzf.setup({
  defaults = {
    formatter = "path.filename_first",
  },
  winopts = {
    title_flags = false,
    border = 'single',
    preview = {
      title = false,
      layout = 'vertical',
      vertical = 'down:65%',
    },
  },
  grep = {
    file_icons = false,
  },
  files = {
    file_icons = false,
    previewer = false,
    winopts = {
      width = 0.50,
      height = 0.60,
    },
  },
  buffers = {
    file_icons = false,
    previewer = false,
    winopts = {
      width = 0.50,
      height = 0.60,
    },
  },
})
vim.keymap.set('n', 'ff', fzf.files, { desc = 'fzf find files' })
vim.keymap.set('n', 'fg', fzf.live_grep, { desc = 'fzf live grep' })
vim.keymap.set('n', 'fb', fzf.buffers, { desc = 'fzf buffers' })
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
  snippets = {
    preset = 'default',
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
local navic = require('nvim-navic')
navic.setup({
  lsp = {
    auto_attach = true,
  },
})

if colorscheme == 'gruvbox' then
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
end

function GetCurrentDiagnostic()
  bufnr = 0
  line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
  opts = { ["lnum"] = line_nr }

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then
    return
  end

  local best_diagnostic = nil

  for _, diagnostic in ipairs(line_diagnostics) do
    if
      best_diagnostic == nil or diagnostic.severity < best_diagnostic.severity
    then
      best_diagnostic = diagnostic
    end
  end

  return best_diagnostic
end

function GetCurrentDiagnosticString()
  local diagnostic = GetCurrentDiagnostic()

  if not diagnostic or not diagnostic.message then
    return
  end

  local message = vim.split(diagnostic.message, "\n")[1]
  local max_width = vim.api.nvim_win_get_width(0) - 35

  if string.len(message) < max_width then
    return message
  else
    return string.sub(message, 1, max_width) .. "..."
  end
end

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
      { 'GetCurrentDiagnosticString()' },
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
    lualine_y = { 'location' },
    lualine_z = { 'branch' },
  },
})

require('nvim-autopairs').setup()
require('Comment').setup()
require('gitsigns').setup()

if colorscheme == 'onedark' then
  require('onedark').setup {
      style = 'dark'
  }
  require('onedark').load()
  vim.api.nvim_set_hl(0, 'TroubleNormal', { bg = '#282c34' })
  vim.api.nvim_set_hl(0, 'TroubleNormalNC', { bg = '#282c34' })
  vim.api.nvim_set_hl(0, 'TroubleCount', { bg = '#282c34' })
elseif colorscheme == 'kanagawa' then
  require('kanagawa').setup({
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none"
          }
        }
      }
    }
  })
  vim.cmd('colorscheme kanagawa')
else
  vim.cmd('colorscheme' .. ' ' .. colorscheme)
  if colorscheme == 'gruvbox' then
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#282828' })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#282828' })
    vim.api.nvim_set_hl(0, 'TroubleNormal', { bg = '#282828' })
    vim.api.nvim_set_hl(0, 'TroubleNormalNC', { bg = '#282828' })
    vim.api.nvim_set_hl(0, 'TroubleCount', { bg = '#282828' })
  end
end

