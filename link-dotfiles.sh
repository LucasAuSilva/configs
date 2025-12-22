#!/usr/bin/env bash
set -euo pipefail

# Resolve repo directory (where this script lives)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "🔗 Dotfiles repo: $REPO_DIR"
echo "📦 Backup dir: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

backup_and_link() {
  local src="$1"
  local dest="$2"

  # Already linked correctly
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "✔ already linked: $dest"
    return
  fi

  # Backup existing file or symlink
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "📦 backing up $dest"
    mkdir -p "$(dirname "$BACKUP_DIR/$dest")"
    mv "$dest" "$BACKUP_DIR/$dest"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "🔗 linked $dest → $src"
}

# =========================
# File-level dotfiles
# =========================
backup_and_link "$REPO_DIR/git-config/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$REPO_DIR/zsh/.zshrc"           "$HOME/.zshrc"

# Fish: link ONLY config.fish
backup_and_link "$REPO_DIR/fish/config.fish"     "$HOME/.config/fish/config.fish"

# =========================
# Folder-level dotfiles
# =========================
backup_and_link "$REPO_DIR/nvim"   "$HOME/.config/nvim"
backup_and_link "$REPO_DIR/tmux"   "$HOME/.config/tmux"
backup_and_link "$REPO_DIR/vscode" "$HOME/.config/vscode"

echo "✅ All dotfiles linked successfully"

