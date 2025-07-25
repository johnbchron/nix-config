{ pkgs, inputs, config, ... }: {
  imports = [
    ./ssh.nix
  ];

  nix = {
    registry = pkgs.lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = pkgs.lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
    '';
    settings = {
      auto-optimise-store = true;
      allow-import-from-derivation = true;
      trusted-users = [ "root" "jlewis" ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://cache.ngi0.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
        "obsidian" "copilot.vim"
      ];
      # contentAddressedByDefault = true;
    };
  };

  # only used when building a VM
  virtualisation.vmVariant = {
    users.users.jlewis.password = "password";
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
  };

  time.timeZone = "America/Chicago";
  # time.timeZone = "Europe/Zurich";

  # internationalization
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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

  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-index = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };
  programs.zsh.enable = true;

  # set /bin/sh to dash for speeeeeed
  environment.binsh = "${pkgs.dash}/bin/dash";

  environment.variables = {
    "VISUAL" = "${pkgs.helix}/bin/hx";
    "EDITOR" = "${pkgs.helix}/bin/hx";
  };

  # daemons
  services.openssh.enable = true;
  services.pipewire.enable = true;
  services.pipewire.wireplumber.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.tailscale.enable = true;
  services.ollama.enable = true;

  # services.peroxide = {
  #   enable = true;
  #   logLevel = "Debug";
  # };

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
