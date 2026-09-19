# Omarchy runtime on NixOS.
#
# Omarchy's tree lives in this repo: config/ (shipped as ~/.config), with the
# runtime pieces at:
#   ~/.config/hypr    - Hyprland Lua config (omarchy defaults, flattened, + user modules)
#   ~/.config/shell   - Quickshell QML desktop (bar, launcher, lock, panels)
#   ~/.config/themes  - theme collection
#   ~/.config/themed  - the few theme templates we ship (kitty, shell, gum, hyprland)
#   ~/.local/scripts/omarchy - omarchy-* runtime scripts (on PATH via zsh + uwsm env)
#
# Points the runtime at that tree and installs the commands those pieces call.
{ pkgs, ... }:

let
  # ttfx (terminal text effects, used by the screensaver) — not in nixpkgs.
  ttfx = pkgs.callPackage ./pkgs/ttfx.nix { };
  # aether (image -> theme GUI) — not in nixpkgs.
  aether = pkgs.callPackage ./pkgs/aether.nix { };
in
{
  # Fold the WebP/JPEG2000/etc. image-format plugins into quickshell's Qt
  # wrapper so the wallpaper (Background.qml) can decode WebP theme
  # backgrounds. Arch omarchy gets this via its qt6-* package list.
  nixpkgs.overlays = [
    (final: prev: {
      quickshell = prev.quickshell.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ prev.kdePackages.qtimageformats ];
      });
    })
  ];

  environment.sessionVariables = {
    OMARCHY_PATH = "$HOME/.config";
  };

  # uwsm sources ~/.config/uwsm/env.d/* (shipped from this repo as
  # config/uwsm/env.d/20-omarchy), which exports OMARCHY_PATH and the omarchy
  # bin paths for graphical-session processes started via uwsm.

  environment.systemPackages = with pkgs; [
    # Desktop shell runtime
    quickshell
    gum
    jq
    glib # gsettings (GTK theme + color-scheme retint)

    ttfx # terminal text effects, used by the omarchy screensaver
    aether # image -> Omarchy theme GUI

    # Compositor utilities used by the shell and omarchy scripts
    hyprland # hyprctl scripting, monitor watch/focus helpers
    grim
    slurp
    satty
    wl-clipboard
    cliphist
    brightnessctl
    pamixer
    hyprsunset # blue-light filter / night light (bar nightlight plugin)
    inotify-tools
    socat
    ydotool
    power-profiles-daemon

    # Launcher / terminal integration
    uwsm
    xdg-terminal-exec
    kitty # omarchy default terminal (list: omarchy.list)

    # Portals; omarchy sets XDG_CURRENT_DESKTOP=Hyprland itself
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    # Fonts used by the shell (menu glyphs, emoji picker) and themes
    noto-fonts-color-emoji
    webp-pixbuf-loader # image picker thumbnails

    # Thumbnail generators used by the theme background picker
    vips # vipsthumbnail
    ffmpegthumbnailer

    ffmpeg # theme background video support
  ];

  xdg.portal.enable = true;

  services.power-profiles-daemon.enable = true;
}
