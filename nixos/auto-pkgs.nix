{ inputs, pkgs, config, username, greeter, ... }:
{
  environment.systemPackages = with pkgs; [
    # AUTO-INSTALL
    dracula-theme
    nwg-look
    obs-studio
  ];
}
