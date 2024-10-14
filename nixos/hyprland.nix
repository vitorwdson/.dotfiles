{ inputs, pkgs, config, username, greeter, ... }:
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
      sddm.enable = true;
      sddm.autoNumlock = true;
    };
    libinput.enable = true;
    xserver.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome.nautilus

    loupe
    mako
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
  ];

  services.udisks2.enable = true;
  security.polkit.enable = true;
}

