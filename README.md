# Dotfiles

Here I have most of my important configs and scripts and instructions to install another required stuff

## Omarchy runtime (NixOS)

The desktop is based on [Omarchy](https://github.com/basecamp/omarchy) v4 (quickshell shell,
Lua Hyprland config, theme system). A trimmed runtime copy lives in this repo:

- `config/hypr` - Hyprland config: omarchy defaults (flattened from upstream `default/hypr`)
  + personal `conf/*.lua` modules. Entry point: `hyprland.lua`; omarchy default
  keybinds are disabled (`_G.omarchy_default_bindings = false`) and `conf/keybinds.lua` is
  authoritative.
- `config/shell` - quickshell QML desktop (bar, menu launcher, lock, panels).
- `config/themes`, `config/themed` - theme collection + the shipped templates
  (kitty only is retinted; other app templates skipped).
- `config/omarchy` - user state dirs (shell.json, hooks, launcher.hides, menu def).
- `local/scripts/omarchy` - runtime `omarchy-*` scripts (via `~/.local/bin`-style PATH
  entries; scripts under `~/.local/scripts/omarchy`).

`OMARCHY_PATH=~/.config`; `PATH` additions go through `zsh/.zshrc` and
`config/uwsm/env.d/20-omarchy` (uwsm sessions). Packages live in `nixos/omarchy.nix`.

Theme: `omarchy theme set tokyo-night` (seeds `~/.local/state/omarchy/current`).
Switcher: `omarchy-theme-switcher`. Arch-specific bits (pacman, install/update/migrate
machinery) are intentionally not ported.

## Installing

To install this, simply run
```bash
./install.sh
```

## Requirements

Here are some programs you might need to install and the (current) way to install them:

- [Kitty](https://sw.kovidgoyal.net/kitty/binary/):
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

- [Solaar](https://pwr-solaar.github.io/Solaar/installation):
```bash
sudo dnf install solaar
```

## Some other useful links:

- [Configuring flashing/training for my moonlander](https://github.com/zsa/wally/wiki/Linux-install)
- [Download a nerd font (FiraCode Nerd Font, the best one)](https://www.nerdfonts.com/font-downloads)

