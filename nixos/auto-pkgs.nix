{ inputs, pkgs, config, username, greeter, ... }:
{
  environment.systemPackages = with pkgs; [
    # AUTO-INSTALL
    tealdeer
    bc
    dracula-theme
    nwg-look
    obs-studio
  ];
}
