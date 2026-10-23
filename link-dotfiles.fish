#!/usr/bin/env fish

# =========================
# Detect OS
# =========================
set OS (uname -s)

# =========================
# XDG config directory
# =========================
if set -q XDG_CONFIG_HOME
    set CONFIG_HOME $XDG_CONFIG_HOME
else
    set CONFIG_HOME $HOME/.config
end

# Resolve repo directory
set REPO_DIR (cd (dirname (status --current-filename)); and pwd)
set BACKUP_DIR "$HOME/.dotfiles_backup/"(date +%Y%m%d_%H%M%S)

echo "🔗 Dotfiles repo: $REPO_DIR"
echo "🖥 OS: $OS"
echo "📁 Config home: $CONFIG_HOME"
echo "📦 Backup dir: $BACKUP_DIR"

mkdir -p $BACKUP_DIR

function backup_and_link
    set src $argv[1]
    set dest $argv[2]

    # Validate source before touching destination
    if not test -e "$src"
        echo "❌ Source does not exist: $src"
        return 1
    end

    # Already correctly linked
    if test -L $dest
        if test (readlink $dest) = $src
            echo "✔ already linked: $dest"
            return
        end
    end

    # Backup existing file or directory
    if test -e $dest -o -L $dest
        set rel_dest (string replace -r "^$HOME/?" "" $dest)
        set backup_path "$BACKUP_DIR/$rel_dest"

        echo "📦 backing up $dest"
        mkdir -p (dirname $backup_path)
        mv $dest $backup_path
    end

    mkdir -p (dirname $dest)
    ln -s $src $dest
    echo "🔗 linked $dest → $src"
end

# =========================
# HOME-level dotfiles
# =========================
backup_and_link "$REPO_DIR/git-config/.gitconfig" "$HOME/.gitconfig"
#backup_and_link "$REPO_DIR/zsh/.zshrc"           "$HOME/.zshrc"

# =========================
# XDG config files
# =========================
#backup_and_link "$REPO_DIR/fish/config.fish"     "$CONFIG_HOME/fish/config.fish"
#backup_and_link "$REPO_DIR/fish/conf.d"          "$CONFIG_HOME/fish/conf.d"
backup_and_link "$REPO_DIR/fish/functions"       "$CONFIG_HOME/fish/functions"

# =========================
# Cross-platform XDG configs
# =========================
backup_and_link "$REPO_DIR/nvim"             "$CONFIG_HOME/nvim"
#backup_and_link "$REPO_DIR/tmux"            "$CONFIG_HOME/tmux"
#backup_and_link "$REPO_DIR/vscode"          "$CONFIG_HOME/vscode"
backup_and_link "$REPO_DIR/kitty"            "$CONFIG_HOME/kitty"
backup_and_link "$REPO_DIR/ghostty"          "$CONFIG_HOME/ghostty"

# =========================
# Linux-only configs
# =========================
if test "$OS" = "Linux"
    echo "🐧 Applying Linux-specific dotfiles"

    backup_and_link "$REPO_DIR/linux/hypr"       "$CONFIG_HOME/hypr"
    backup_and_link "$REPO_DIR/linux/noctalia"   "$CONFIG_HOME/noctalia"
end

echo "✅ All dotfiles linked successfully"

