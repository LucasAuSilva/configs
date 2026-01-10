if set -q XDG_DATA_HOME
    set -gx OMF_PATH "$XDG_DATA_HOME/omf"
else
    set -gx OMF_PATH "$HOME/.local/share/omf"
end

# Load Oh My Fish only if installed
if test -f "$OMF_PATH/init.fish"
    source "$OMF_PATH/init.fish"
end

