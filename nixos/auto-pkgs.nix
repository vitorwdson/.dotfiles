{ inputs, pkgs, config, username, greeter, ... }:
{
  environment.systemPackages = with pkgs; [
    # AUTO-INSTALL
    nwg-look
    obs-studio
  ];
}
