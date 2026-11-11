{
  config,
  pkgs,
  wlctl,
  ...
}: {
  home.username = "andira";
  home.homeDirectory = "/home/andira";

  imports = [
    ../home-modules/widgets/waybar.nix
    ../home-modules/wm/hyprland
  ];

  home.packages = with pkgs; [
    p7zip
    vlc
    otpclient
    stirling-pdf-desktop

    # Messenger
    gajim
    telegram-desktop

    # Programming tools
    delve
    pnpm
    wp-cli
    podman-compose
    nodejs_26
    
    # Debug and monitoring tools
    wev
    evtest
    whois
    dig
    dust
    htop
    microfetch

    # Drawing    
    gimp
    krita
    inkscape-with-extensions
    
    # TUIs
    bluetui
    wiremix
    wlctl.packages.${pkgs.stdenv.hostPlatform.system}.default
    # impala

    # Language Servers
    nil
    gopls
    markdown-oxide
    svelte-language-server
    intelephense
    biome    

    # AI Harness
    deepseek-harness
    bubblewrap
  ];

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "kde";
    QT_WAYLAND_DISABLE_WINDOWDECORATION=1;
  };

  programs = {
    bat.enable = true;
    fzf.enable = true;
    rofi.enable = true;
    tmux.enable = true;
    gpg.enable = true;
    obsidian.enable = true;
    go.enable = true;
    ripgrep.enable = true;
    ripgrep-all.enable = true;
    gitui.enable = true;
    hyprshot.enable = true;
    rmpc.enable = true;
    anki.enable = true;
    # opencode.enable = true;
    herdr.enable = true;

    nushell = {
      enable = true;
      loadSessionVariables = true;
    };

    zellij= {
      enable = true;
      settings = {
        default_shell = "zsh";
      };
    };

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
        size = 16;
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
    nextcloud-client.enable = true;
    mpd = {
      enable = true;
      musicDirectory = /home/andira/Music;
    };
    clipcat = {
      enable = true;
      menuSettings = {
        server_endpoint = "/run/user/1000/clipcat/grpc.sock";
        finder = "rofi";
        rofi = {
          line_length = 100;
          menu_length = 30;
          menu_prompt = "Clipcat";
          extra_arguments = [
            "-mesg"
            "Please select a clip"
          ];
        };
      };
    };
  };

  # The awww daemon is managed by services.awww; this applies the wallpaper
  # once the daemon is up (and again whenever the graphical session restarts).
  systemd.user.services.awww-wallpaper = {
    Unit = {
      Description = "Set awww wallpaper";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Requires = [ "awww.service" ];
      After = [ "awww.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.awww}/bin/awww img ${config.home.homeDirectory}/Pictures/Backgrounds/wallhaven-solar-system.png";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  home.stateVersion = "25.05";
}
