{ pkgs, ... }: {
  imports = [
    ./graphical/alacritty.nix
    ./graphical/dconf.nix
    # ./graphical/hyprland.nix
    # ./graphical/niri.nix
    ./graphical/wezterm.nix
  ];

  home.packages = with pkgs; [
    floorp
    firefox
    ungoogled-chromium

    # first-party overlay-supplied apps
    tikv-explorer
  
    # fonts
    inter
    iosevka-term-custom
    iosevka-custom

    # hyprland
    dunst # notifications
    rofi # app launcher
    iwgtk # networking

    # niri
    wl-clipboard
    wayland-utils
    libsecret
    cage

    # other apps
    obsidian # notes & stuff
    rpi-imager # disk imaging
    obs-studio # recording & streaming
    blender # video editing & compositing
    qdirstat # disk space usage 
    vlc # video playback
    fstl # viewing stl files
    gimp # image editing
    libreoffice-still # office stuff
    audacity # audio editing
    fragments # torrents
    inkscape # vector editing
    dconf-editor # dconf obv
    # discordo # discord tui

    # games
    mars

    # network
    qbittorrent
    protonvpn-gui

    # gnome stuff
    gnome-tweaks
    gnomeExtensions.just-perfection
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

}
