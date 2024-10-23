#!/usr/bin/env python3

import subprocess
import os
import logging

logging.basicConfig(
    level=logging.INFO,
    format='[%(asctime)s] %(levelname)s: %(message)s',
    datefmt="%Y-%m-%d %H:%M:%S %Z",
)

DRYRUN = True

def runCmd(cmd: str, piped: bool = False) -> None:
    if not DRYRUN:
        if not piped:
            status = subprocess.run(cmd.split()).returncode
        else:
            cmd = cmd.split('|')
            if len(cmd) == 2:
                ps = subprocess.Popen(cmd[0].split(), stdout=subprocess.PIPE)
                status = subprocess.run(cmd[1].split(), stdin=ps.stdout).returncode
                ps.wait()
            else:
                logging.warning(f"length of the piped command is not the expected: len is {len(cmd)}");
                return
        if status != 0:
            logging.warning(f"Failed while running: {cmd}")
    else:
        logging.info(cmd)

def createSymlink(
    basePath: str,
    filePath: str,
    filename: str,
    targetBasePath: str
) -> None:
    cmd = ("ln -s " + basePath + filePath + filename + " " +
           targetBasePath + "/" + filename)
    runCmd(cmd)

def createDirectory(path: str) -> None:
    cmd = "mkdir -p " + path
    runCmd(cmd)

def cloneGitRepo(reponame: str, repoUrl: str, targetPath: str) -> None:
    cmd = ("git clone --depth=1 " + repoUrl + " " +
           targetPath + "/" + reponame)
    runCmd(cmd)

def systemInstallPackage(installcmd: str, packages: str) -> None:
    cmd = installcmd + " " + packages
    runCmd(cmd)

def installFont(font: str, downUrl: str, targetPath: str) -> None:
    cmd = "curl -OL " + downUrl + font + ".tar.xz"
    runCmd(cmd)
    cmd = "tar -xf " + font + ".tar.xz " + "-C " + targetPath
    runCmd(cmd)
    cmd = "fc-cache -fv"
    runCmd(cmd)
    cmd = "rm " + font + ".tar.xz"
    runCmd(cmd)

if __name__ == "__main__":
    # paths
    rootDir = os.path.dirname(os.path.abspath(__file__))
    rootCfgDir = rootDir + "/.config"
    homeDir = os.path.expanduser("~")
    configDir = homeDir + "/.config"

    opt = input("Dryrun? [y/n]: ")
    if opt.lower() == "y":
        logging.info("Setting dryrun to True.")
        DRYRUN = True
    elif opt.lower() == "n":
        logging.info("Setting dryrun to False.")
        DRYRUN = False
    else:
        logging.info("Unknown option. Exiting.")
        exit(0)
    logging.info(f"Dryrun is set to {DRYRUN}")

    logging.info("Installing system packages...")

    opt = input("Select your OS? [mint]: ")
    if opt.lower() == "mint":
        from packages import mint
        systemInstallPackage(mint.installCmd, mint.basePkgs)
        opt = input("Install TLP packages? [y/n]: ")
        if opt.lower() == "y":
            systemInstallPackage(mint.installCmd, mint.pmPkgs)
        opt = input("Install I3wm packages? [y/n]: ")
        if opt.lower() == "y":
            systemInstallPackage(mint.installCmd, mint.i3wmPkgs)
    else:
        logging.info("Unknown option. Exiting.")
        exit(0)

    plugins = {
        "powerlevel10k": "https://github.com/romkatv/powerlevel10k.git",
        "zsh-autosuggestions": "https://github.com/zsh-users/zsh-autosuggestions",
        "zsh-syntax-highlighting": "https://github.com/zsh-users/zsh-syntax-highlighting"
    }

    logging.info("Downloading plugins...")
    pluginsPath = homeDir + "/plugins"
    createDirectory(pluginsPath)
    for plugin, repo in plugins.items():
        cloneGitRepo(plugin, repo, pluginsPath)

    softwares = {
        "fzf": "https://github.com/junegunn/fzf.git"
    }

    logging.info("Downloading softwares...")
    softwaresPath = homeDir + "/softwares"
    createDirectory(softwaresPath)
    for software, repo in softwares.items():
        cloneGitRepo(software, repo, softwaresPath)

    logging.info("Installing fzf...")
    runCmd(softwaresPath + "/fzf/install")

    logging.info("Installing pyenv...")
    runCmd("curl https://pyenv.run | bash", piped=True)

    # files and directories to install
    homeDirFiles = [".gitconfig", ".tmux.conf", ".zshrc", ".p10k.zsh"]
    configDirFiles = ["nvim", "alacritty"]

    logging.info("Setting up dotfiles in the home folder...")
    for file in homeDirFiles:
        createSymlink(rootDir, "/", file, homeDir)

    logging.info("Setting up dotfiles in the config folder...")
    createDirectory(configDir)
    for file in configDirFiles:
        createSymlink(rootCfgDir, "/", file, configDir)

    fonts = {
        "Inconsolata": "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"
    }

    logging.info("installing fonts...")
    fontsDir = homeDir + "/.fonts"
    createDirectory(fontsDir)
    for font, repo in fonts.items():
        installFont(font, repo, fontsDir)

    opt = input("Install TLP config file? [y/n]: ")
    if opt.lower() == "y":
        logging.info("Copying TLP configuration to /etc...")
        cmd = "sudo cp " + rootDir + "/etc/tlp.conf " + "/etc/tlp.conf"
        runCmd(cmd)

    opt = input("Install X11 config files? [y/n]: ")
    if opt.lower() == "y":
        logging.info("Copying X11 configuration to /etc/X11/xorg.conf.d...")
        cmd = "sudo cp -r " + rootDir + "/etc/X11/xorg.conf.d/* " + "/etc/X11/xorg.conf.d/"
        runCmd(cmd)

    opt = input("Install Rust Language Tools? [y,n]: ")
    if opt.lower() == "y":
        runCmd("curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh", piped=True)

    opt = input("Install Zed Text Editor? [y,n]: ")
    if opt.lower() == "y":
        runCmd("curl -f https://zed.dev/install.sh | sh", piped=True)

    opt = input("Install Flatseal Flatpak? [y/n]: ")
    if opt.lower() == "y":
        runCmd("flatpak install flathub com.github.tchx84.Flatseal")

    opt = input("Install Steam Flatpak and Gaming add-ons? [y,n]: ")
    if opt.lower() == "y":
        logging.info("ATENTION: install the 23.08 branch for the MangoHud and vkBasalt!")
        runCmd("flatpak install flathub com.valvesoftware.Steam")
        runCmd("flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud")
        runCmd("flatpak install org.freedesktop.Platform.VulkanLayer.vkBasalt")

    opt = input("Install Vesktop Flatpak? [y/n]: ")
    if opt.lower() == "y":
        runCmd("flatpak install flathub dev.vencord.Vesktop")

    opt = input("Install DBeaver Flatpak? [y/n]: ")
    if opt.lower() == "y":
        runCmd("flatpak install flathub io.dbeaver.DBeaverCommunity")

    opt = input("Install OBS Studio Flatpak? [y/n]: ")
    if opt.lower() == "y":
        runCmd("flatpak install flathub com.obsproject.Studio")

    opt = input("Install Heroic Games Flatpak? [y/n]: ")
    if opt.lower() == "y":
        runCmd("flatpak install flathub com.heroicgameslauncher.hgl")

    opt = input("Install Postman Flatpak? [y/n]: ")
    if opt.lower() == "y":
        runCmd("flatpak install flathub com.getpostman.Postman")

    opt = input("Install Telegram Desktop Flatpak? [y/n]: ")
    if opt.lower() == "y":
        runCmd("flatpak install flathub org.telegram.desktop")

    opt = input("Update the default shell to ZSH? [y/n]: ")
    if opt.lower() == "y":
        runCmd("chsh -s /usr/bin/zsh")
