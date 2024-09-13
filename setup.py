#!/usr/bin/env python3

import subprocess
import platform
import os
import logging

logging.basicConfig(
    level=logging.INFO,
    format='[%(asctime)s] %(levelname)s: %(message)s',
    datefmt="%Y-%m-%d %H:%M:%S %Z",
)

DRYRUN = True

def runCmd(cmd: str) -> None:
    if not DRYRUN:
        status = subprocess.run(cmd.split()).returncode
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

    logging.info(f"Dryrun is set to {DRYRUN}")

    logging.info("Installing system packages...")
    OStype = platform.system()
    if OStype == "Linux":
        # TODO: actually check the distro in use
        from packages import mint
        systemInstallPackage(mint.installCmd, mint.packages)

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
    runCmd("curl https://pyenv.run | bash")

    # files and directories to install
    homeDirFiles = [".gitconfig", ".tmux.conf", ".zshrc", ".p10k.zsh"]
    configDirFiles = ["nvim", "alacritty", "i3", "i3status", "dunst"]

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
    
    logging.info("Copying TLP configuration to /etc...")
    cmd = "sudo cp " + rootDir + "/etc/tlp.conf " + "/etc/tlp.conf"
    runCmd(cmd)
        
    logging.info("Copying X11 configuration to /etc/X11/xorg.conf.d...")
    cmd = "sudo cp -r " + rootDir + "/etc/X11/xorg.conf.d/* " + "/etc/X11/xorg.conf.d/"
    runCmd(cmd)