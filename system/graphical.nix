{ pkgs, niri, ... }: {
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
  ]) ++ (with pkgs.gnome; [
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
  ]);

  nixpkgs = {
    config = {
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
        "obsidian"
      ];
      packageOverrides = super: let self = super.pkgs; in {
        iosevka-term = self.iosevka.override (import ../extra/iosevka.nix);
      };
    };
    overlays = [
      niri.overlays.niri
    ];
  };

  environment.variables = {
    # this is to tell electron apps to use wayland, for hyprland
    "NIXOS_OZONE_WL" = "1";
    # this is to fix cursor icons for some wayland apps
    "XCURSOR_THEME" = "Adwaita";
  };

  # wayland compositors
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # daemons
  programs.dconf.enable = true;
  services.printing.enable = true;
  # this isn't really graphical but it's only necessary on a physical machine
  services.usbmuxd.enable = true;
}
