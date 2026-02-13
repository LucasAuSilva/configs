# My Configs (Dotfiles)

This repository contains my personal configuration files (dotfiles), used for both work and study.
Its purpose is to provide a centralized, version-controlled backup of my development environment and
to allow quick and consistent setup on new machines.


## Repository Structure

The repository is organized into multiple folders, each corresponding to a specific tool or application.

- Some folders contain a single configuration file (as expected for tools with a single entry point).
- Others contain multiple files or subdirectories, depending on the tool’s configuration layout.

Each folder mirrors the structure expected in the target system, making the setup predictable and easy to maintain.


## Symlink Setup

The repository includes the `link-dotfiles` scripts (Bash and Fish), responsible for creating
[symbolic links](https://wiki.debian.org/SymLink) from this repository to the appropriate locations in the home directory.

These scripts are designed to:
- Work on **macOS and Linux**
- Support both **file-level** and **directory-level** configurations
- Safely **backup existing files** before creating symlinks
    - Backups that will be stored in `$HOME/.dotfiles_backup/(date +%Y%m%d_%H%M%S)`

This approach allows the repository to act as the single source of truth for all configurations,
making new system setups fast, reliable, and reproducible.

## Pre setup

Before running the symlink script, make sure the following tools are installed.

These packages are required for the shell environment, Neovim setup, Treesitter compilation, and plugin dependencies.

### Ubuntu/Debian
Install base development tools and common dependencies:

```bash
sudo apt update
sudo apt install -y \
  build-essential \
  curl \
  git \
  unzip \
  ripgrep \
  pkg-config \
  libtool
```

Fish shell:
```bash
sudo apt install fish
```

Neovim is from [package manager](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)

### Arch Linux

```bash
sudo pacman -Syu \
  base-devel \
  curl \
  git \
  unzip \
  ripgrep \
  neovim \
  fish \
  pkgconf \
  libtool
```

### Other tools that have their own installers

 - **Oh My Fish (OMF)** [own installer](https://github.com/oh-my-fish/oh-my-fish)
 - **fnm (Fast Node Manager)** [own install](https://github.com/Schniz/fnm)
 - **tree-sitter CLI** [via cargo or npm](https://github.com/Schniz/fnm)


## Usage

Run the appropriate script from the repository root:

```bash
./link-dotfiles.sh
```
or (Fish shell)
```
./link-dotfiles.fish
```

