
{ config, pkgs, apple-silicon-support, hyprland, hardwarePath, ... }: {
  imports = [
    hardwarePath
  ];

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
  boot.loader.efi.canTouchEfiVariables = false;
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  # Asahi hardware-specific
  hardware.asahi = {
    withRust = true;
    addEdgeKernelConfig = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    setupAsahiSound = true;
  };

  hardware.opengl.enable = true;
  hardware.opengl.package = pkgs.lib.mkForce pkgs.mesa-asahi-edge.drivers;

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.iwd.enable = true;
  networking.hostName = "gimli"; # Define your hostname.

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

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-music
    # gedit # text editor
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
  ]);
  programs.dconf.enable = true;

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
      extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" ];
    };
  };

  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
    allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
       "obsidian" "steam" "steam-original" "steam-runtime" "steam-run"
     ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basic shell utils
    wget curl git tree file unzip gzip

    # fancy shell utils
    fzf btop bat eza

    # proxies and such
    cloudflared # used to proxy ssh

    # gnome stuff
    gnome.gnome-tweaks
    gnomeExtensions.desktop-cube
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
    "GLOBAL_LIBGL" = "${pkgs.lib.makeLibraryPath [ pkgs.libGL ]}";
  };

  environment.shellAliases = {
    e = "exit";
    clr = "clear";
    snorbs = "sudo nixos-rebuild switch --flake '/etc/nixos#'";
    treeg = "tree --gitignore";
    nd = "nix develop --command $SHELL";
  };

  programs.zsh.enable = true;

  # # configure steam
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  # };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Start the docker daemon.
  virtualisation.docker.enable = true;
  #virtualisation.virtualbox.host.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
