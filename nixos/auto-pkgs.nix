{ inputs, pkgs, config, username, greeter, ... }:
{
  environment.systemPackages = with pkgs; [
    # AUTO-INSTALL
    yt-dlp
    komikku
    foot
    parallel bat bat-extras.batman
    tealdeer
    bc
    dracula-theme
    nwg-look
    obs-studio
  ];
}
