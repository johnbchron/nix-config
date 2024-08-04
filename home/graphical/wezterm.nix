{ pkgs, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()
        
      config.enable_wayland = false
      config.color_scheme = "catppuccin-mocha"
      config.default_prog = {
        "${pkgs.zsh}/bin/zsh",
        "-c",
        "zellij -l compact"
      }
      config.font = wezterm.font("Iosevka Custom")
    
      return config
    '';
  };
}
