{ pkgs, tikv-explorer, iosevka-pin, system, ... }: {
  # xserver
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs; [
    gnome-music
    # gedit # text editor
    epiphany # web browser
    geary # email reader
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
    gnome-calendar
  ]);

  nixpkgs = {
    config = {
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
    overlays = let
      # pinned nixpkgs for iosevka, with the customizations
      iosevka-pin-pkgs = import iosevka-pin {
        inherit system;
        overlays = [ (import ../extra/iosevka-overlay.nix) ];
      };
      iosevka-overlay = final: prev: {
        inherit (iosevka-pin-pkgs) iosevka-custom iosevka-term-custom;
      };
      tikv-explorer-overlay = final: prev: {
        tikv-explorer = prev.writeShellScriptBin "tikv-explorer" ''
          ${tikv-explorer.packages."${system}".server}/bin/site-server "$@"
        '';
      };
    in [
      iosevka-overlay
      tikv-explorer-overlay
    ];
  };

  environment.variables = {
    # this is to tell electron apps to use wayland, for hyprland
    "NIXOS_OZONE_WL" = "1";
    # this is to fix cursor icons for some wayland apps
    "XCURSOR_THEME" = "Adwaita";
  };

  fonts.packages = with pkgs; [
    inter
    roboto
    oswald

    iosevka-custom
    iosevka-term-custom

    ia-writer-quattro ia-writer-duospace

    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  # daemons
  programs.dconf.enable = true;
  services.printing.enable = true;
  # # this isn't really graphical but it's only necessary on a physical machine
  services.usbmuxd.enable = true;

  services.gnome.gnome-keyring.enable = true;
  # services.protonmail-bridge = {
  #   enable = true;
  #   logLevel = "debug";
  #   path = with pkgs; [ pass gnome-keyring libnotify ];
  # };
}
