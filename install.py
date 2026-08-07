#!/usr/bin/env python3

import argparse
import logging
import os
import shutil
import subprocess
import sys
from dataclasses import dataclass

dry_run = True

logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s] %(levelname)s: %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S %Z",
)

logger = logging.getLogger(__name__)

SUPPORTED_OS = ["fedora", "mint", "debian", "macos"]

HOME_DIR_FILES = [".gitconfig", ".tmux.conf", ".zshrc", ".p10k.zsh"]
CONFIG_DIR_FILES = ["zed", "wezterm", "vim", "nvim", "ghostty", "alacritty"]

ZSH_PLUGINS = {
    "powerlevel10k": "https://github.com/romkatv/powerlevel10k.git",
    "zsh-autosuggestions": "https://github.com/zsh-users/zsh-autosuggestions",
    "zsh-syntax-highlighting": "https://github.com/zsh-users/zsh-syntax-highlighting",
}

NERD_FONTS = {
    "Inconsolata": "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/",
    "JetBrainsMono": "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/",
}


@dataclass
class Context:
    root_dir: str
    root_cfg_dir: str
    home_dir: str
    config_dir: str
    operating_system: str | None = None


class UnsupportedOSError(Exception):
    pass


def run_cmd(cmd: str) -> subprocess.CompletedProcess:
    if dry_run:
        logger.info(cmd)
        return subprocess.CompletedProcess(args=cmd, returncode=0)
    result = subprocess.run(cmd, shell=True, check=False)
    if result.returncode != 0:
        logger.error(f"Command failed (exit {result.returncode}): {cmd}")
        sys.exit(result.returncode)
    return result


def create_symlink(
    base_path: str, file_path: str, filename: str, target_base_path: str
) -> None:
    target = target_base_path + "/" + filename
    if os.path.islink(target):
        logger.info(f"Skipping {target}: symlink already exists.")
        return
    if os.path.exists(target):
        logger.warning(
            f"Skipping {target}: file or directory already exists (not a symlink)."
        )
        return
    cmd = "ln -s " + base_path + file_path + filename + " " + target
    run_cmd(cmd)


def create_directory(path: str) -> None:
    cmd = "mkdir -p " + path
    run_cmd(cmd)


def clone_git_repo(repo_name: str, repo_url: str, target_path: str) -> None:
    cmd = "git clone --depth=1 " + repo_url + " " + target_path + "/" + repo_name
    run_cmd(cmd)


def update_git_repo(repo_dir: str) -> None:
    cmd = "git -C " + repo_dir + " pull"
    run_cmd(cmd)


def system_install_package(install_cmd: str, packages: str) -> None:
    cmd = install_cmd + " " + packages
    run_cmd(cmd)


def install_font(font: str, download_url: str, target_path: str) -> None:
    cmd = "curl -OL " + download_url + font + ".tar.xz"
    run_cmd(cmd)
    cmd = "tar -xf " + font + ".tar.xz " + "-C " + target_path
    run_cmd(cmd)
    cmd = "fc-cache -fv"
    run_cmd(cmd)
    cmd = "rm " + font + ".tar.xz"
    run_cmd(cmd)


def install_sys_packages(ctx: Context, items=None) -> None:
    if ctx.operating_system is None or ctx.operating_system == "linux":
        choices = (
            [os for os in SUPPORTED_OS if os != "macos"]
            if ctx.operating_system == "linux"
            else None
        )
        ctx.operating_system = resolve_operating_system(choices)

    if ctx.operating_system.lower() == "fedora":
        from packages import fedora

        logger.info("installing system packages for Fedora Linux")
        system_install_package(fedora.install_cmd, fedora.base)
        system_install_package(fedora.install_cmd, fedora.pkgs)

    elif ctx.operating_system.lower() == "mint":
        from packages import mint

        logger.info("installing system packages for Linux Mint")
        system_install_package(mint.install_cmd, mint.sys)
    elif ctx.operating_system.lower() == "debian":
        from packages import debian

        logger.info("installing system packages for Debian Linux")
        system_install_package(debian.install_cmd, debian.sys)
    elif ctx.operating_system.lower() == "macos":
        from packages import brew

        logger.info("installing system packages for MacOS")
        system_install_package(brew.install_cmd, brew.mac_pkgs)
        system_install_package(brew.install_cmd + " --cask", brew.cask)
    else:
        raise UnsupportedOSError(
            f"{ctx.operating_system} not supported for installing system packages"
        )


def install_brew_packages(ctx: Context, items=None) -> None:
    from packages import brew

    if shutil.which("brew") is None:
        logger.warning(
            "Homebrew not found on PATH. Install it or add it to PATH, then retry."
        )
        return
    logger.info("Installing development packages via Homebrew...")
    system_install_package(brew.install_cmd, brew.dev)


def install_zsh_plugins(ctx: Context, items=None) -> None:
    plugins_path = ctx.home_dir + "/plugins"
    create_directory(plugins_path)
    for plugin, repo in ZSH_PLUGINS.items():
        plugin_dir = plugins_path + "/" + plugin
        if os.path.isdir(plugin_dir):
            logger.info(f"Updating plugin '{plugin}'...")
            update_git_repo(plugin_dir)
        else:
            logger.info(f"Downloading plugin '{plugin}'...")
            clone_git_repo(plugin, repo, plugins_path)


def install_config_files(ctx: Context, items=None) -> None:
    if items:
        install_specific_config_files(ctx, items)
        return

    logger.info("Setting up dotfiles in the home folder...")
    for file in HOME_DIR_FILES:
        create_symlink(ctx.root_dir, "/", file, ctx.home_dir)

    logger.info("Setting up dotfiles in the config folder...")
    create_directory(ctx.config_dir)
    for file in CONFIG_DIR_FILES:
        create_symlink(ctx.root_cfg_dir, "/", file, ctx.config_dir)


def install_specific_config_files(ctx: Context, items: list) -> None:
    available = HOME_DIR_FILES + CONFIG_DIR_FILES
    for item in items:
        if item in HOME_DIR_FILES:
            create_symlink(ctx.root_dir, "/", item, ctx.home_dir)
        elif item in CONFIG_DIR_FILES:
            create_directory(ctx.config_dir)
            create_symlink(ctx.root_cfg_dir, "/", item, ctx.config_dir)
        else:
            logger.warning(
                f"Unknown config '{item}'. Available: {', '.join(available)}"
            )


def install_nerd_fonts(ctx: Context, items=None) -> None:
    logger.info("downloading fonts...")
    fonts_dir = ctx.home_dir + "/.fonts"
    create_directory(fonts_dir)
    for font, repo in NERD_FONTS.items():
        install_font(font, repo, fonts_dir)


def flatpak_packages_setup(ctx: Context, items=None) -> None:
    option = input("Install Flatseal Flatpak? [y/n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub com.github.tchx84.Flatseal")

    option = input("Install Steam Flatpak and Gaming add-ons? [y,n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub com.valvesoftware.Steam")
        run_cmd("flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud")
        run_cmd("flatpak install org.freedesktop.Platform.VulkanLayer.vkBasalt")
        vk_basalt_path = (
            ctx.home_dir + "/.var/app/com.valvesoftware.Steam/config/vkBasalt"
        )
        mango_hud_path = (
            ctx.home_dir + "/.var/app/com.valvesoftware.Steam/config/MangoHud"
        )
        create_directory(vk_basalt_path)
        create_directory(mango_hud_path)
        cmd = f"cp {ctx.root_cfg_dir + '/vkBasalt/vkBasalt.conf'} {vk_basalt_path}/"
        run_cmd(cmd)
        cmd = f"cp {ctx.root_cfg_dir + '/MangoHud/MangoHud.conf'} {mango_hud_path}/"
        run_cmd(cmd)

    option = input("Install Vesktop Flatpak? [y/n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub dev.vencord.Vesktop")

    option = input("Install DBeaver Flatpak? [y/n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub io.dbeaver.DBeaverCommunity")

    option = input("Install OBS Studio Flatpak? [y/n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub com.obsproject.Studio")

    option = input("Install Bottles Flatpak? [y/n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub com.usebottles.bottles")

    option = input("Install Heroic Games Flatpak? [y/n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub com.heroicgameslauncher.hgl")

    option = input("Install Postman Flatpak? [y/n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub com.getpostman.Postman")

    option = input("Install Telegram Desktop Flatpak? [y/n]: ")
    if option.lower() == "y":
        run_cmd("flatpak install flathub org.telegram.desktop")


LINUX_ONLY_TASKS = ["flatpak", "fonts"]


def install_all(ctx: Context, items=None) -> None:
    install_sys_packages(ctx)
    install_zsh_plugins(ctx)
    install_config_files(ctx)
    if ctx.operating_system is None:
        ctx.operating_system = resolve_operating_system()
    if ctx.operating_system.lower() != "macos":
        install_nerd_fonts(ctx)
        flatpak_packages_setup(ctx)


TASKS = {
    "all": install_all,
    "system-packages": install_sys_packages,
    "brew-packages": install_brew_packages,
    "zsh-plugins": install_zsh_plugins,
    "config": install_config_files,
    "fonts": install_nerd_fonts,
    "flatpak": flatpak_packages_setup,
}


def detect_platform() -> str | None:
    if sys.platform == "darwin":
        return "macos"
    if sys.platform.startswith("linux"):
        return "linux"
    return None


def resolve_operating_system(choices=None) -> str:
    choices = choices or SUPPORTED_OS
    while True:
        operating_system = input(f"Select your OS? {choices}: ").lower()
        if operating_system in choices:
            return operating_system
        logger.info(f"Unknown OS {operating_system}. Please pick one of {choices}.")


def build_context(args) -> Context:
    root_dir = os.path.dirname(os.path.abspath(__file__))
    home_dir = os.path.expanduser("~")
    return Context(
        root_dir=root_dir,
        root_cfg_dir=root_dir + "/.config",
        home_dir=home_dir,
        config_dir=home_dir + "/.config",
        operating_system=getattr(args, "os", None) or detect_platform(),
    )


def run_tasks(names, ctx, items=None) -> None:
    for name in names:
        if ctx.operating_system == "macos" and name in LINUX_ONLY_TASKS:
            logger.warning(f"Skipping '{name}': not supported on macOS.")
            continue
        logger.info(f"Running task '{name}'...")
        TASKS[name](ctx, items)


def interactive_menu(ctx) -> None:
    names = list(TASKS.keys())
    print("\nSelect which tasks to run (comma or space separated numbers):")
    for i, name in enumerate(names, 1):
        print(f"  {i}. {name}")
    while True:
        selection = input("\nYour selection: ").replace(",", " ").split()
        invalid = [
            s for s in selection if not s.isdigit() or not (1 <= int(s) <= len(names))
        ]
        if invalid:
            logger.info(f"Invalid selection: {', '.join(invalid)}. Try again.")
            continue
        selected = [names[int(s) - 1] for s in selection]
        break

    os_dependent = {
        name
        for name in selected
        if name == "all" or name in LINUX_ONLY_TASKS or name == "system-packages"
    }
    if os_dependent and ctx.operating_system is None:
        ctx.operating_system = resolve_operating_system()

    run_tasks(selected, ctx)


def create_parser() -> argparse.ArgumentParser:
    parent = argparse.ArgumentParser(add_help=False)
    parent.add_argument(
        "--dry-run",
        action="store_true",
        default=argparse.SUPPRESS,
        help="print commands without executing them",
    )
    parent.add_argument(
        "--os",
        choices=SUPPORTED_OS,
        default=argparse.SUPPRESS,
        help="operating system to target",
    )

    parser = argparse.ArgumentParser(
        prog="install.py",
        description="Set up dotfiles and system tools.",
        parents=[parent],
    )
    subparsers = parser.add_subparsers(dest="task", metavar="task")

    for name in TASKS:
        sub = subparsers.add_parser(name, parents=[parent], help=f"run '{name}' task")
        if name == "config":
            sub.add_argument(
                "items",
                nargs="*",
                help=(
                    "specific config files/dirs to install (default: all). "
                    f"Choices: {', '.join(HOME_DIR_FILES + CONFIG_DIR_FILES)}"
                ),
            )

    return parser


def main():
    global dry_run
    parser = create_parser()
    args = parser.parse_args()
    dry_run = getattr(args, "dry_run", False)
    logger.info(f"Dryrun is set to {dry_run}")

    ctx = build_context(args)

    if args.task is None:
        interactive_menu(ctx)
    elif args.task == "all":
        if ctx.operating_system is None:
            ctx.operating_system = resolve_operating_system()
        run_tasks(["all"], ctx)
    else:
        if ctx.operating_system is None and (
            args.task in LINUX_ONLY_TASKS or args.task == "system-packages"
        ):
            ctx.operating_system = resolve_operating_system()
        run_tasks([args.task], ctx, getattr(args, "items", None))


if __name__ == "__main__":
    main()
