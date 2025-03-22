installCmd = "brew install"

cliTui = ("git git-lfs tmux tree htop fastfetch neovim ripgrep fd fzf ")
coding = ("oven-sh/bun/bun zig go python virtualenv pyenv pyenv-virtualenv basedpyright node ")
keyring = ("gpg pinentry-mac ")
cask = ("ghostty dbeaver-community postman slack visual-studio-code zed zoom ")

linuxPkgs = (cliTui + coding)
macPkgs = (cliTui + coding + keyring)

