{
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "network" "battery" "pulseaudio" "clock" ];

        "hyprland/window" = {
          max-length = 75;
        };

        "network" = {
        #   "interface"= "wlp5s0";
            "format"= "{ifname}";
            "format-wifi"= "󰖩 {signalStrength}%";
            "format-ethernet"= "{ipaddr}/{cidr} 󰊗";
            "format-disconnected"= "";
            "tooltip-format"= "{ifname} via {gwaddr} 󰊗";
            "tooltip-format-wifi"= "󰖩 {essid} ({signalStrength}%)";
            "tooltip-format-ethernet"= "{ifname} ";
            "tooltip-format-disconnected"= "Disconnected";
        #   "max-length"= 50;
         };

         "battery" = {
           format = "󱐋 {capacity}%";
         };

         "pulseaudio" = {
           format = "󰕿 {volume}%";
           format-muted = "󰖁";
           on-click = "kitty -e wiremix";
         };

         "clock" = {
           format = "󰃰 {:%R}";
           format-alt = "󰃰 {:%d-%m-%Y}";
           tooltip-format = "󰃰 {:%a, %d-%m-%Y | %R}";
         };
      };
    };
    style = ''
      * {
        font-family: "FiraMono Nerd Font Mono", monospace;
        font-size: 16px;
      }
      
      #network, #clock, #battery, #pulseaudio {
        padding: 0 10px;
      }      
    '';
  };
}
