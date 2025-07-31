{ inputs, pkgs, config, username, greeter, ... }:
{
  environment.systemPackages = with pkgs; [
    # AUTO-INSTALL
    nss
    ftb-app
    clamav
    kdePackages.kdenlive
    ffmpeg-full
    virtiofsd
    swtpm
    bottles
    rar
    rustup
    amdgpu_top
    lshw
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
