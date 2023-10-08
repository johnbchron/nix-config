# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
 
{ config, pkgs, hyprland, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];

  nixpkgs.overlays =
    [
      # hyprland.overlays.hyprland-packages
    ];

  # binary cache
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      auto-optimise-store = true;
      substituters = [
        # "https://surrealdb.cachix.org"
        # "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        # "surrealdb.cachix.org-1:rbm7Qs+s36pxbfk9jhIa5HRld6gZ63koZz1h/9sSxaA="
        # "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "jlewis-laptop"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Chicago";

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

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # set up users
  users = {
    defaultUserShell = pkgs.zsh;
    users.jlewis = {
      isNormalUser = true;
      description = "John Lewis";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        # browser
        firefox chromium
  
        # terminal
        alacritty iosevka 

        # hyprland
          # xdg-desktop-portal-hyprland # portal backend
          dunst # notifications
          # polkit_gnome # polkit
          hyprpaper # wallpaper
          rofi # app launcher
  
        # terminal utils
        zellij btop bacon typer just speedtest-cli neofetch iwd gitui
  
        # zsh
        pure-prompt zsh-syntax-highlighting
  
        # other apps
        discord github-desktop obsidian rpi-imager spotify obs-studio zoom-us
        qdirstat vlc
  
        # games
        mars
  
        # network
        protonvpn-cli qbittorrent
      ];
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    # for sublime4 and github-desktop
    "openssl-1.1.1v" "openssl-1.1.1w"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basic shell utils
    wget curl git tree file unzip gzip

    # fancy shell utils
    helix fzf btop bat

    # proxies and such
    cloudflared # used to proxy ssh
  ];

  # add zsh to /etc/shells
  environment.shells = with pkgs; [ zsh ];
  # set /bin/sh to dash for speeeeeed
  environment.binsh = "${pkgs.dash}/bin/dash";
  environment.variables = {
    "VISUAL" = "${pkgs.helix}";
    "EDITOR" = "${pkgs.helix}";
    # this is to tell electron apps to use wayland, for hyprland
    "NIXOS_OZONE_WL" = "1";
    # this is to fix cursor icons for some wayland apps
    "XCURSOR_THEME" = "Adwaita";
    # # this is to tell tree where to find my git config
    # "GIT_DIR" = "/home/jlewis/.config/git";
  };

  environment.shellAliases = {
    e = "exit";
    clr = "clear";
    snorbs = "sudo nixos-rebuild switch --flake '/etc/nixos#'";
    treeg = "tree --gitignore";
    nd = "nix develop --command $SHELL";
  };

  # use ZSH instead of BASH
  programs.zsh = {
    enable = true;
    histSize = 3000;
    ohMyZsh = {
      enable = true;
      plugins = [ "nix-shell" ];
      custom = "/home/jlewis/.config/ohmyzsh_custom";
    };
  };

  # configure Hyprland
  programs.hyprland = {
    enable = true;
  };

  # configure steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # configure direnv
  programs.direnv.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  virtualisation.docker.enable = true;

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
  system.stateVersion = "23.05"; # Did you read the comment?
}
