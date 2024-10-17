{ inputs, pkgs, config, username, greeter, ... }:
let
  tokyo-night-sddm = pkgs.libsForQt5.callPackage ./pkgs/tokyo-night-sddm.nix { };
in
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #   ];
  # };

  services = {
    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;
        theme = "tokyo-night-sddm";
      };
    };
    libinput.enable = true;
    xserver.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome.nautilus

    loupe
    swaynotificationcenter
    waybar
    swaylock
    wlogout
    rofi-wayland-unwrapped
    hyprpaper
    udiskie
    grim
    slurp
    pipewire
    wireplumber
    xwaylandvideobridge
    xwayland
    hyprpicker
    playerctl
    pavucontrol

    tokyo-night-sddm
    dracula-theme
  ];

  services.udisks2.enable = true;
  security.polkit.enable = true;
}

