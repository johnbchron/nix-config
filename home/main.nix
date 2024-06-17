{ pkgs, scribe, ... }: {
  imports = [
    ./alacritty.nix
    ./dconf.nix
    ./git.nix
    ./helix.nix
    ./hyprland.nix
    ./shell.nix
  ];

  home.username = "jlewis";

  home.packages = with pkgs; [
    # fonts
    inter
    iosevka-term # overriden; see `system.nix`
    # iosevka # regular iosevka

    # global language servers
    nil

    # hyprland
    dunst # notifications
    rofi # app launcher
    iwgtk # networking

    # terminal utils
    typer # typing test
    just # command runner I use in all projects
    speedtest-cli # for testing network speed
    neofetch # :sunglasses:
    # uair # pomodori timer

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
    # discordo # discord tui
    # non # audio editing

    # dconf
    gnome.dconf-editor

    # games
    mars

    # network
    protonvpn-cli qbittorrent
    protonvpn-gui

    # my programs
    scribe.packages.aarch64-linux.default
  ];

  programs.firefox = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  programs.spotify-player = {
    enable = true;
    settings = {
      device = {
        name = "gimli-splayer";
        device_type = "computer";
        volume = 100;
        bitrate = 320;
        audio_cache = true;
        normalization = true;
      };
    };
  };

  programs.tiny = {
    enable = true;
    settings = {
      servers = [
        {
          addr = "irc.oftc.net";
          port = 6697;
          tls = true;
          realname = "johnbchron";
          nicks = [ "john" ];

          join = [ "#asahi" ];
        }
      ];
      defaults = {
        realname = "johnbchron";
        nicks = [ "john" ];
      };
    };
  };
  
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
