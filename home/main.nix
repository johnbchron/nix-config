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
    chromium
    firefox

    # terminal
    # iosevka-term is an overriden package
    iosevka iosevka-term
    # global language servers
    nil vscode-langservers-extracted

    # hyprland
    dunst # notifications
    rofi # app launcher
    iwgtk # networking

    # terminal utils
    typer just speedtest-cli neofetch uair

    # other apps
    discordo
    obsidian
    rpi-imager
    spotify-tui
    obs-studio
    #/ zoom-us
    qdirstat
    vlc
    fstl # viewing stl files
    gimp

    # for gpg signing
    pinentry-gnome

    # dconf
    gnome.dconf-editor

    # games
    mars

    # network
    protonvpn-cli qbittorrent
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
    pinentryFlavor = "gnome3";
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

  services.spotifyd  = {
    enable = true;
    settings = {
      global = {
        username = "spotify@jlewis.sh";
        password = "4w1k2sFFhJBIwiU4aIzYjwBH2";
        device_name = "gimli-spotifyd";
        autoplay = false;
        device_type = "computer";
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
