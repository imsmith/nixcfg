{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  wayland.windowManager.niri = {
    enable = true;
    
    settings = {
      # Input configuration
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            # options = "ctrl:nocaps";  # Uncomment to map caps lock to ctrl
          };
        };
        
        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true;  # disable while typing
        };
        
        mouse = {
          natural-scroll = false;
          accel-profile = "flat";
        };
      };

      # Output configuration (monitors)
      outputs = {
        # Example output configuration
        # "eDP-1" = {
        #   scale = 1.5;
        #   mode = {
        #     width = 1920;
        #     height = 1080;
        #     refresh = 60.0;
        #   };
        # };
      };

      # Layout configuration
      layout = {
        gaps = 8;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        default-column-width = { proportion = 0.5; };
        
        focus-ring = {
          enable = true;
          width = 2;
          active-color = "#7fc8ff";
          inactive-color = "#505050";
        };
        
        border = {
          enable = true;
          width = 1;
          active-color = "#7fc8ff";
          inactive-color = "#505050";
        };
      };

      # Window rules
      window-rules = [
        {
          matches = [{ app-id = "firefox"; }];
          default-column-width = { proportion = 1.0; };
        }
        {
          matches = [{ title = "Picture-in-Picture"; }];
          geometry-corner-radius = {
            top-left = 8.0;
            top-right = 8.0;
            bottom-left = 8.0;
            bottom-right = 8.0;
          };
          clip-to-geometry = true;
        }
      ];

      # Key bindings
      binds = {
        # Basic actions
        "Mod+Shift+Slash".action.show-hotkey-overlay = {};
        "Mod+Return".action.spawn = ["${pkgs.kitty}/bin/kitty"];
        "Mod+D".action.spawn = ["${pkgs.fuzzel}/bin/fuzzel"];
        "Mod+Shift+Q".action.close-window = {};
        "Mod+Shift+E".action.quit = {};
        
        # Focus
        "Mod+H".action.focus-column-left = {};
        "Mod+J".action.focus-window-down = {};
        "Mod+K".action.focus-window-up = {};
        "Mod+L".action.focus-column-right = {};
        "Mod+Left".action.focus-column-left = {};
        "Mod+Down".action.focus-window-down = {};
        "Mod+Up".action.focus-window-up = {};
        "Mod+Right".action.focus-column-right = {};
        
        # Move windows
        "Mod+Shift+H".action.move-column-left = {};
        "Mod+Shift+J".action.move-window-down = {};
        "Mod+Shift+K".action.move-window-up = {};
        "Mod+Shift+L".action.move-column-right = {};
        "Mod+Shift+Left".action.move-column-left = {};
        "Mod+Shift+Down".action.move-window-down = {};
        "Mod+Shift+Up".action.move-window-up = {};
        "Mod+Shift+Right".action.move-column-right = {};
        
        # Workspaces
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        
        # Move to workspace
        "Mod+Shift+1".action.move-window-to-workspace = 1;
        "Mod+Shift+2".action.move-window-to-workspace = 2;
        "Mod+Shift+3".action.move-window-to-workspace = 3;
        "Mod+Shift+4".action.move-window-to-workspace = 4;
        "Mod+Shift+5".action.move-window-to-workspace = 5;
        "Mod+Shift+6".action.move-window-to-workspace = 6;
        "Mod+Shift+7".action.move-window-to-workspace = 7;
        "Mod+Shift+8".action.move-window-to-workspace = 8;
        "Mod+Shift+9".action.move-window-to-workspace = 9;
        
        # Column width
        "Mod+R".action.switch-preset-column-width = {};
        "Mod+F".action.maximize-column = {};
        "Mod+Shift+F".action.fullscreen-window = {};
        
        # Screenshots
        "Print".action.screenshot = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window = {};
        
        # System
        "XF86AudioRaiseVolume".action.spawn = ["${pkgs.pulseaudio}/bin/pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%"];
        "XF86AudioLowerVolume".action.spawn = ["${pkgs.pulseaudio}/bin/pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%"];
        "XF86AudioMute".action.spawn = ["${pkgs.pulseaudio}/bin/pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle"];
        "XF86MonBrightnessUp".action.spawn = ["${pkgs.brightnessctl}/bin/brightnessctl" "set" "+5%"];
        "XF86MonBrightnessDown".action.spawn = ["${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-"];
      };

      # Prefer dark theme
      prefer-no-csd = true;
      
      # Cursor
      cursor = {
        xcursor-theme = "Adwaita";
        xcursor-size = 24;
      };

      # Environment variables
      environment = {
        # DISPLAY = ":0";
      };

      # Screenshot path
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    };
  };

  # Additional packages needed for niri
  home.packages = with pkgs; [
    kitty          # Terminal
    fuzzel         # Application launcher
    brightnessctl  # Brightness control
    pulseaudio     # Audio control
  ];
}
