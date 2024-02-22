# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./hyprland.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos-vitorwdson"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Cuiaba";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Moonlander and solaar udev rules
  services.udev.packages = [ 
    (pkgs.writeTextFile {
      name = "50-zsa.rules";
      text = ''
  	# Rules for Oryx web flashing and live training
  	KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
  	KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
  
  	# Legacy rules for live training over webusb (Not needed for firmware v21+)
  	  # Rule for all ZSA keyboards
  	  SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
  	  # Rule for the Moonlander
  	  SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
  	  # Rule for the Ergodox EZ
  	  SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
  	  # Rule for the Planck EZ
  	  SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"
  
  	# Wally Flashing rules for the Ergodox EZ
  	ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
  	ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
  	SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
  	KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
  
  	# Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
  	SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
      '';
      destination = "/etc/udev/rules.d/50-zsa.rules";
    })
    (pkgs.writeTextFile {
      name = "42-logitech-unify-permissions.rules";
      text = ''
  	# This rule was added by Solaar.
        #
        # Allows non-root users to have raw access to Logitech devices.
        # Allowing users to write to the device is potentially dangerous
        # because they could perform firmware updates.
        
        ACTION != "add", GOTO="solaar_end"
        SUBSYSTEM != "hidraw", GOTO="solaar_end"
        
        # USB-connected Logitech receivers and devices
        ATTRS{idVendor}=="046d", GOTO="solaar_apply"
        
        # Lenovo nano receiver
        ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6042", GOTO="solaar_apply"
        
        # Bluetooth-connected Logitech devices
        KERNELS == "0005:046D:*", GOTO="solaar_apply"
        
        GOTO="solaar_end"
        
        LABEL="solaar_apply"
        
        # Allow any seated user to access the receiver.
        # uaccess: modern ACL-enabled udev
        TAG+="uaccess"
        
        # Grant members of the "plugdev" group access to receiver (useful for SSH users)
        #MODE="0660", GROUP="plugdev"
        
        LABEL="solaar_end"
        # vim: ft=udevrules
      '';
      destination = "/etc/udev/rules.d/42-logitech-unify-permissions.rules";
    })
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable experimental features
    nix = {
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (builtins.parseDrvName pkg.name).name ["steam"];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vitorwdson = {
    isNormalUser = true;
    description = "Vitor Wdson";
    extraGroups = [
      "flatpak"
      "disk"
      "qemu"
      "kvm"
      "libvirtd"
      "sshd"
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "libvirtd"
      "root"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      neovim
      kitty
      solaar
      webcord
      spotify
      heroic
      steam
      steam-run
      mangohud
      gamemode
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vitorwdson";

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Zsh
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    curl
    jq
    wget
    git
    tmux
    fzf
    ripgrep
    libusb
    wally-cli
    nodejs
    go_1_22
    python3
    cargo
    gcc
    cmake
    ninja
    killall
    libjpeg
    neofetch
    bat
    bazecor
    clang-tools_9
    efibootmgr
    elinks
    feh
    flatpak
    floorp
    fontconfig
    freetype
    fuse-common
    gimp
    gnugrep
    gnumake
    gparted
    gnugrep
    grub2
    hugo
    libverto
    luarocks
    lxappearance
    mangohud
    nfs-utils
    openssl
    os-prober
    pavucontrol
    picom
    protonup-ng
    qemu
    sxhkd
    st
    stdenv
    synergy
    swaycons
    tldr
    trash-cli
    unzip
    variety
    virt-manager
    xclip
    xfce.thunar
    (lutris.override {
      extraPkgs = pkgs: [
	# List package dependencies here
	wineWowPackages.stable
	winetricks
      ];
    })
    pulseaudio

    python3Packages.evdev
    python3Packages.dbus-python
    gtk3
    python3Packages.hid-parser
    python3Packages.psutil
    python3Packages.pygobject3
    python3Packages.pyudev
    python3Packages.pyyaml
    python3Packages.xlib
    libappindicator
    librsvg
    gdk-pixbuf
    gobject-introspection
    wrapGAppsHook
    gdb
    xorg.libxcb
    xorg.xcbproto
    xorg.xcbutil
    xorg.xcbutilkeysyms
    xorg.libXfixes
    xorg.libX11
    xorg.libXcomposite
    xorg.xinput
    xorg.libXrender
    pixman
    wayland-protocols
    cairo
    pango
    seatd
    libxkbcommon
    xorg.xcbutilwm
    xwayland
    libinput
    libliftoff
    libdisplay-info
    cpio
    tomlplusplus
  ];

  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["FiraCode Nerd Font"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.flatpak.enable = true;
  services.dbus.enable = true;
  services.picom.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  virtualisation.libvirtd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
