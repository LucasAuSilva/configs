#!/usr/bin/env fish

# Resolve repo directory (portable)
set REPO_DIR (cd (dirname (status --current-filename)); and pwd)
set BACKUP_DIR "$HOME/.dotfiles_backup/(date +%Y%m%d_%H%M%S)"

echo "🔗 Dotfiles repo: $REPO_DIR"
echo "📦 Backup dir: $BACKUP_DIR"
mkdir -p $BACKUP_DIR

function backup_and_link
    set src $argv[1]
    set dest $argv[2]

    # Already correctly linked
    if test -L $dest
        if test (readlink $dest) = $src
            echo "✔ already linked: $dest"
            return
        end
    end

    # Backup existing file or link
    if test -e $dest -o -L $dest
        echo "📦 backing up $dest"
        mkdir -p (dirname $BACKUP_DIR/$dest)
        mv $dest $BACKUP_DIR/$dest
    end

    mkdir -p (dirname $dest)
    ln -s $src $dest
    echo "🔗 linked $dest → $src"
end

# =========================
# File-level dotfiles
# =========================
backup_and_link "$REPO_DIR/git-config/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$REPO_DIR/zsh/.zshrc"           "$HOME/.zshrc"
backup_and_link "$REPO_DIR/fish/config.fish"     "$HOME/.config/fish/config.fish"

# =========================
# Folder-level dotfiles
# =========================
backup_and_link "$REPO_DIR/nvim"   "$HOME/.config/nvim"
backup_and_link "$REPO_DIR/tmux"   "$HOME/.config/tmux"
backup_and_link "$REPO_DIR/vscode" "$HOME/.config/vscode"

echo "✅ All dotfiles linked successfully"

