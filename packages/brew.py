installCmd = "brew install"

c_pkgs      = ("gcc cpputest ")
python_pkgs = ("python uv ")
go_pkgs     = ("go gopls ")
zig_pkgs    = ("zig zls ")
lua_pkgs    = ("lua ")
js_pkgs     = ("node oven-sh/bun/bun ")
ai_pkgs     = ("opencode ")
editor_pkgs = ("neovim vim ripgrep fd fzf bat tree-sitter-cli ")
cli         = ("git git-lfs tmux tree fastfetch btop nanocom ")
keyring     = ("gpg pinentry-mac ")
cask        = ("ghostty wezterm dbeaver-community postman slack visual-studio-code zed zoom "
		       "font-jetbrains-mono-nerd-font ")

dev       = (c_pkgs + python_pkgs + go_pkgs + zig_pkgs + lua_pkgs + js_pkgs + ai_pkgs + editor_pkgs)
linuxPkgs = (dev)
macPkgs   = (cli + dev + keyring)
