{ inputs, pkgs, config, username, greeter, ... }:
let
  tokyo-night-sddm = pkgs.libsForQt5.callPackage ./pkgs/tokyo-night-sddm.nix { };
  stable = import <nixos-stable> { config = { allowUnfree = true; }; };
in
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM  = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.mime.defaultApplications = {
    "inode/directory" = "org.kde.dolphin.desktop";
  };

  services = {
    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;
        theme = "tokyo-night-sddm";
        extraPackages = [ pkgs.kdePackages.qt5compat ];
      };
      defaultSession = "hyprland-uwsm";
    };
    libinput.enable = true;
    xserver.enable = true;
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    kdePackages.dolphin
    kdePackages.kservice
    xdg-utils
    shared-mime-info

    loupe
    swaynotificationcenter
    waybar
    swaylock
    wlogout
    wofi
    rofi-unwrapped
    hyprpaper
    udiskie
    grim
    slurp
    xwayland
    hyprpicker
    playerctl
    pavucontrol
    pyprland
    hyprshot
    wl-clipboard
    cliphist
    perl5Packages.FileMimeInfo
    hyprpolkitagent
    networkmanagerapplet

    tokyo-night-sddm
  ];

  services.udisks2.enable = true;
  security.polkit.enable = true;
}

