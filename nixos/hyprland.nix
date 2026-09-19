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
    "inode/directory" = "org.gnome.Nautilus.desktop";
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
    nautilus
    xdg-utils
    shared-mime-info

    loupe
    swaylock
    wlogout
    udiskie
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

