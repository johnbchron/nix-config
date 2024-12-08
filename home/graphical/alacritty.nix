{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "-c" "zellij" ];
      };
    
      window = {
        # opacity = 0.94;
        # blur = true;
        startup_mode = "Fullscreen";
        dynamic_padding = true;
        # option_as_alt = "Both";
      };
      
      font = {
        normal =      { family = "Iosevka Term Custom"; style = "SemiBold"; };
        bold =        { family = "Iosevka Term Custom"; style = "ExtraBold"; };
        italic =      { family = "Iosevka Term Custom"; style = "SemiBold Italic"; };
        bold_italic = { family = "Iosevka Term Custom"; style = "Bold Italic"; };

        size = 14;
        # builtin_box_drawing = false;
      };

      # catppuccin mocha theme
      colors = import ./alacritty_colors.nix;
      # debug = {
      #   render_timer = true;
      # };
    };
  };
}
