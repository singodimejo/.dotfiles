{ config, lib, pkgs, ... }: {
  imports = [
    ./settings.nix
    ./binds.nix
    ./autostart.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    configType = "lua";
    # extraConfig is force-emptied because the old v2 config conflicts with
    # the generated lua config. Keep this to avoid stale merges.
    extraConfig = lib.mkForce "";
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
