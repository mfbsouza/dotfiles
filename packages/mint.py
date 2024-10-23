installCmd = "sudo apt -y install"

pmPkgs = ("tlp tlp-rdw")
sysPkgs = ("stress vainfo")
vpnPkgs = ("wireguard wireguard-tools")
cppPkgs = ("g++ clang clang-format bear lcov")
utilPkgs = ("zsh vim git htop btop tmux fd-find ripgrep xclip")
i3wmPkgs = ("i3 dunst arandr lxappearance pavucontrol maim")
virtPkgs = ("virt-manager")
javaPkgs = ("default-jre")
nodePkgs = ("nodejs npm")
buildPkgs = ("build-essential autoconf automake libtool")
pythonPkgs = ("python3-pip python3-venv")
serversPkgs = ("openssh-server")

basePkgs = (sysPkgs + " " + vpnPkgs + " " + cppPkgs + " " +
            utilPkgs + " " + virtPkgs + " " + javaPkgs + " " +
            nodePkgs + " " + buildPkgs + " " + pythonPkgs + " " + serversPkgs)
