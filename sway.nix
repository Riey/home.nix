{ config, pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
    systemdIntegration = true;
    extraSessionCommands = ''
      export GTK_IM_MODULE=kime
      export QT_IM_MODULE=kime
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NOREPARENTING=1
    '';
    config = {
      terminal = "alacritty";
      modifier = "Mod1";
      menu = "rofi -show drun -show-icons | xargs swaymsg exec --";
      bars = [{
        command = "waybar";
      }];
      output = {
        "*" = {
          bg = "~/wallpaper/wallpaper.jpg fill";
          mode = "1920x1080@75Hz";
        };
        "HDMI-A-1" = {
          position = "0,0";
        };
        "HDMI-A-2" = {
          position = "1920,0";
        };
      };
      modes = {
        resize = {
          "${config.wayland.windowManager.sway.config.left}" = "resize shrink width 30px";
          "${config.wayland.windowManager.sway.config.right}" = "resize grow width 30px";
          "${config.wayland.windowManager.sway.config.down}" = "resize grow height 30px";
          "${config.wayland.windowManager.sway.config.up}" = "resize shrink height 30px";

          "${config.wayland.windowManager.sway.config.modifier}+r" = "mode default";
          "Return" = "mode default";
          "Escape" = "mode default";
        };
      };
      keybindings = let
        left = "h";
        down = "j";
        up = "k";
        right = "l";
        mod = config.wayland.windowManager.sway.config.modifier;
        mod_ctrl = "${mod}+Ctrl";
      in lib.mkOptionDefault {
        "${mod}+Return" = "exec alacritty";
        "${mod_ctrl}+${left}" = "move workspace to output left";
        "${mod_ctrl}+${down}" = "move workspace to output down";
        "${mod_ctrl}+${up}" = "move workspace to output up";
        "${mod_ctrl}+${right}" = "move workspace to output right";
        "${mod_ctrl}+left" = "move workspace to output left";
        "${mod_ctrl}+down" = "move workspace to output down";
        "${mod_ctrl}+up" = "move workspace to output up";
        "${mod_ctrl}+right" = "move workspace to output right";
        "Print" = "exec grim -g \"$(slurp)\" \"~/Pictures/$(date + '%Y%m%d%H%M%S').png\"";
      };
    };
    extraConfig = ''
      assign [class="firefox"]            number 2
      assign [class="jetbrains-.*"]       number 3
      assign [class="Emacs"]              number 3
      assign [class="Steam"]              number 5
      assign [class="Lutris"]             number 5
      assign [class="Clementine"]         number 9

      for_window [instance="battle.net.exe"]                  floating enable
      for_window [class="mpv"]                                floating enable
      for_window [class="vlc"]                                floating enable
      for_window [class="discord"]                            floating enable
      for_window [class="jetbrains-.*" title="win0"]          floating enable border none
      for_window [class="konsole" floating]                   resize set 800 600
      for_window [title="Picture-in-Picture"]                 floating enable
      for_window [title="이미지 업로드 .*"]                   floating enable

      workspace 1  output  HDMI-A-1
      workspace 3  output  HDMI-A-1
      workspace 5  output  HDMI-A-1

      workspace 2  output  HDMI-A-2
      workspace 4  output  HDMI-A-2
      workspace 6  output  HDMI-A-2
      workspace 7  output  HDMI-A-2
      workspace 8  output  HDMI-A-2
      workspace 9  output  HDMI-A-2

      exec kime-indicator
    '';
  };

  programs.rofi = {
    enable = true;
    terminal = "alacritty";
    theme = "Arc-Dark";
  };

  programs.alacritty = {
    enable = true;
    settings =
      let
        font = "Hack Nerd Font";
        size = 14;
      in {
      window.dimensions = {
        columns = 100;
        lines = 60;
      };
      scrolling.history = 10000;
      scrolling.multiplier = 3;
      font.normal.family = font;
      font.normal.size = size;
      font.bold.family = font;
      font.bold.size = size;
      font.italic.family = font;
      font.italic.size = size;
      background_opacity = 0.6;
      shell.program = "/run/current-system/sw/bin/zsh";
      mouse_bindings = [
        {
          mouse = "Middle";
          action = "PasteSelection";
        }
        {
          mouse = "Right";
          action = "Copy";
        }
      ];
      key_bindings = [
        {
          key = "Paste";
          action = "Paste";
        }
        {
          key = "Copy";
          action = "Copy";
        }
        {
          key = "Space";
          mods = "Shift|Control";
          action = "ToggleViMode";
        }
      ];
      # Oxide
      colors = {
        # Default colors
        primary = {
          background = "0x212121";
          foreground = "0xc0c5ce";
          bright_foreground = "0xf3f4f5";
        };
      
        cursor = {
          text = "0x212121";
          cursor = "0xc0c5ce";
        };
      
        # Normal colors
        normal = {
          black = "0x212121";
          red =   "0xe57373";
          green = "0xa6bc69";
          yellow ="0xfac863";
          blue =  "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xc0c5ce";
        };
      
        # Bright colors
        bright = {
          black = "0x5c5c5c";
          red = "0xe57373";
          green = "0xa6bc69";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xf3f4f5";
        };
      };
    };
  };

  xdg.configFile."waybar/config".source = ./waybar/config;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
}

