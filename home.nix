{ config, pkgs, copilot-wrapped, helix-fork, ... }:

{
  home.username = "jlewis";

  home.packages = with pkgs; [
    # browser
    chromium
    firefox

    # terminal
    iosevka
    # global language servers
    nil vscode-langservers-extracted

    # hyprland
    dunst # notifications
    rofi # app launcher
    iwgtk # networking

    # terminal utils
    typer just speedtest-cli neofetch gitui uair

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

    # for gpg signing
    pinentry-gnome

    # dconf
    gnome.dconf-editor

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
      ls = "eza";
      l = "eza -alh";
      with-rust = "nix develop \"/home/jlewis/github/with-rust\" --command $SHELL";
    };
    sessionVariables = {
      "VISUAL" = "${helix-fork.packages.aarch64-linux.default}/bin/hx";
      "EDITOR" = "${helix-fork.packages.aarch64-linux.default}/bin/hx";
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
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "-c" "zellij" ];
      };
    
      window = {
        opacity = 1.0;
        # startup_mode = "Fullscreen";
        # option_as_alt = "Both";
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

        size = 13;
      };

      # catppuccin theme
      colors = {
        primary = {
          background = "#1E1E2E"; # base
          foreground = "#CDD6F4"; # text
          # Bright and dim foreground colors
          dim_foreground = "#CDD6F4"; # text
          bright_foreground = "#CDD6F4"; # text
        };

        # Cursor colors
        cursor = {
          text = "#1E1E2E"; # base
          cursor = "#F5E0DC"; # rosewater
        };
        vi_mode_cursor = {
          text = "#1E1E2E"; # base
          cursor = "#B4BEFE"; # lavender
        };

        # Search colors
        search = {
          matches = {
            foreground = "#1E1E2E"; # base
            background = "#A6ADC8"; # subtext0
          };
          focused_match = {
            foreground = "#1E1E2E"; # base
            background = "#A6E3A1"; # green
          };
        };

        # Keyboard regex hints
        hints = {
          start = {
            foreground = "#1E1E2E"; # base
            background = "#F9E2AF"; # yellow
          };
          end = {
            foreground = "#1E1E2E"; # base
            background = "#A6ADC8"; # subtext0
          };
        };

        # Selection colors
        selection = {
          text = "#1E1E2E"; # base
          background = "#F5E0DC"; # rosewater
        };

        # Normal colors
        normal = {
          black = "#45475A"; # surface1
          red = "#F38BA8"; # red
          green = "#A6E3A1"; # green
          yellow = "#F9E2AF"; # yellow
          blue = "#89B4FA"; # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5"; # teal
          white = "#BAC2DE"; # subtext1
        };

        # Bright colors
        bright = {
          black = "#585B70"; # surface2
          red = "#F38BA8"; # red
          green = "#A6E3A1"; # green
          yellow = "#F9E2AF"; # yellow
          blue = "#89B4FA"; # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5"; # teal
          white = "#A6ADC8"; # subtext0
        };

        # Dim colors
        dim = {
          black = "#45475A"; # surface1
          red = "#F38BA8"; # red
          green = "#A6E3A1"; # green
          yellow = "#F9E2AF"; # yellow
          blue = "#89B4FA"; # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5"; # teal
          white = "#BAC2DE"; # subtext1
        };

        indexed_colors = [
          { index = 16; color = "#FAB387"; }
          { index = 17; color = "#F5E0DC"; }
        ];
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "clock-format" = "12h";
      "clock-show-date" = true;
      "clock-show-weekday" = true;
      "color-scheme" = "prefer-dark";
      "font-antialiasing" = "rgba";
      "enable-hot-corners" = false;
      "show-battery-percentage" = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      "accel-profile" = "adaptive";
      "tap-to-click" = false;
      "natural-scroll" = false;
    };
    "org/gnome/mutter" = {
      "dynamic-workspaces" = true;
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
    "org/gnome/desktop/screensaver" = {
      "color-shading-type" = "solid";
      "picture-options" = "zoom";
      "picture-uri" = "file:///home/jlewis/.local/share/backgrounds/2024-02-06-09-55-19-pexels-eberhard-grossgasteiger-640781.jpg";
    };
  };

  programs.git = {
    enable = true;
    ignores = [ ".direnv" "result" ];
    userName = "John Lewis";
    userEmail = "github@jlewis.sh";

    signing = {
      # signByDefault = true;
      key = "0x89C8A7794A74A0AB";
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
    # theme = {
    #   package = pkgs.flat-remix-gtk;
    #   name = "Flat-Remix-GTK-Grey-Darkest";
    # };
    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  programs.helix = {
    enable = true;
    package = helix-fork.packages.aarch64-linux.default;
    
    settings = {
      theme = "catppuccin_macchiato";

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
          language-servers = [ "copilot" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "nix";
          language-servers = [ "nil" "copilot" ];
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

  home.file.hyprland-config = {
    target = ".config/hypr/hyprland.conf";
    text = ''
      monitor=,preferred,auto,1.5

      exec-once = dunst & alacritty
      
      $mainMod = SUPER
      $terminal = alacritty
      $browser = chromium
      $menu = rofi -show drun
      
      bind = $mainMod, 1, exec, $terminal
      bind = $mainMod, 2, exec, $browser
      bind = $mainMod, Q, killactive
      bind = $mainMod, M, exit
      bind = Alt_L, SPACE, exec, $menu
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, F, fullscreen

      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      general {
        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
      }

      decoration {
        rounding = 10

        blur {
          enabled = true
          size = 3
          passes = 1
          vibrancy = 0.1696
        }

        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
      }

      gestures {
        workspace_swipe = true
        workspace_swipe_invert = false
      }

      misc {
        force_default_wallpaper = -0
        vrr = 1
      }
    '';
  };
  
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
