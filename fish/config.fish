if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_user_paths /opt/homebrew/bin $fish_user_paths
    fnm env --use-on-cd --shell fish | source
end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
