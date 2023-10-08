{ config, pkgs, hyprland, ... }:

{
  home.username = "jlewis";
  home.homeDirectory = "/home/jlewis";

  home.packages = with pkgs; [
    # browser
    firefox chromium

    # terminal
    alacritty iosevka 

    # hyprland
      # xdg-desktop-portal-hyprland # portal backend
      dunst # notifications
      # polkit_gnome # polkit
      hyprpaper # wallpaper
      rofi # app launcher

    # terminal utils
    zellij btop bacon typer just speedtest-cli neofetch iwd gitui tiny

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

  # configure direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
  
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}