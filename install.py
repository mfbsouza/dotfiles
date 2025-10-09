#!/usr/bin/env python3

import os
import logging

DRYRUN = True

logging.basicConfig(
	level=logging.INFO,
	format='[%(asctime)s] %(levelname)s: %(message)s',
	datefmt="%Y-%m-%d %H:%M:%S %Z",
)

SUPPORTED_OS = ["mint", "macos"]

def runCmd(cmd: str) -> None:
	global DRYRUN
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

def installSysPackages(operatingSystem: str) -> None:
	if operatingSystem.lower() == "mint":
		from packages import mint

		logging.info("installing system packages for Linux Mint")
		systemInstallPackage(mint.installCmd, mint.sys)
	elif operatingSystem.lower() == "macos":
		from packages import brew

		logging.info("installing system packages for MacOS")
		systemInstallPackage(brew.installCmd, brew.macPkgs)
		systemInstallPackage(brew.installCmd + " --cask", brew.cask)
	else:
		raise Exception(f"{operatingSystem} not supported for installing system packages")

def installZshPlugins(homeDir: str) -> None:
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

def installConfigFiles(rootDir: str, rootCfgDir: str, homeDir: str, configDir: str) -> None:
	homeDirFiles = [".gitconfig", ".tmux.conf", ".zshrc", ".p10k.zsh"]
	configDirFiles = ["zed", "wezterm", "vim", "nvim"]

	logging.info("Setting up dotfiles in the home folder...")
	for file in homeDirFiles:
		createSymlink(rootDir, "/", file, homeDir)

	logging.info("Setting up dotfiles in the config folder...")
	createDirectory(configDir)
	for file in configDirFiles:
		createSymlink(rootCfgDir, "/", file, configDir)

def installNerdFonts(homeDir: str) -> None:
	fonts = {
		"Inconsolata": "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/",
		"JetBrainsMono": "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"
	}
	logging.info("downloading fonts...")
	fontsDir = homeDir + "/.fonts"
	createDirectory(fontsDir)
	for font, repo in fonts.items():
		installFont(font, repo, fontsDir)

def flatpakPackagesSetup(homeDir: str, rootCfgDir: str) -> None:
	option = input("Install Flatseal Flatpak? [y/n]: ")
	if option.lower() == "y":
		runCmd("flatpak install flathub com.github.tchx84.Flatseal")

	option = input("Install Steam Flatpak and Gaming add-ons? [y,n]: ")
	if option.lower() == "y":
		runCmd("flatpak install flathub com.valvesoftware.Steam")
		runCmd("flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud")
		runCmd("flatpak install org.freedesktop.Platform.VulkanLayer.vkBasalt")
		vkBasaltPath = homeDir + "/.var/app/com.valvesoftware.Steam/config/vkBasalt"
		mangoHudPath = homeDir + "/.var/app/com.valvesoftware.Steam/config/MangoHud"
		createDirectory(vkBasaltPath)
		createDirectory(mangoHudPath)
		cmd = f"cp {rootCfgDir + '/vkBasalt/vkBasalt.conf'} {vkBasaltPath}/"
		runCmd(cmd)
		cmd = f"cp {rootCfgDir + '/MangoHud/MangoHud.conf'} {mangoHudPath}/"
		runCmd(cmd)

	option = input("Install Vesktop Flatpak? [y/n]: ")
	if option.lower() == "y":
		runCmd("flatpak install flathub dev.vencord.Vesktop")

	option = input("Install DBeaver Flatpak? [y/n]: ")
	if option.lower() == "y":
		runCmd("flatpak install flathub io.dbeaver.DBeaverCommunity")

	option = input("Install OBS Studio Flatpak? [y/n]: ")
	if option.lower() == "y":
		runCmd("flatpak install flathub com.obsproject.Studio")

	option = input("Install Heroic Games Flatpak? [y/n]: ")
	if option.lower() == "y":
		runCmd("flatpak install flathub com.heroicgameslauncher.hgl")

	option = input("Install Postman Flatpak? [y/n]: ")
	if option.lower() == "y":
		runCmd("flatpak install flathub com.getpostman.Postman")

	option = input("Install Telegram Desktop Flatpak? [y/n]: ")
	if option.lower() == "y":
		runCmd("flatpak install flathub org.telegram.desktop")

def main():
	global DRYRUN
	rootDir = os.path.dirname(os.path.abspath(__file__))
	rootCfgDir = rootDir + "/.config"
	homeDir = os.path.expanduser("~")
	configDir = homeDir + "/.config"

	option = input("Dryrun? [y/n]: ")
	if option.lower() == "y":
		DRYRUN = True
	elif option.lower() == "n":
		DRYRUN = False
	else:
		logging.info("Unknown option. Exiting.")
		exit(0)
	logging.info(f"Dryrun is set to {DRYRUN}")

	logging.info("Installing system packages...")
	operatingSystem = input(f"Select your OS? {SUPPORTED_OS}: ")
	installSysPackages(operatingSystem)

	logging.info("Installing zshell plugins...")
	installZshPlugins(homeDir)

	logging.info("Installing config files...")
	installConfigFiles(rootDir, rootCfgDir, homeDir, configDir)

	option = input("Install extra fonts? [y,n]: ")
	if option.lower() == "y":
		logging.info("Installing config files...")
		installNerdFonts(homeDir)

	if operatingSystem.lower() != "macos":
		logging.info("Installing nerd fonts...")
		flatpakPackagesSetup(homeDir, rootCfgDir)

		option = input("Update the default shell to ZSH? [y/n]: ")
		if option.lower() == "y":
			runCmd("chsh -s /usr/bin/zsh")

		option = input("Install NVIDIA VAAPI env variables? [y/n]: ")
		if option.lower() == "y":
			cmd = f'cat {rootDir + "/etc/env-nvidia-vaapi"} | sudo tee -a /etc/environment'
			runCmd(cmd)


if __name__ == "__main__":
	main()
