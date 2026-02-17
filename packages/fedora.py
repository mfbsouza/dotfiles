installCmd = "sudo dnf install"

base = ("@development-tools ")
sys = ("wl-clipboard tree htop btop fastfetch powertop ")
editor = ("neovim vim ripgrep fd fzf bat ")
programming = ("zig golang gopls node clang clang-format ")

pkgs = (sys + editor + programming)
