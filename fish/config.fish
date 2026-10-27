# --- OS detection ---
set -l os (uname -s)
set -l is_wsl 0
if set -q WSL_DISTRO_NAME; or string match -qi '*microsoft*' (uname -r)
    set is_wsl 1
end

# --- Linux desktop (Hyprland) ---
# Only set these on a real Linux desktop session, not on WSL/macOS/Windows.
if test "$os" = Linux; and test "$is_wsl" = 0; and set -q DISPLAY; or set -q WAYLAND_DISPLAY
    set -gx XDG_CURRENT_DESKTOP Hyprland
    set -gx GTK_THEME Adwaita:dark
end

# --- WSL: resolve the real Windows user profile ---
if test "$is_wsl" = 1
    # Ask Windows for its own user profile instead of assuming it matches the WSL username.
    set -l win_profile (cmd.exe /c "echo %USERPROFILE%" 2>/dev/null | string trim | tr -d '\r')

    if test -n "$win_profile"
        # Convert a Windows path (C:\Users\name) to a WSL path (/mnt/c/Users/name).
        if type -q wslpath
            set -gx WIN_HOME (wslpath -u "$win_profile" 2>/dev/null)
        else
            set -gx WIN_HOME (string replace -r '^([A-Za-z]):' '/mnt/$1' "$win_profile" | string replace -a '\\' '/')
        end
    end

    # Fallback: derive from the Windows username if the above failed.
    if not set -q WIN_HOME; or not test -d "$WIN_HOME"
        set -l win_user (cmd.exe /c "echo %USERNAME%" 2>/dev/null | string trim | tr -d '\r')
        if test -n "$win_user"; and test -d "/mnt/c/Users/$win_user"
            set -gx WIN_HOME "/mnt/c/Users/$win_user"
        end
    end

    if set -q WIN_HOME; and test -d "$WIN_HOME"
        set -gx WIN_DESKTOP "$WIN_HOME/Desktop"
        set -gx WIN_DOWNLOADS "$WIN_HOME/Downloads"
        set -gx WIN_DOCUMENTS "$WIN_HOME/Documents"
    end
end

# --- Ruby user gems (any Linux/WSL user) ---
for gem_bin in $HOME/.local/share/gem/ruby/*/bin
    if test -d $gem_bin
        fish_add_path $gem_bin
    end
end

# --- Homebrew (macOS or Linuxbrew) ---
if test "$os" = Darwin
    if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv fish)
    else if test -x /usr/local/bin/brew
        eval (/usr/local/bin/brew shellenv fish)
    end
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)
end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
