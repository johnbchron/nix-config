{ pkgs, ... }: {
  imports = [
    ./terminal/helix.nix
    ./terminal/git.nix
    ./terminal/rss.nix
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

  programs.zsh = {
    enable = true;
    history.size = 3000;
    shellAliases = rec {
      e = "exit";
      cleanup-dev = "rm -rf ~/github/*/{.direnv/,result} ~/playground/*/{.direnv/,result}";
      clr = "clear";
      gu = "gitui";
      l = "eza --all --long --header --total-size --git --git-repos --mounts --hyperlink";
      ls = "eza";
      q = "exit";
      tree = "eza --tree --all --long --header --total-size --git --git-repos --mounts --hyperlink";
      treeg = tree + " --git-ignore";
      with-rust = "nix develop \"/home/jlewis/github/with-rust\" --command $SHELL";
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

  # nix-shell custom zsh plugin
  home.file.ohmyzsh-nix-shell = let
    nix-shell-repo = pkgs.fetchgit {
      url = "https://github.com/chisui/zsh-nix-shell";
      rev = "82ca15e638cc208e6d8368e34a1625ed75e08f90";
      hash = "sha256-Rtg8kWVLhXRuD2/Ctbtgz9MQCtKZOLpAIdommZhXKdE=";
    };
  in {
    source = "${nix-shell-repo}";
    target = ".config/ohmyzsh_custom/plugins/nix-shell";
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
