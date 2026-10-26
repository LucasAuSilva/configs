#!/usr/bin/env fish

set OS (uname -s)
if set -q XDG_CONFIG_HOME; and test -n "$XDG_CONFIG_HOME"
    set CONFIG_HOME $XDG_CONFIG_HOME
else
    set CONFIG_HOME $HOME/.config
end
if not string match -q '/*' -- "$CONFIG_HOME"
    echo "❌ XDG_CONFIG_HOME must be an absolute path: $CONFIG_HOME" >&2
    exit 1
end

set REPO_DIR (cd (dirname (status --current-filename)); and pwd)
if test -z "$REPO_DIR"
    echo "❌ Could not resolve repository directory" >&2
    exit 1
end

set SOURCES \
    "$REPO_DIR/fish/config.fish" \
    "$REPO_DIR/fish/conf.d" \
    "$REPO_DIR/fish/functions" \
    "$REPO_DIR/nvim" \
    "$REPO_DIR/kitty" \
    "$REPO_DIR/opencode/cli.json" \
    "$REPO_DIR/opencode/commands"
set DESTINATIONS \
    "$CONFIG_HOME/fish/config.fish" \
    "$CONFIG_HOME/fish/conf.d" \
    "$CONFIG_HOME/fish/functions" \
    "$CONFIG_HOME/nvim" \
    "$CONFIG_HOME/kitty" \
    "$CONFIG_HOME/opencode/cli.json" \
    "$CONFIG_HOME/opencode/commands"

set IS_WSL 0
if test "$OS" = Linux; and test -r /proc/sys/kernel/osrelease
    if string match -qi '*microsoft*' (cat /proc/sys/kernel/osrelease)
        set IS_WSL 1
    end
end

if test "$OS" = Linux; and test $IS_WSL -eq 0
    set SOURCES $SOURCES "$REPO_DIR/linux/hypr" "$REPO_DIR/linux/noctalia"
    set DESTINATIONS $DESTINATIONS "$CONFIG_HOME/hypr" "$CONFIG_HOME/noctalia"
end

# Validate all sources before moving or linking any destination.
for src in $SOURCES
    if not test -e "$src"; and not test -L "$src"
        echo "❌ Source does not exist: $src" >&2
        exit 1
    end
end

set BACKUP_ROOT "$HOME/.dotfiles_backup"
set timestamp (date +%Y%m%d_%H%M%S)
set BACKUP_DIR "$BACKUP_ROOT/$timestamp"
set suffix 1
while test -e "$BACKUP_DIR"
    set BACKUP_DIR "$BACKUP_ROOT/"$timestamp"_"$suffix
    set suffix (math $suffix + 1)
end

echo "🔗 Dotfiles repo: $REPO_DIR"
echo "🖥 OS: $OS"
echo "📁 Config home: $CONFIG_HOME"
echo "📦 Backup dir (if needed): $BACKUP_DIR"

for i in (seq (count $SOURCES))
    set src $SOURCES[$i]
    set dest $DESTINATIONS[$i]

    if test -L "$dest"; and test (readlink "$dest") = "$src"
        echo "✔ already linked: $dest"
        continue
    end

    if test -e "$dest"; or test -L "$dest"
        set rel_dest (string replace -- "$HOME/" "" "$dest")
        set backup_path "$BACKUP_DIR/$rel_dest"
        mkdir -p (dirname "$backup_path")
        echo "📦 backing up $dest"
        mv "$dest" "$backup_path"
    end

    mkdir -p (dirname "$dest")
    ln -s "$src" "$dest"
    echo "🔗 linked $dest → $src"
end

echo "✅ All dotfiles linked successfully"
