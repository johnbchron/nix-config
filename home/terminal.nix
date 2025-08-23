{ pkgs, ... }: {
  imports = [
    ./terminal/helix.nix
    ./terminal/git.nix
    ./terminal/rss.nix
    ./terminal/zsh.nix
  ];

  home.packages = with pkgs; [
    # basic shell utils
    uutils-coreutils-noprefix
    just file fzf gitoxide

    # archives
    unzip gzip 

    # http & friends
    curl wget jq

    # extra nix helpers
    comma nix-tree

    # networking
    nmap
    inetutils

    # other utilities
    tio # serial device tool
    gurk-rs # signal client
    pass gnome-keyring
    # peroxide

    # asahi vm stuff
    distrobox

    # misc
    jj-watch
    protonvpn-cli_2
    sl # steam locomotive
    typer # typing test
    cfspeedtest # for testing network speed
    fastfetch # rip neofetch :(
  ];

  # shell history
  programs.atuin = {
    settings = {
      inline_height = 0;
      enter_accept = true;
    };
    enable = true;
  };

  # replacement for `cat`
  programs.bat.enable = true;

  # system monitors
  programs.btop.enable = true;
  programs.bottom.enable = true;

  # automatic project environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # replacement for `ls`
  programs.eza.enable = true;

  # gpg
  programs.gpg.enable = true;

  # gpg agent
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };

  # accounts.email.certificatesFile = "/var/lib/peroxide/cert.pem";
  accounts.email.accounts.main = {
    primary = true;
    address = "main@jlewis.sh";
    realName = "John Lewis";
    userName = "main@jlewis.sh";
    passwordCommand = "cat /home/jlewis/keys/protonmail-bridge_pass";
    
    thunderbird.enable = true;

    imap = {
      host = "127.0.0.1";
      port = 1143;
      tls = {
        enable = true;
        # useStartTls = true;
      };
    };
    smtp = {
      host = "127.0.0.1";
      port = 1025;
      tls = {
        enable = true;
        # useStartTls = true;
      };
    };
  };

  # replacement for `grep`
  programs.ripgrep.enable = true;

  # spotify
  programs.spotify-player = {
    enable = true;
    settings = {
      client_id = "23e6643f44fe407b9cdc74b6274c9fb5";
      device = {
        name = "gimli-splayer";
        device_type = "computer";
        volume = 100;
        bitrate = 320;
        audio_cache = true;
        normalization = true;
      };
      # customized weirdly because of iosevka
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
        disabled = false;

        format = "with [$symbol$loaded/$allowed](bold yellow) ";
        allowed_msg = "a";
        not_allowed_msg = "n";
        denied_msg = "d";
        loaded_msg = "l";
        unloaded_msg = "u";
        # format = "with $symbol$loaded/$allowed ";
        # allowed_msg = "[a](bold green)";
        # not_allowed_msg = "[n](bold orange)";
        # denied_msg = "[d](bold red)";
        # loaded_msg = "[l](bold blue)";
        # unloaded_msg = "[u](bold red)";
      };
      git_status = {
        # deleted = "X";
      };
      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state]($style) ";
      };
    };
    enableZshIntegration = true;
  };

  programs.thunderbird = {
    enable = true;
    profiles.jlewis = {
      isDefault = true;
    };
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

  # terminal multiplexer
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      default_layout = "compact";
      session_serialization = false;
      show_startup_tips = false;
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
      advanced_mouse_actions = false;
    };
  };
}
