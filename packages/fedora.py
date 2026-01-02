installCmd = "sudo dnf install"

base = ("@development-tools ")
sys = ("wl-clipboard tree htop btop fastfetch ")
editor = ("neovim vim ripgrep fd fzf bat ")
programming = ("zig golang gopls node ")

pkgs = (sys + editor + programming)
