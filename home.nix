{ config, pkgs, hyprland, ... }:

{
  home.username = "jlewis";
  home.homeDirectory = "/home/jlewis";

  home.packages = with pkgs; [
    # browser
    firefox chromium

    # terminal
    iosevka 

    # hyprland
      # xdg-desktop-portal-hyprland # portal backend
      dunst # notifications
      # polkit_gnome # polkit
      hyprpaper # wallpaper
      rofi # app launcher

    # terminal utils
    zellij bacon typer just speedtest-cli neofetch iwd gitui tiny

    # zsh
    pure-prompt zsh-syntax-highlighting

    # other apps
    discord github-desktop obsidian rpi-imager spotify obs-studio zoom-us
    qdirstat vlc

    # games
    mars

    # network
    protonvpn-cli qbittorrent
  ];

  programs.zsh = {
    enable = true;
    history.size = 3000;
    initExtraFirst = ''
      autoload -U promptinit; promptinit
      prompt pure
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "nix-shell" ];
      custom = "/home/jlewis/.config/ohmyzsh_custom";
    };
    syntaxHighlighting = {
      enable = true;
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 1.0;
      
      font = {
        normal = {
          family = "Iosevka";
          style = "Bold";
        };

        bold = {
          family = "Iosevka";
          style = "Bold";
        };

        italic = {
          family = "Iosevka";
          style = "Bold";
        };

        bold_italic = {
          family = "Iosevka";
          style = "Bold";
        };

        size = 14;
      };

      colors = {
        primary = {
          background = "#15141b";
          foreground = "#edecee";
        };

        cursor.cursor = "#a277ff";

        selection = {
          text = "CellForeground";
          background = "#29263c";
        };

        normal = {
          black =   "#110f18";
          red =     "#ff6767";
          green =   "#61ffca";
          yellow =  "#ffca85";
          blue =    "#a277ff";
          magenta = "#a277ff";
          cyan =    "#61ffca";
          white =   "#edecee";
        };

        bright = {
          black =   "#4d4d4d";
          red =     "#ff6767";
          green =   "#61ffca";
          yellow =  "#ffca85";
          blue =    "#a277ff";
          magenta = "#a277ff";
          cyan =    "#61ffca";
          white =   "#edecee";
        };
      };
    };
  };

  programs.btop = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "fleet_dark";

      editor = {
        line-number = "relative";
        mouse = true;
        rulers = [ 80 ];
        bufferline = "always";
        color-modes = true;
        idle-timeout = 200;
        text-width = 100;
      
        statusline = {
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
        };

        auto-pairs = {
          "<" = ">";
        };
      };

      keys.insert = {
        "S-tab" = "unindent";
      };
    };

    languages.language = [
      {
        name = "rust";
        auto-format = true;
        formatter = {
          command = "cargo fmt";
        };
      }
    ];
      
  };
  
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}