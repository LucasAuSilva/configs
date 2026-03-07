set -Ux PATH $PATH $HOME/go/bin

set -x XDG_CURRENT_DESKTOP Hyprland
set -x GTK_THEME Adwaita:dark

if set -q WSL_DISTRO_NAME

    set -l win_user (cmd.exe /c "echo %USERNAME%" | tr -d '\r')

    set -gx WIN_HOME "/mnt/c/Users/$win_user"

    set -gx WIN_DESKTOP "$WIN_HOME/Desktop"
    set -gx WIN_DOWNLOADS "$WIN_HOME/Downloads"
    set -gx WIN_DOCUMENTS "$WIN_HOME/Documents"

end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
