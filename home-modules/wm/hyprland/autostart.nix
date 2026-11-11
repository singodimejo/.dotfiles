{ config, lib, pkgs, ... }:

let
  mkLua = lib.mkLuaInline;
in {
  wayland.windowManager.hyprland.settings.on = {
    _args = [
      "hyprland.start"
      (mkLua "function()\n hl.exec_cmd(\"waybar & dunst & fcitx5 -d\")\nend")
    ];
  };
}
