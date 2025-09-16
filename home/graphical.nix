{ pkgs, ... }: {
  imports = [
    ./graphical/alacritty.nix
    ./graphical/dconf.nix
    # ./graphical/hyprland.nix
    # ./graphical/niri.nix
    # ./graphical/wezterm.nix
  ];

  home.packages = with pkgs; [
    floorp-bin
    ungoogled-chromium

    # other apps
    anki # flashcards
    obsidian # notes & stuff
    rpi-imager # disk imaging
    obs-studio # recording & streaming
    blender # video editing & compositing
    qdirstat # disk space usage 
    vlc # video playback
    fstl # viewing stl files
    gimp # image editing
    # libreoffice-still # office stuff
    audacity # audio editing
    fragments # torrents
    inkscape # vector editing
    dconf-editor # dconf obv
    signal-desktop # messaging

    # games
    mars
    prismlauncher

    # network
    qbittorrent

    # gnome stuff
    gnome-tweaks
    gnomeExtensions.just-perfection

    # audio
    pulseaudio
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
