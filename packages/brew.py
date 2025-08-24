installCmd = "brew install"

cli = ("git git-lfs tmux tree htop fastfetch neovim vim ripgrep fd fzf nanocom ")
coding = ("gcc llvm zig go lua python virtualenv pyenv pyenv-virtualenv node "
	"oven-sh/bun/bun basedpyright ")
keyring = ("gpg pinentry-mac ")
cask = ("wezterm dbeaver-community postman slack visual-studio-code zed zoom "
	"font-jetbrains-mono-nerd-font ")

linuxPkgs = (cli + coding)
macPkgs = (cli + coding + keyring)
