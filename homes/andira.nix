{
  config,
  pkgs,
  ...
}: {
  home.username = "andira";
  home.homeDirectory = "/home/andira";

  imports = [
    ../home-modules/widgets/waybar.nix
    ../home-modules/wm/hyprland
  ];

  home.packages = with pkgs; [
    podman-compose
    wp-cli
    pnpm
    htop
    microfetch
    p7zip
    vlc
    # obsidian
    gajim
    gopls
    delve
    otpclient
    krita
    inkscape-with-extensions
    wev
    evtest
    whois
    dig
    dust

    # TUIs
    bluetui
    wiremix
    # impala

    # Language Servers
    nil
    markdown-oxide
    svelte-language-server
    intelephense
    biome    
  ];

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION=1;
  };

  programs = {
    bat.enable = true;
    fzf.enable = true;
    rofi.enable = true;
    nushell.enable = true;
    tmux.enable = true;
    gpg.enable = true;
    obsidian.enable = true;
    go.enable = true;
    ripgrep.enable = true;
    ripgrep-all.enable = true;
    gitui.enable = true;
    hyprshot.enable = true;
    rmpc.enable = true;

    # Process Managers
    btop.enable = true;
    bottom.enable = true;

    bash = {
      enable = true;
      shellAliases = {
        gtt = "ssh singodimejo@tilde.town -i /home/andira/.ssh/tilde.town";
        gtc = "ssh tablelion@ctrl-c.club -i /home/andira/.ssh/tilde.town";
      };
    };

    zsh = {
      enable = true;
      initContent = ''
        source ${pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/moarram/headline/main/headline.zsh-theme";
          hash = "sha256-lxnLei7zi1sErvPXtTAObvcJUsXtpVxVZWQdZYMnFcU="; 
        }}
      '';
      shellAliases = {
        gtt = "ssh singodimejo@tilde.town -i /home/andira/.ssh/tilde.town";
        gtc = "ssh tablelion@ctrl-c.club -i /home/andira/.ssh/tilde.town";
      };
    };

    eza = {
      enable = true;
#     enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
    
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        editor.soft-wrap = {
          enable = true;
          max-indent-retain = 0;
        };
        editor.file-picker = {
          hidden = false;
        };
      };
    };

    kitty = {
      enable = true;
      font = {
        size = 12;
        name = "FiraCode Nerd Font Mono";
      };  
      settings.shell = "${pkgs.zsh}/bin/zsh";
    };

    yazi = {
      enable = true;
      shellWrapperName = "y";
      settings = {
        mgr.show_hidden = true;
      };
    };
  };

  services = {
    dunst.enable = true;
    awww.enable = true;
    podman.enable = true;
    mpd = {
      enable = true;
      musicDirectory = /home/andira/Music;
    };
  };
  
  home.stateVersion = "25.05";
}
