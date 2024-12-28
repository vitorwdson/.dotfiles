{ inputs, pkgs, config, username, greeter, ... }:
let
  prismlauncher-cracked = pkgs.callPackage ./pkgs/prismlauncher-cracked.nix { };
  stable = import <nixos-stable> { config = { allowUnfree = true; }; };
in
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
		keychain
		libreoffice-qt6-fresh
		chromium
		chromedriver
		nurl
		nix-search-cli

		gamemode
		gamescope
		mangohud
		ripgrep
		stable.heroic
		lutris
		wine
		winetricks

		neovim
		wget
		tmux
		kitty
		dbeaver-bin
		postman
		redis

		curl
		jq
		libusb1
		wally-cli
		nodejs
		yarn
		pnpm
		go_1_23
		python313Full
		jdk
		jdk17
		cargo
		gcc
		lua51Packages.lua
		cmake
		ninja
		killall
		libjpeg
		elinks
		feh
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
		tomlplusplus
		xdg-utils
		desktop-file-utils
		pkg-config
		wails
		transmission_4-gtk
		prismlauncher-cracked

		# Dev stuff
		air
		gopls
		templ
		gofumpt
		golines
		gotools
		buf
		gomodifytags
		goose
		protobuf
		protoc-gen-connect-go
		protoc-gen-go
		sqlc
		pyright
		ruff
		djlint
		emmet-language-server
		lua-language-server
		marksman
		taplo
		tailwindcss-language-server
		prettierd
		htmx-lsp
		sql-formatter
		sqls
		typescript-language-server
	];

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-emoji
		liberation_ttf
		font-awesome
		powerline-fonts
		powerline-symbols
		nerd-fonts.fira-code
		nerd-fonts.symbols-only
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
		package = pkgs.postgresql_17;
		ensureDatabases = [];
		authentication = pkgs.lib.mkOverride 10 ''
			# TYPE  DATABASE        USER            ADDRESS                 METHOD
			# "local" is for Unix domain socket connections only
			local   all             all                                     trust
			# IPv4 local connections:
			host    all             all             127.0.0.1/32            trust
			host    all             all             127.0.0.1/32            md5
			host    all             all             127.0.0.1/32            scram-sha-256
			# IPv6 local connections:
			host    all             all             ::1/128                 trust
			host    all             all             ::1/128                 md5
			host    all             all             ::1/128                 scram-sha-256
		'';
	};

	# Redis
	services.redis.servers.main = {
		enable = true;
		port = 6379;
	};

	# Waidroid
	virtualisation.waydroid.enable = true;

	# Docker
	virtualisation.docker = {
		enable = true;
		daemon.settings = {
			data-root = "/home/docker/";
		};
	};
}
