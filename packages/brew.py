installCmd = "brew install"


dev = ("gcc zig zls go gopls lua python node oven-sh/bun/bun "
    "fastfetch neovim vim zsh ripgrep fd fzf ")

cli = ("git git-lfs tmux tree htop nanocom pyenv pyenv-virtualenv ")

keyring = ("gpg pinentry-mac ")

cask = ("wezterm dbeaver-community postman slack visual-studio-code zed zoom "
	"font-jetbrains-mono-nerd-font ")

linuxPkgs = (dev)
macPkgs = (cli + dev + keyring)
