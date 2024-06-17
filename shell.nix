{ ... }: {
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
    shellAliases = let
      tree = "eza --tree --all --long --header --total-size --git --git-repos --mounts --hyperlink";
    in {
      e = "exit";
      cleanup-dev = "rm -rf ~/github/*/{.direnv/,result} ~/playground/*/{.direnv/,result}";
      clr = "clear";
      gu = "gitui";
      l = "eza --all --long --header --total-size --git --git-repos --mounts --hyperlink";
      ls = "eza";
      inherit tree;
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
