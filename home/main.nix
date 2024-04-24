{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./dconf.nix
    ./git.nix
    ./helix.nix
    ./hyprland.nix
    ./zsh.nix
  ];

  home.username = "jlewis";

  home.packages = with pkgs; [
    # browser
    ungoogled-chromium
    firefox
    libreoffice-still

    # fonts
    iosevka inter
    iosevka-term # overriden; see `system.nix`

    # global language servers
    nil vscode-langservers-extracted

    # hyprland
    dunst # notifications
    rofi # app launcher
    iwgtk # networking

    # terminal utils
    typer # typing test
    just # command runner I use in all projects
    speedtest-cli # for testing network speed
    neofetch # :sunglasses:
    uair # pomodori timer

    # other apps
    discordo # discord tui
    obsidian # notes & stuff
    rpi-imager # disk imaging
    obs-studio # recording & streaming
    qdirstat # disk space usage 
    vlc # video playback
    fstl # viewing stl files
    gimp # image editing

    # dconf
    gnome.dconf-editor

    # games
    mars

    # network
    protonvpn-cli qbittorrent
    protonvpn-gui
  ];

  programs.btop = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
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
    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };


  programs.starship = {
    enable = true;
    settings = {
      battery = {
        full_symbol = "🔋 ";
        charging_symbol = "⚡️ ";
        discharging_symbol = "💀 ";
      };
      character = {
        success_symbol = "[ <->>](bold green)";
        error_symbol = "[ <](bold green)[-](bold red)[>>](bold green)";
      };
      directory = {
        truncation_length = 8;
        truncation_symbol = ">";
      };
      direnv = {
        format = "with [$symbol$loaded/$allowed](bold yellow) ";
        disabled = false;
        # allowed_msg = "[a](bold green)";
        # not_allowed_msg = "[n](bold orange)";
        # denied_msg = "[d](bold red)";
        # loaded_msg = "[l](bold blue)";
        # unloaded_msg = "[u](bold red)";
        allowed_msg = "a";
        not_allowed_msg = "n";
        denied_msg = "d";
        loaded_msg = "l";
        unloaded_msg = "u";
      };
      git_status = {
        deleted = "X";
      };
      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state]($style) ";
      };
    };
    enableZshIntegration = true;
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
          nicks = [ "johnbchron" ];

          join = [ "#asahi" ];
        }
      ];
      defaults = {
        realname = "johnbchron";
        nicks = [ "johnbchron" ];
      };
    };
  };

  home.file.uair-config = {
    target = ".config/uair/uair.toml";
    text = ''
      [defaults]
      format = "\r{time}           "

      [[sessions]]
      id = "work"
      name = "Work"
      duration = "25m"
      command = "notify-send 'Work Done!'"

      [[sessions]]
      id = "rest"
      name = "Rest"
      duration = "5m"
      command = "notify-send 'Rest Done!'"
    '';
  };

  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
    };
  };
  
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
