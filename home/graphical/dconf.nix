{ ... }: {
  dconf.settings = let
    "background-uri" = "file:///home/jlewis/.local/share/backgrounds/2024-07-21-12-18-23-IMG_6573.png";
  in {
    "org/gnome/desktop/interface" = {
      "clock-format" = "24h";
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
      "speed" = 0.15;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      "speed" = -0.2;
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
      "picture-uri" = background-uri;
    };
    "org/gnome/desktop/background" = {
      "picture-uri" = background-uri;
      "picture-uri-dark" = background-uri;
    };
    "org/gnome/shell" = {
      "enabled-extensions" = [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "just-perfection-desktop@just-perfection"
      ];
      "disable-user-extensions" = false;
    };
    "org/gnome/shell/extensions/just-perfection" = {
      "clock-menu-position" = 1;
    };
    "org/gnome/shell/keybindings" = {
      "show-screenshot-ui" = [ "<Super>s" ];
    };
    "org/gnome/wm/keybindings" = {
      "switch-applications" = [ "<Super>Tab" ];
      "switch-windows" = [ "<Alt>Tab" ];
      "toggle-quick-settings" = [];
      "close" = [ "<Super>q" ];
      "toggle-fullscreen" = [ "<Super>f" ];
    };
  };
}
