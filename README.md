# My Configs (Dotfiles)

My personal development environment for work and study, with configurations for macOS and Linux. This repository keeps shell, editor, terminal, and Linux desktop settings together so they can be versioned and reused across machines.

## Repository structure

| Path | Contents |
| --- | --- |
| `fish/` | Shell configuration, environment initialization for OMF, fnm, Rust, Go, and uv, theme settings, and a `try` function |
| `zsh/` | Zsh configuration |
| `git-config/` | Git identity, aliases, and GitHub CLI credential helpers |
| `nvim/` | Lua configuration with lazy.nvim, LSP, completion, Treesitter, Telescope, Fugitive, themes, and CodeCompanion |
| `tmux/` | Vi copy mode, mouse support, Catppuccin, and TPM plugins |
| `ghostty/` | Terminal settings, split keybindings, themes, shaders, and a separate macOS shell setting |
| `kitty/` | Terminal settings with transparency, cursor trails, and theme files |
| `linux/hypr/` | Modular Lua Hyprland configuration for monitors, workspaces, keybindings, autostart, appearance, and window rules |
| `linux/noctalia/` | Desktop bar, launcher, notifications, session actions, screenshots, and wallpaper-based theming |
| `vscode/` | Settings, keybindings, and an exported macOS profile |
| `link-dotfiles.fish`, `link-dotfiles.sh` | Symlink setup scripts with different sets of enabled configurations |

## Before setup

Install the applications you intend to use separately; the symlink scripts do not install packages.

For the development setup, have Git, curl, unzip, ripgrep, a C/C++ build toolchain, pkg-config, and libtool available. Neovim also needs the runtimes and tools required by the language servers and Treesitter parsers you use.

Optional components used by these configurations include:

- [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish), [fnm](https://github.com/Schniz/fnm), Rust, Go, and uv for the Fish environment.
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) for parser tooling.
- GitHub CLI (`gh`) for the Git credential helpers. Run `gh auth login` on each machine.
- JetBrains Mono for Ghostty, and a font with icon glyphs for editor and tmux symbols.
- [TPM](https://github.com/tmux-plugins/tpm) for tmux plugins, installed at `~/.config/tmux/plugins/tpm`.
- Hyprland with support for the Lua configuration API used here, plus Noctalia, for the Linux desktop setup. Configured applications include Kitty, Dolphin, Firefox, GNOME Text Editor, GNOME Calculator, and Satty.

Review the personal settings before linking:

- `git-config/.gitconfig` contains my name and email.
- `fish/config.fish` and `fish/conf.d/` include local paths and desktop environment settings. The uv snippet sources `$HOME/.local/bin/env.fish`; the WSL paths assume the Windows username matches `$USER`.
- `linux/hypr/config/variables.lua` selects applications and monitor names. `monitors.lua` specifies two 1080p/144 Hz displays and a `STREAM` output at 1440p/60 Hz for game streaming.
- `ghostty/config` references `shaders/cursor_smear.glsl`, which is not included in this repository. Choose an included shader or remove that setting.
- `ghostty/macos.config` points to `/opt/homebrew/bin/fish`. It is a separate file; the main configuration does not include it automatically.

## Symlink setup

Choose a script based on the configurations you want to link. **The Bash and Fish scripts are not equivalent.** Run one from the repository root using its interpreter:

```bash
fish link-dotfiles.fish
```

or:

```bash
bash link-dotfiles.sh
```

The scripts resolve the repository location themselves. Keep the repository in place afterward, since the links point directly into it.

### What each script links

For Fish, `<config>` is `$XDG_CONFIG_HOME` when set, otherwise `~/.config`. Bash always uses `~/.config`.

| Source | Fish destination | Bash destination |
| --- | --- | --- |
| `git-config/.gitconfig` | `~/.gitconfig` | `~/.gitconfig` |
| `zsh/.zshrc` | Disabled | `~/.zshrc` |
| `fish/config.fish` | Disabled | `~/.config/fish/config.fish` |
| `fish/conf.d/` | Disabled | Not linked |
| `fish/functions/` | `<config>/fish/functions` | Not linked |
| `nvim/` | `<config>/nvim` | `~/.config/nvim` |
| `tmux/` | Disabled | `~/.config/tmux` |
| `vscode/` | Disabled | `~/.config/vscode` |
| `kitty/` | `<config>/kitty` | Not linked |
| `ghostty/` | `<config>/ghostty` | Not linked |
| `linux/hypr/` | `<config>/hypr` (Linux only) | Not linked |
| `linux/noctalia/` | `<config>/noctalia` (Linux only) | Not linked |

“Disabled” entries are commented out in the Fish script. Edit the script to enable them if needed. VS Code settings and profiles can also be imported or copied into the location used by your installation.

Both scripts skip links that already point to the expected source and move existing destinations into `~/.dotfiles_backup/YYYYMMDD_HHMMSS/` before replacing them. The Fish script preserves paths relative to the home directory; Bash nests the full destination path inside the backup directory. To restore a previous configuration, remove its symlink and move the corresponding backup into its original location.

## Neovim

On first launch, the configuration bootstraps lazy.nvim and loads plugins from `nvim/lua/plugins/`. Internet access is needed for the initial plugin download. LSP support uses lsp-zero, Mason, nvim-lspconfig, and nvim-cmp, with Lua and C# servers explicitly enabled. Install the language servers and runtimes you need.

The leader key is **Space**. Some useful bindings:

| Binding | Action |
| --- | --- |
| `<leader>op` | Open the built-in file explorer |
| `<leader>ff` | Find files with Telescope |
| `Ctrl+p` | Find Git files |
| `<leader>fs` | Search for a string |
| `Ctrl+h/j/k/l` | Move between editor windows |
| `<leader>cc` | Toggle CodeCompanion chat |
| `<leader>ca` | Open CodeCompanion actions (normal or visual mode) |
| `<leader>as` | Add the visual selection to chat |

CodeCompanion is configured to use the Codex ACP adapter with ChatGPT authentication. Its adapter runtime and authentication must be set up separately to use chat.

## Terminals and tmux

Ghostty uses Catppuccin Macchiato, transparency.
Additional shader files and previews are in [`ghostty/shaders/`](ghostty/shaders/Readme.md). Kitty includes a theme file and a Noctalia theme; Noctalia also has terminal and desktop theme templates configured.

Tmux uses **Ctrl+Space** as its prefix, starts window and pane numbering at 1, and opens new panes in the current directory. After installing TPM, use the prefix followed by `I` to install the configured plugins. Prefix + `R` reloads the configuration.

## Scratch projects with try

The Fish function in `fish/functions/try.fish` wraps [try](https://github.com/tobi/try) for creating and navigating scratch projects. It expects Ruby and the external script at `~/.local/try.rb`, and stores projects in `~/src/tries`. Linking the function does not install the Ruby script.
