{ config, lib, pkgs, ... }:

let
  mod = "SUPER";
  mkLua = lib.mkLuaInline;
in {
  # Enable Hyprland with Lua config type
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    configType = "lua";
    extraConfig = lib.mkForce "";
  };

  # Lua configuration
  wayland.windowManager.hyprland.settings = {
    # Monitor configuration
    # monitor = ",preferred,auto,1";
    monitor = {
      output = "eDP-1";
      mode = "preferred";
      position = "auto";
      scale = 1;
    };

    # Autostart
    on = {
      _args = [
        "hyprland.start"
        (mkLua "function()\n hl.exec_cmd(\"waybar & dunst & awww init & fcitx5 -d\")\nend")
      ];
    };

    # Variables
    config = {      
      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
        sensitivity = 0;
      };

      # General appearance
      general = {
        gaps_in = 10;
        gaps_out = 10;
        border_size = 2;
        col = {
          active_border = (mkLua "{ colors={\"rgba(33ccffee)\", \"rgba(00ff99ee)\"}, angle=45 }");
          inactive_border = (mkLua "{ colors={\"rgba(595959aa)\"}  }");
        };
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 2;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      # Animations
      animations = {
        enabled = true;
      };

      
      # Layout
      dwindle = {
        preserve_split = true;
      };
    };

    curve = {
      _args = [
        "myBezier"
        (mkLua "{ type=\"bezier\", points={{0.05, 0.9}, {0.1, 1.05}} }")
      ];
    };

    animation = [
      {
        _args = [
          (mkLua "{ leaf=\"windows\", enabled=true, speed=7, bezier=\"myBezier\" }")
        ];
      }
      {
        _args = [
          (mkLua "{ leaf=\"windowsOut\", enabled=true, speed=7, bezier=\"default\", style=\"popin 80%\" }")
        ];
      }
      {
        _args = [
          (mkLua "{ leaf=\"border\", enabled=true, speed=10, bezier=\"default\" }")
        ];
      }
      {
        _args = [
          (mkLua "{ leaf=\"borderangle\", enabled=true, speed=8, bezier=\"default\" }")
        ];
      }
      {
        _args = [
          (mkLua "{ leaf=\"fade\", enabled=true, speed=7, bezier=\"default\" }")
        ];
      }
      {
        _args = [
          (mkLua "{ leaf=\"workspaces\", enabled=true, speed=6, bezier=\"default\" }")
        ];
      }
    ];
    
    # Window rules
    window_rule = [
      # "float, class:kitty"
      # "tile, class:firefox"
    ];

    # Key bindings using _args
    bind = [
      # Launch applications
      {
        _args = [
          "${mod} + RETURN"
          (mkLua "hl.dsp.exec_cmd(\"kitty\")")
        ];
      }
      {
        _args = [
          "${mod} + B"
          (mkLua "hl.dsp.exec_cmd(\"firefox\")")
        ];
      }
      {
        _args = [
          "${mod} + Q"
          (mkLua "hl.dsp.window.close()")
        ];
      }
      # Window focus
      {
        _args = [
          "${mod} + left"
          (mkLua "hl.dsp.focus({ direction = \"left\" })")
        ];
      }
      {
        _args = [
          "${mod} + right"
          (mkLua "hl.dsp.focus({ direction = \"right\" })")
        ];
      }
      {
        _args = [
          "${mod} + up"
          (mkLua "hl.dsp.focus({ direction = \"up\" })")
        ];
      }
      {
        _args = [
          "${mod} + down"
          (mkLua "hl.dsp.focus({ direction = \"down\" })")
        ];
      }
      # Workspace switching
      {
        _args = [
          "${mod} + 1"
          (mkLua "hl.dsp.focus({ workspace = 1 })")
        ];
      }
      {
        _args = [
          "${mod} + 2"
          (mkLua "hl.dsp.focus({ workspace = 2 })")
        ];
      }
      {
        _args = [
          "${mod} + 3"
          (mkLua "hl.dsp.focus({ workspace = 3 })")
        ];
      }
      {
        _args = [
          "${mod} + 4"
          (mkLua "hl.dsp.focus({ workspace = 4 })")
        ];
      }
      {
        _args = [
          "${mod} + 5"
          (mkLua "hl.dsp.focus({ workspace = 5 })")
        ];
      }
      {
        _args = [
          "${mod} + 6"
          (mkLua "hl.dsp.focus({ workspace = 6 })")
        ];
      }
      {
        _args = [
          "${mod} + 7"
          (mkLua "hl.dsp.focus({ workspace = 7 })")
        ];
      }
      {
        _args = [
          "${mod} + 8"
          (mkLua "hl.dsp.focus({ workspace = 8 })")
        ];
      }
      {
        _args = [
          "${mod} + 9"
          (mkLua "hl.dsp.focus({ workspace = 9 })")
        ];
      }
      # Move window to workspace
      {
        _args = [
          "${mod} + SHIFT + 1"
          (mkLua "hl.dsp.window.move({ workspace = 1 })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + 2"
          (mkLua "hl.dsp.window.move({ workspace = 2 })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + 3"
          (mkLua "hl.dsp.window.move({ workspace = 3 })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + 4"
          (mkLua "hl.dsp.window.move({ workspace = 4 })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + 5"
          (mkLua "hl.dsp.window.move({ workspace = 5 })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + 6"
          (mkLua "hl.dsp.window.move({ workspace = 6 })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + 7"
          (mkLua "hl.dsp.window.move({ workspace = 7 })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + 8"
          (mkLua "hl.dsp.window.move({ workspace = 8 })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + 9"
          (mkLua "hl.dsp.window.move({ workspace = 9 })")
        ];
      }
      # Previous/next workspace
      {
        _args = [
          "${mod} + bracketleft"
          (mkLua "hl.dsp.focus({ workspace = \"e-1\" })")
        ];
      }
      {
        _args = [
          "${mod} + bracketright"
          (mkLua "hl.dsp.focus({ workspace = \"e+1\" })")
        ];
      }
      # Mouse wheel on status bar
      {
        _args = [
          "${mod} + mouse_down"
          (mkLua "hl.dsp.focus({ workspace = \"e-1\" })")
        ];
      }
      {
        _args = [
          "${mod} + mouse_up"
          (mkLua "hl.dsp.focus({ workspace = \"e+1\" })")
        ];
      }
      # Special workspace
      {
        _args = [
          "${mod} + S"
          (mkLua "hl.dsp.workspace.toggle_special(\"magic\")")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + S"
          (mkLua "hl.dsp.window.move({ workspace = \"special:magic\" })")
        ];
      }
      # Audio with flags
      {
        _args = [
          "XF86AudioRaiseVolume"
          (mkLua "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+\")")
          "{ repeating = true }"
        ];
      }
      {
        _args = [
          "XF86AudioLowerVolume"
          (mkLua "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
          "{ repeating = true }"
        ];
      }
      {
        _args = [
          "XF86AudioMute"
          (mkLua "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
        ];
      }
      # Screenshot
      {
        _args = [
          "${mod} + PRINT"
          (mkLua "hl.dsp.exec_cmd(\"hyprshot -m window --clipboard-only\")")
        ];
      }
      {
        _args = [
          "PRINT"
          (mkLua "hl.dsp.exec_cmd(\"hyprshot -m output --clipboard-only\")")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + PRINT"
          (mkLua "hl.dsp.exec_cmd(\"hyprshot -m region --clipboard-only\")")
        ];
      }
      # Misc
      {
        _args = [
          "${mod} + M"
          (mkLua "hl.dsp.exit()")
        ];
      }
      {
        _args = [
          "${mod} + V"
          (mkLua "hl.dsp.window.float()")
        ];
      }
      {
        _args = [
          "${mod} + SPACE"
          (mkLua "hl.dsp.exec_cmd(\"rofi -show drun\")")
        ];
      }
      {
        _args = [
          "${mod} + P"
          (mkLua "hl.dsp.window.pseudo()")
        ];
      }
      {
        _args = [
          "XF86MonBrightnessUp"
          (mkLua "hl.dsp.exec_cmd(\"brightnessctl set 5%+\")")
        ];
      }
      {
        _args = [
          "XF86MonBrightnessDown"
          (mkLua "hl.dsp.exec_cmd(\"brightnessctl set 5%-\")")
        ];
      }
      {
        _args = [
          "${mod} + mouse:272"
          (mkLua "hl.dsp.window.drag()")
          (mkLua "{ mouse = true }")
        ];
      }
      {
        _args = [
          "${mod} + mouse:273"
          (mkLua "hl.dsp.window.resize()")
          (mkLua "{ mouse = true }")
        ];
      }
    ];


    # Mouse bindings - bindm
    bindm = [
    ];
  };

  # Environment variables
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
