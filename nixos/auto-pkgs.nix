{ inputs, pkgs, config, username, greeter, ... }:
{
  environment.systemPackages = with pkgs; [
    # AUTO-INSTALL
    lazygit
    basedpyright
    tree-sitter
    biome
    nodePackages.js-beautify stylua
    vscode-langservers-extracted
    nss
    ftb-app
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
