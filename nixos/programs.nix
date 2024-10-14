{ inputs, pkgs, config, username, greeter, ... }:
{
	nixpkgs = {
		config = {
			allowUnfree = true;
		};
	};

	environment.systemPackages = with pkgs; [
		zsh
		firefox
		fzf
		git
		htop
		btop
		man-db
		solaar
		unzip
		vlc
		wireplumber
		neofetch
		w3m
		bat
		socat
		lsd
		fd
		vesktop
		spotify
		pamixer

		gamemode
		mangohud
		ripgrep
		heroic
		lutris
		wine
		winetricks

		neovim
		wget
		tmux
		kitty
		dbeaver-bin
		postman

		curl
		jq
		libusb
		wally-cli
		nodejs
		go_1_23
		python3
		cargo
		gcc
		luajit
		cmake
		ninja
		killall
		libjpeg
		bazecor
		elinks
		feh
		fuse-common
		gimp
		gnugrep
		gnumake
		gparted
		libverto
		luarocks
		lxappearance
		nfs-utils
		openssl
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
		python3Packages.evdev
		python3Packages.dbus-python
		gtk3
		python3Packages.psutil
		python3Packages.pygobject3
		python3Packages.pyudev
		python3Packages.pyyaml
		python3Packages.xlib
		librsvg
		wrapGAppsHook
		gdb
		pixman
		cairo
		pango
		seatd
		libxkbcommon
		libinput
		libliftoff
		libdisplay-info
		cpio
		tomlplusplus curl
	];

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		liberation_ttf
		font-awesome
		powerline-fonts
		powerline-symbols
		(nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
	];
	fonts.fontconfig = {
		defaultFonts = {
			serif = [  "Noto Serif" ];
			sansSerif = [ "Noto Sans" ];
			monospace = [ "Fira Code" ];
		};
	};


	# Steam
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
	};

	# Zsh
	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	# Postgres
	services.postgresql = {
		enable = true;
		ensureDatabases = [];
		authentication = pkgs.lib.mkOverride 10 ''
			#type database  DBuser  auth-method
			local all       all     trust
		'';
	};
}
