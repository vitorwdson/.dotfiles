{ pkgs, ... }:

{
  # 1. Sound Server: PipeWire with JACK/PulseAudio support
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Required for yabridge/wine VST bridging
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    
    # Global low-latency defaults for native JACK clients
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;  # Fixed rate avoids resampling latency
        "default.clock.quantum" = 128;      # ~5ms latency at 48kHz
        "default.clock.min-quantum" = 64;   # ~2.5ms latency at 48kHz
        "default.clock.max-quantum" = 512;
      };
    };

    # Crucial: Match low-latency for PulseAudio clients (browsers, Steam/Rocksmith)
    extraConfig.pipewire-pulse."92-low-latency" = {
      "pulse.properties" = {
        "pulse.min.req" = "64/48000";    # Start with 64, not 32, for stability
        "pulse.default.req" = "64/48000";
        "pulse.max.req" = "128/48000";
      };
    };
  };

  # 2. Real-time Scheduling
  # RTKit handles real-time privileges via D-Bus/Polkit.
  security.rtkit.enable = true;
  
  # Critical: Allow unlimited memlock for real-time audio buffers
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
  ];
  
  users.users.vitorwdson.extraGroups = [ "audio" ]; # Replace 'yourname' with your username

  # 3. Kernel and Performance Tweaks
  boot.kernelPackages = pkgs.linuxPackages_zen; 
  boot.kernelParams = [ 
    "threadirqs"
    "preempt=full"              # Optional: add if experiencing Xruns
    "amd_pstate=passive"        # Zen 4/5: passive + performance governor = stable freq
    # For Intel or older AMD: remove amd_pstate or use "intel_pstate=active"
    "usbcore.autosuspend=-1"    # Prevent USB audio interface sleep
  ];

  powerManagement.cpuFreqGovernor = "performance";
  
  # GameMode can elevate priorities for real-time audio applications
  programs.gamemode.enable = true;

  # 4. Plugin Search Paths (Crucial for NixOS DAWs)
  # Use sessionVariables for GUI apps launched from DE menu
  environment.sessionVariables = let
    makePluginPath = format:
      (pkgs.lib.makeSearchPath format [
        "$HOME/.nix-profile/lib"
        "/run/current-system/sw/lib"
        "/etc/profiles/per-user/$USER/lib"
      ]) + ":$HOME/.${format}";
  in {
    LV2_PATH = makePluginPath "lv2";
    VST3_PATH = makePluginPath "vst3";
    CLAP_PATH = makePluginPath "clap";  # Modern plugin format, supported by LSP/Chow
  };

  # 5. Essential Packages
  nixpkgs.config.allowUnfree = true; # Required for REAPER, Tonelib, etc.
  environment.systemPackages = with pkgs; [
    # --- Utilities & Routing ---
    qpwgraph            # Visual patchbay for PipeWire
    pavucontrol         # Profile selection (Pro Audio mode)
    # pw-top              # Real-time CPU usage per audio node
    # pw-cli              # Modern alternative to pw-metadata
    # cpupower            # CPU frequency scaling controls
    alsa-scarlett-gui   # Hardware mixer for Focusrite Scarlett (may require firmware)

    # --- DAWs ---
    ardour
    reaper

    # --- Plugin Hosts ---
    carla               # Modular plugin host / pedalboard, supports Windows VST via yabridge

    # --- Standalone Guitar Processors ---
    guitarix

    # --- Plugins (LV2/CLAP) ---
    neural-amp-modeler-lv2  # NAM: loads .nam files from https://tonehunt.org
    lsp-plugins             # Includes latency meter, compressors, IR loader
    calf
    dragonfly-reverb
    gxplugins-lv2
    kapitonov-plugins-pack  # Profile-based amp models (KPP)
    chow-centaur            # Klon Centaur emulation
    chow-phaser

    # --- Practice & Learning ---
    tuxguitar
    hydrogen

    # --- Windows VST Compatibility ---
    yabridge
    yabridgectl
    wineWow64Packages.stable  # Use wineWow64Packages, as wineWowPackages is deprecated
  ];
}

