{
  config,
  pkgs,
  ...
}: {
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Liberation Serif" "Noto Serif CJK JP"  ];
      sansSerif = [ "Liberation Sans" "Noto Sans CJK JP"  ];
      monospace = [ "FiraMono Nerd Font Mono" ];
    };
  };
}
