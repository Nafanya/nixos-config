{ config, pkgs, lib, ... }:

{
  home.username = "nikita";
  home.homeDirectory = "/home/nikita";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    extraConfig = ''
      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      #
      
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=DP-3,2560x1440@144,0x0,1
      monitor=,preferred,auto,1
      
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      
      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox
      
      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf
      
      # Some default env vars.
      env = XCURSOR_SIZE,24
      
      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us,ru
          kb_variant =
          kb_model =
          kb_options = grp:caps_toggle
          kb_rules =
      
          follow_mouse = 1
      
          touchpad {
              natural_scroll = no
          }
      
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      
      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
      
          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
      
          layout = dwindle
      
          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false
      }
      
      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
      
          rounding = 10
          
          blur {
              enabled = true
              size = 3
              passes = 1
          }
      
          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }
      
      animations {
          enabled = yes
      
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
      
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }
      
      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }
      
      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }
      
      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }
      
      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
      }
      
      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic-mouse-v1 {
          sensitivity = -0.5
      }
      
      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      
      
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER
      
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, C, killactive, 
      bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, V, togglefloating, 
      bind = $mainMod, R, exec, rofi -show drun
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      
      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      
      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10
      
      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic
      
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Nikita Iashchenko";
    userEmail = "nikita.yaschenko@gmail.com";
    diff-so-fancy = {
      enable = true;
      pagerOpts = [ "--tabs=4" "-R" ];
    };
  };

  programs.neovim = {
    defaultEditor = true;
    enable = true;
  };

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    XDG_SESSION_TYPE = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    nnn # terminal file manager

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    bat # A cat(1) clone with syntax highlighting and Git integration

    # networking tools
    aria2 # A lightweight multi-protocol & multi-source command-line download utility

    # misc
    file
    which
    tree

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    #nix-output-monitor

    btop  # replacement of htop/nmon
    iotop # io monitoring

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    rofi # app launcher for hyprland
  ];

  home.activation.steam = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD sed 's/^Exec=/&nvidia-offload /' \
    ${pkgs.steam}/share/applications/steam.desktop \
    > ${config.xdg.dataHome}/applications/steam.desktop
    $DRY_RUN_CMD chmod +x ${config.xdg.dataHome}/applications/steam.desktop
  '';

  # kitty -- a cross-platform, GPU-accelerated terminal emulator
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_family = "monospace";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "14.0";
    };
  };

  services.dunst = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    history = {
      size = 100000;
    };
    shellAliases = {
      update = "sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
