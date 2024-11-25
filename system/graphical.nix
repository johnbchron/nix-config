{ pkgs, tikv-explorer, system, ... }: {
  # xserver
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

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
    overlays = [
      # iosevka
      (import ../extra/iosevka-overlay.nix)
      # tikv-explorer wrapper
      (final: prev: let 
        tikv-explorer-wrapped = (pkgs.writeShellScriptBin "tikv-explorer" ''
          ${tikv-explorer.packages."${system}".server}/bin/site-server "$@"
        '');
      in {
        tikv-explorer = tikv-explorer-wrapped;
      })
    ];
  };

  environment.variables = {
    # this is to tell electron apps to use wayland, for hyprland
    "NIXOS_OZONE_WL" = "1";
    # this is to fix cursor icons for some wayland apps
    "XCURSOR_THEME" = "Adwaita";
  };

  fonts.packages = with pkgs; [
    inter # google-fonts
    iosevka-term-custom
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    # iosevka-custom
  ];

  # daemons
  programs.dconf.enable = true;
  services.printing.enable = true;
  # this isn't really graphical but it's only necessary on a physical machine
  services.usbmuxd.enable = true;
}
