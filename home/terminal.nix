{ pkgs, ... }: {
  imports = [
    ./terminal/helix.nix
    ./terminal/git.nix
    ./terminal/rss.nix
    ./terminal/zsh.nix
  ];

  home.packages = with pkgs; [
    # basic shell utils
    git # version control
    unzip # unzips zip archives
    gzip # zips gz archives
    fzf # generic fuzzy finder
    btop # pretty system monitor
    bat # cat but fancy
    eza # ls but fancy
    just # command runner
    wget # http fetching
    curl # http fetching
    file # provides file info
    jq # queries json

    typer # typing test
    speedtest-cli # for testing network speed
    neofetch # :sunglasses:
    protonvpn-cli # proton vpn

    # my programs
    # scribe.packages.${system}.default
  ];

  # shell history
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  # system monitor
  programs.btop = {
    enable = true;
  };

  # btop alternative
  programs.bottom = {
    enable = true;
  };

  # automatic project environments
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  # github cli
  programs.gh = {
    enable = true;
  };

  # gpg
  programs.gpg = {
    enable = true;
  };

  # gpg agent
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };

  # irc/matrix client
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

  # spotify
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
      cover_img_length = 12;
      cover_img_width = 5;
    };
  };

  # extra fancy shell prompt
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
        truncate_to_repo = false;
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

  # extra smart cd command
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # terminal multiplexer
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
}
