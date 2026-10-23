#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
if [[ "$CONFIG_HOME" != /* ]]; then
  printf 'XDG_CONFIG_HOME must be an absolute path: %s\n' "$CONFIG_HOME" >&2
  exit 1
fi

OS="$(uname -s)"
SOURCES=(
  "$REPO_DIR/fish/config.fish"
  "$REPO_DIR/fish/conf.d"
  "$REPO_DIR/fish/functions"
  "$REPO_DIR/nvim"
  "$REPO_DIR/kitty"
  "$REPO_DIR/opencode/cli.json"
)
DESTINATIONS=(
  "$CONFIG_HOME/fish/config.fish"
  "$CONFIG_HOME/fish/conf.d"
  "$CONFIG_HOME/fish/functions"
  "$CONFIG_HOME/nvim"
  "$CONFIG_HOME/kitty"
  "$CONFIG_HOME/opencode/cli.json"
)

IS_WSL=0
if [[ "$OS" == Linux && -r /proc/sys/kernel/osrelease ]] &&
   grep -qi microsoft /proc/sys/kernel/osrelease; then
  IS_WSL=1
fi
if [[ "$OS" == Linux && "$IS_WSL" == 0 ]]; then
  SOURCES+=("$REPO_DIR/linux/hypr" "$REPO_DIR/linux/noctalia")
  DESTINATIONS+=("$CONFIG_HOME/hypr" "$CONFIG_HOME/noctalia")
fi

# Validate every source before moving or linking any destination.
for src in "${SOURCES[@]}"; do
  if [[ ! -e "$src" && ! -L "$src" ]]; then
    printf 'Source does not exist: %s\n' "$src" >&2
    exit 1
  fi
done

BACKUP_ROOT="$HOME/.dotfiles_backup"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d_%H%M%S)"
suffix=1
while [[ -e "$BACKUP_DIR" ]]; do
  BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d_%H%M%S)_$suffix"
  ((suffix += 1))
done

echo "🔗 Dotfiles repo: $REPO_DIR"
echo "📁 Config home: $CONFIG_HOME"
echo "📦 Backup dir (if needed): $BACKUP_DIR"

for i in "${!SOURCES[@]}"; do
  src="${SOURCES[$i]}"
  dest="${DESTINATIONS[$i]}"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "✔ already linked: $dest"
    continue
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    rel_dest="${dest#"$HOME"/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel_dest")"
    echo "📦 backing up $dest"
    mv -- "$dest" "$BACKUP_DIR/$rel_dest"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "🔗 linked $dest → $src"
done

echo "✅ All dotfiles linked successfully"
