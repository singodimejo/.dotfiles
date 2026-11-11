{ config, lib, pkgs, ... }:

let
  mod = "SUPER";
  mkLua = lib.mkLuaInline;
in {
  wayland.windowManager.hyprland.settings = {
    # Monitor configuration
    # monitor = ",preferred,auto,1";
    monitor = {
      output = "eDP-1";
      mode = "preferred";
      position = "auto";
      scale = 1;
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
  };
}
