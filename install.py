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

def runCmd(cmd: str) -> None:
	if not DRYRUN:
		status = os.system(cmd)
		if not status or status != 0:
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

	os = input("Select your OS? [mint, macos]: ")
	if os.lower() == "mint":
		from packages import mint
		systemInstallPackage(mint.installCmd, mint.sys)
		print("installing for mint")
	elif os.lower() == "macos":
		from packages import brew
		systemInstallPackage(brew.installCmd, brew.macPkgs)
		systemInstallPackage(brew.installCmd + " --cask", brew.cask)
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

	# files and directories to install
	homeDirFiles = [".gitconfig", ".tmux.conf", ".zshrc", ".p10k.zsh"]
	configDirFiles = ["zed", "wezterm"]

	logging.info("Setting up dotfiles in the home folder...")
	for file in homeDirFiles:
		createSymlink(rootDir, "/", file, homeDir)

	logging.info("Setting up dotfiles in the config folder...")
	createDirectory(configDir)
	for file in configDirFiles:
		createSymlink(rootCfgDir, "/", file, configDir)

	opt = input("Install extra fonts? [y,n]: ")
	if opt.lower() == "y":
		fonts = {
			"Inconsolata": "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/",
			"JetBrainsMono": "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"
		}
		logging.info("installing fonts...")
		fontsDir = homeDir + "/.fonts"
		createDirectory(fontsDir)
		for font, repo in fonts.items():
			installFont(font, repo, fontsDir)

	if os.lower() != "macos":
		opt = input("Install Zed Text Editor? [y,n]: ")
		if opt.lower() == "y":
			runCmd("curl -f https://zed.dev/install.sh | sh")

		opt = input("Install Flatseal Flatpak? [y/n]: ")
		if opt.lower() == "y":
			runCmd("flatpak install flathub com.github.tchx84.Flatseal")

		opt = input("Install Steam Flatpak and Gaming add-ons? [y,n]: ")
		if opt.lower() == "y":
			runCmd("flatpak install flathub com.valvesoftware.Steam")
			runCmd("flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud")
			runCmd("flatpak install org.freedesktop.Platform.VulkanLayer.vkBasalt")
			vkBasaltPath = homeDir + "/.var/app/com.valvesoftware.Steam/config/vkBasalt"
			MangoHudPath = homeDir + "/.var/app/com.valvesoftware.Steam/config/MangoHud"
			createDirectory(vkBasaltPath)
			createDirectory(MangoHudPath)
			cmd = f"cp {rootCfgDir + '/vkBasalt/vkBasalt.conf'} {vkBasaltPath}/"
			runCmd(cmd)
			cmd = f"cp {rootCfgDir + '/MangoHud/MangoHud.conf'} {MangoHudPath}/"
			runCmd(cmd)

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

		opt = input("Install NVIDIA VAAPI env variables? [y/n]: ")
		if opt.lower() == "y":
			cmd = f'cat {rootDir + "/etc/env-nvidia-vaapi"} | sudo tee -a /etc/environment'
			runCmd(cmd)
