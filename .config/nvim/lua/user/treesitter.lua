-- safe call to check if treesitter is installed
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {"c", "cpp", "rust", "go", "python", "lua", "bash", "json", "make", "markdown"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}
