{ config, pkgs, copilot-wrapped, helix-fork, ... }:

{
  home.username = "jlewis";

  home.packages = with pkgs; [
    # browser
    chromium
    firefox

    # terminal
    iosevka nerdfonts 

    # # hyprland
    #   # xdg-desktop-portal-hyprland # portal backend
    #   dunst # notifications
    #   # polkit_gnome # polkit
    #   hyprpaper # wallpaper
    #   rofi # app launcher
    #   iwd # networking

    # terminal utils
    typer just speedtest-cli neofetch gitui uair

    # other apps
    #/ discord
    github-desktop
    obsidian
    rpi-imager
    #/ spotify
    obs-studio
    #/ zoom-us
    qdirstat
    vlc

    # games
    mars

    # network
    protonvpn-cli qbittorrent
  ];

  programs.zsh = {
    enable = true;
    history.size = 3000;
    shellAliases = {
      e = "exit";
      clr = "clear";
      snorbs = "sudo nixos-rebuild switch --flake '/home/jlewis/nix-config#' --impure";
      treeg = "tree --gitignore";
      nd = "nix develop --command $SHELL";
    };
    sessionVariables = {
      "VISUAL" = "${helix-fork.packages.aarch64-linux.default}";
      "EDITOR" = "${helix-fork.packages.aarch64-linux.default}";
    };
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
      window = {
        opacity = 1.0;
        # startup_mode = "Fullscreen";
        option_as_alt = "Both";
      };
      
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

      key_bindings = [
        {
          key = "N";
          mods = "Command";
          action = "ReceiveChar";
        }
      ];

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

      # debug = {
      #   render_timer = true;
      # };
    };
  };

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

  # gtk = {
  #   enable = true;

  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };

  #   theme = {
  #     name = "Orchis";
  #     package = pkgs.orchis-theme;
  #   };

  #   cursorTheme = {
  #     name = "Numix-Cursor";
  #     package = pkgs.numix-cursor-theme;
  #   };

  #   gtk3.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };

  #   gtk4.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };

  #   font.name = "Cantarell";
  #   font.size = 11;
  # };

  # home.sessionVariables.GTK_THEME = "Orchis";
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "font-antialiasing" = "rgba";
      "enable-hot-corners" = false;
      "color-scheme" = "prefer-dark";
      "show-battery-percentage" = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      "tap-to-click" = true;
      "natural-scroll" = true;
    };
    "org/gnome/mutter" = {
      "edge-tiling" = true;
      "experimental-features" = [ "scale-monitor-framebuffer" ];
    };
    "org/gnome/settings-daemon/plugins/power" = {
      "idle-dim" = false;
      "idle-delay" = 0;
      "power-saver-profile-on-low-battery" = false;
      "sleep-inactive-battery-type" = "suspend";
      "sleep-inactive-battery-timeout" = 1800;
      "sleep-inactive-ac-type" = "nothing";
      "power-button-action" = "interactive";
    };
  };

  programs.git = {
    enable = true;
    ignores = [ ".direnv" "result" ];
    userName = "John Lewis";
    userEmail = "github@jlewis.sh";
  };

  #home.file.helix-aura-theme = {
  #  target = ".config/helix/themes/aura.toml";
  #  text = import ./helix-aura-theme.toml;
  #};

  programs.helix = {
    enable = true;
    package = helix-fork.packages.aarch64-linux.default;
    
    settings = {
      theme = "aura";

      editor = {
        line-number = "relative";
        mouse = true;
        rulers = [ 80 ];
        bufferline = "always";
        color-modes = true;
        idle-timeout = 200;
        text-width = 80;
      
        statusline = {
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
          # inline-diagnostics = {
          #   enabled = true;
          # };
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

        soft-wrap = {
          enable = true;
          wrap-at-text-width = true;
        };
      };

      keys.insert = {
        "S-tab" = "unindent";
        "C-y" = "apply_copilot_completion";
      };

      keys.normal = {
        "q" = ":quit-all";
      };
    };

    languages = {
      language-server = {
        copilot = {
          command = "${copilot-wrapped.packages.aarch64-linux.default}/bin/copilot";
          args = [ "--stdio" ];
        };
      };

      language = [
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = "cargo fmt";
          };
          language-servers = [ "rust-analyzer" "copilot" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "javascript";
          language-servers = [ "typescript-language-server" "copilot" ];
        }
        {
          name = "typescript";
          language-servers = [ "typescript-language-server" "copilot" ];
        }
        {
          name = "jsx";
          language-servers = [ "typescript-language-server" "copilot" ];
        }
        {
          name = "tsx";
          language-servers = [ "typescript-language-server" "copilot" ];
        }
        {
          name = "wgsl";
          language-servers = [ "wgsl_analyzer" "copilot" ];
        }
      ];
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
      nix_shell = {
        symbol = "❄️ ";
      };
    };
    enableZshIntegration = true;
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
      theme = "dracula";
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
    };
  };

  home.file.zellij-layout-rust-dev = {
    target = ".config/zellij/layouts/rust-dev.kdl";
    text = ''
      layout split_direction="vertical" {
        pane command="hx"
        pane split_direction="horizontal" {
          pane command="bacon -s"
          pane
        }
      }
    '';
  };
  
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
