{ ... }: {
  home.file.hyprland-config = {
    target = ".config/hypr/hyprland.conf";
    text = ''
      monitor=eDP-1,3024x1890,auto,1.5

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
        vrr = 0
      }
    '';
  };
}
