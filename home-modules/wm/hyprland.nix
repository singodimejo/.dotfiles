{ config, lib, pkgs, ... }:

{
  # Enable Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };  

  # Basic configuration
  wayland.windowManager.hyprland.settings = {
    # Monitor configuration (replace with your own settings)
    monitor = ",preferred,auto,1.2";

    # Autostart
    exec-once = [
      "waybar &"
      "dunst &"
      "swww init &"
      "fcitx5 -d"
    ];

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
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
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
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    # Layout
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    # Window rules
    windowrule = [
      # "float, class:kitty"
      # "tile, class:firefox"
    ];

    # Key bindings
    "$mod" = "SUPER";
    bind = [
      # Launch applications
      "$mod, RETURN, exec, kitty"
      "$mod, B, exec, firefox"
      "$mod, Q, killactive,"

      # Window focus
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # Workspace switching
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 5, workspace, 6"
      "$mod, 5, workspace, 7"
      "$mod, 5, workspace, 8"
      "$mod, 5, workspace, 9"

      # Move window to workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 5, movetoworkspace, 6"
      "$mod SHIFT, 5, movetoworkspace, 7"
      "$mod SHIFT, 5, movetoworkspace, 8"
      "$mod SHIFT, 5, movetoworkspace, 9"

      # Special workspace
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      # Audio
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      # Brightness
      ", 233, exec, brightnessctl set +5%"
      ", 232, exec, brightnessctl set -5%"

      # Misc
      "$mod, M, exit,"
      "$mod, V, togglefloating,"
      "$mod, SPACE, exec, rofi -show drun"
      "$mod, P, pseudo,"
      "$mod, J, togglesplit,"
    ];

    # Mouse bindings
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };

  # Extra settings (if any)
  wayland.windowManager.hyprland.extraConfig = ''
    # Example of manual config addition
    debug {
      damage_tracking=2
    }
  '';

  # Environment variables
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint for Electron apps to use Wayland
  };
}
