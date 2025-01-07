local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local status_ok, context = pcall(require, "treesitter-context")
if not status_ok then
  return
end

ts.setup {
  ensure_installed = {
    "c",
    "cpp",
    "rust",
    "go",
    "python",
    "lua",
    "bash",
    "json",
    "make",
    "markdown"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}

context.setup {
  enable = false,
}
