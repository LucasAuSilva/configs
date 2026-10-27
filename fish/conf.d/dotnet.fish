# .NET SDK — only configure if an installation exists
if test -d "$HOME/.dotnet"
    set -gx DOTNET_ROOT "$HOME/.dotnet"
    fish_add_path "$HOME/.dotnet"
    fish_add_path "$HOME/.dotnet/tools"
else if type -q dotnet
    # Installed system-wide (package manager, Homebrew, etc.)
    fish_add_path "$HOME/.dotnet/tools"
end
