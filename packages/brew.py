install_cmd = "brew install"

python_pkgs = "uv "
go_pkgs = "go gopls "
zig_pkgs = "zig zls "
lua_pkgs = "lua lua-language-server "
js_pkgs = "node oven-sh/bun/bun "
ai_pkgs = "opencode "
editor_pkgs = "neovim ripgrep fd fzf bat tree-sitter-cli "
cli = "git git-lfs vim tmux tree fastfetch btop nanocom "
keyring = "gpg pinentry-mac "
cask = (
    "ghostty dbeaver-community postman slack visual-studio-code zed zoom "
    "font-jetbrains-mono-nerd-font "
)

dev = python_pkgs + go_pkgs + zig_pkgs + lua_pkgs + js_pkgs + ai_pkgs + editor_pkgs
mac_pkgs = cli + dev + keyring
