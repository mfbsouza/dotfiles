local function static_theme(base)
  local theme = require('lualine.themes.' .. base)
  local normal = theme.normal
  for _, mode in pairs({ 'insert', 'visual', 'replace', 'command', 'inactive' }) do
    theme[mode] = {
      a = vim.deepcopy(normal.a),
      b = vim.deepcopy(normal.b),
      c = vim.deepcopy(normal.c),
    }
  end
  return theme
end

local function get_current_diagnostic()
  local bufnr = 0
  local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
  local opts = { ["lnum"] = line_nr }

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

local function get_current_diagnostic_string()
  local diagnostic = get_current_diagnostic()

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

local trouble = require('trouble')
local navic = require('nvim-navic')

require('lualine').setup({
  options = {
    theme = static_theme('kanagawa'),
    disabled_filetypes = {
      statusline = { 'neo-tree', 'fzf' },
      winbar = { 'neo-tree', 'fzf' },
    },
  },
  sections = {
    lualine_a = { },
    lualine_b = {
      {
        'filename',
        path = 1,
        shorting_target = 40,
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
    lualine_x = { get_current_diagnostic_string },
    lualine_y = {
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
      { 'lsp_status' },
    },
    lualine_z = { },
  },
})
