{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "riey";
  home.homeDirectory = "/home/riey";
  home.sessionVariables = {
    EDITOR = "nvim";
    LESS_CHARSET = "utf-8";
    GPG_TTY = "$(tty)";
  };

  home.packages = with pkgs; [
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config.italic-text = "always";
  };

  programs.lsd = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Riey";
    userEmail = "creeper844@gmail.com";
    signing = {
      key = "6D3331CEE6D14FDAFC2B39872D09658FE7407060";
      signByDefault = true;
      gpgPath = "${pkgs.gnupg}/bin/gpg2";
    };
    extraConfig = {
      github.user  = "Riey";
      color.ui = "always";
      "credential \"https://github.com\"".helper = "!gh auth git-credential";
    };
  };

  programs.gpg = {
    enable = true;
  };

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   sshKeys = [ "6D3331CEE6D14FDAFC2B39872D09658FE7407060" ];
  #   pinentryFlavor = "gnome3";
  # };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {};
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
      }
    ];
    shellAliases = {
      cat = "bat";
      ls = "lsd";
      l = "lsd -l";
      ll = "lsd -l";
      la = "lsd -a";
      lla = "lsd -la";
      lt = "lsd --tree";
      lta = "lsd -a --tree";
      ltl = "lsd -l --tree";
      ltla = "lsd -la --tree";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "sudo" "cargo" "rust" "git" "gitfast" "github"
        "command-not-found" "cp" "docker" "fd" "ripgrep"
      ];
    };
  };

  programs.tmux = {
    enable = false;
    escapeTime = 0;
    keyMode = "vi";
    newSession = true;
    shortcut = "a";
    baseIndex = 1;
    extraConfig = ''
      set-option -g mouse on
      set-option -g status on
      set-option -g status-interval 2
      set-option -g status-justify "centre"
      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g renumber-windows on
      set-option -g set-titles on
      set -g default-terminal screen-256color
      set -g history-limit 10000
      setw -g monitor-activity on
      set -g visual-activity off
      set -g focus-events on

      bind-key c new-window -c "#{pane_current_path}"
      bind-key v split-window -h -c "#{pane_current_path}"
      bind-key s split-window -v -c "#{pane_current_path}"

      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key H resize-pane -L 5
      bind-key L resize-pane -R 5

      bind-key M-j resize-pane -D
      bind-key M-k resize-pane -U
      bind-key M-h resize-pane -L
      bind-key M-l resize-pane -R

# Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D 
      bind k select-pane -U
      bind l select-pane -R

# Use Alt-vim keys without prefix key to switch panes
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D 
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

# Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

# Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      bind x kill-pane
    '';
    plugins = [
    
      (pkgs.stdenv.mkDerivation {
        pluginName = "nord";
        pname = "tmuxplugin-nord";
        rtp = "share/tmux-plugins/nord.tmux";
        src = pkgs.fetchFromGitHub {
          owner = "arcticicestudio";
          repo = "nord-tmux";
          rev = "0.3.0";
          sha256 = "14xhh49izvjw4ycwq5gx4if7a0bcnvgsf3irywc3qps6jjcf5ymk";
        };
      })
      (pkgs.stdenv.mkDerivation {
        pluginName = "themepack";
        pname = "tmuxplugin-themepack";
        rtp = "share/tmux-plugins/themepack.tmux";
        src = pkgs.fetchFromGitHub {
          owner = "jimeh";
          repo = "tmux-themepack";
          rev = "1.1.0";
          sha256 = "00dmd16ngyag3n46rbnl9vy82ih6g0y02yfwkid32a1c8vdbvb3z";
        };
      })
    ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = dracula-vim;
        config = ''
          packadd! dracula-vim
          colorscheme dracula
        '';
      }
      vim-airline
      vim-airline-themes
      vim-nix
      vim-latex-live-preview
      latex-live-preview
      vim-toml
      syntastic
      coc-nvim
      coc-rust-analyzer
      nerdtree
      nerdtree-git-plugin
      auto-pairs
      rainbow
    ];
    extraConfig = builtins.readFile ./init.vim;
  };

  xdg.configFile."nvim/coc-settings.json".source = ./coc-settings.json;

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
        mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+Return" = "exec alacritty";
        "Print" = "exec grim -g \"$(slurp)\" \"~/Pictures/$(date + '%Y%m%d%H%M%S').png\"";
      };
    };
  };

  xdg.configFile."waybar/config".source = ./waybar/config;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}

