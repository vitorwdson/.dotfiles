{ inputs, pkgs, config, username, greeter, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  security = {
    polkit.enable = true;
    pam.services.ags = {};
  };

  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.autoNumlock = true;
      session = [
        {
          manage = "desktop";
          name = "Hyprland";
          start = "${pkgs.hyprland}/bin/Hyprland";
        }
      ];
      defaultSession = "Hyprland";
    };
    libinput.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome.baobab
    gnome.gnome-calendar
    gnome.gnome-boxes
    gnome.gnome-system-monitor
    gnome.gnome-control-center
    gnome.gnome-weather
    gnome.gnome-calculator
    gnome.gnome-clocks
    gnome.gnome-software # for flatpak

    loupe
    mako
    waybar
    swaylock
    wlogout
    wofi
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
    pulseaudio-ctl
    pamixer
    hyprland-protocols
    xdg-desktop-portal-hyprland
    numlockx

    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    xdg-desktop-portal-gtk
  ];

  programs.thunar.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services = {
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  systemd.user.services."numlockx" = {
    enable = true;
    script = ''
      ${pkgs.numlockx}/bin/numlockx on
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };
}
