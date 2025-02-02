installCmd = "brew install"

basicPkgs = ("tmux git tree fastfetch neovim ripgrep fd fzf")
progammingPkgs = ("go python virtualenv pyenv pyenv-virtualenv basedpyright"
                  " node")
keyPkgs = ("gpg pinentry-mac")
caskPkgs = ("font-inconsolata-nerd-font ghostty dbeaver-community postman slack"
            " visual-studio-code zed webex zoom")

basePkgs = (basicPkgs + " " + progammingPkgs + " " + keyPkgs)
