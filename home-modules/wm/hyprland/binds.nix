{ config, lib, pkgs, ... }:

let
  mod = "SUPER";
  mkLua = lib.mkLuaInline;

  workspaces = builtins.genList (n: n + 1) 9;

  focusBind = ws: {
    _args = [
      "${mod} + ${toString ws}"
      (mkLua "hl.dsp.focus({ workspace = ${toString ws} })")
    ];
  };
  moveBind = ws: {
    _args = [
      "${mod} + SHIFT + ${toString ws}"
      (mkLua "hl.dsp.window.move({ workspace = ${toString ws} })")
    ];
  };
in {
  wayland.windowManager.hyprland.settings.bind =
    (builtins.map focusBind workspaces)
    ++ (builtins.map moveBind workspaces)
    ++ [
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
      # Previous/next workspace
      {
        _args = [
          "${mod} + bracketleft"
          (mkLua "hl.dsp.focus({ workspace = \"e-1\" })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + bracketleft"
          (mkLua "hl.dsp.window.move({ workspace = \"e-1\" })")
        ];
      }
      {
        _args = [
          "${mod} + bracketright"
          (mkLua "hl.dsp.focus({ workspace = \"e+1\" })")
        ];
      }
      {
        _args = [
          "${mod} + SHIFT + bracketright"
          (mkLua "hl.dsp.window.move({ workspace = \"e+1\" })")
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
          (mkLua "{ repeating = true }")
        ];
      }
      {
        _args = [
          "XF86AudioLowerVolume"
          (mkLua "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
          (mkLua "{ repeating = true }")
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
          "${mod} + C"
          (mkLua "hl.dsp.exec_cmd(\"clipcat-menu\")")
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
}
