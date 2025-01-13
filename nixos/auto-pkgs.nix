{ inputs, pkgs, config, username, greeter, ... }:
{
  environment.systemPackages = with pkgs; [
    # AUTO-INSTALL
    vulkan-tools virtualgl
    virtualboxKvm
    corectrl
    yt-dlp
    komikku
    foot
    parallel bat
    tealdeer
    bc
    dracula-theme
    nwg-look
    obs-studio
  ];
}
