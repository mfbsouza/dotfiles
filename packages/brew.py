installCmd = "brew install"

shell = "zsh "

dev = ("gcc zig zls go gopls lua python node oven-sh/bun/bun "
    "fastfetch neovim vim ripgrep fd fzf btop bat ")

cli = ("git git-lfs tmux tree nanocom pyenv pyenv-virtualenv ")

keyring = ("gpg pinentry-mac ")

cask = ("wezterm dbeaver-community postman slack visual-studio-code zed zoom "
	"font-jetbrains-mono-nerd-font ")

linuxPkgs = (shell + dev)
macPkgs = (cli + dev + keyring)
