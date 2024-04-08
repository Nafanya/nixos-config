{ isLinux, isDarwin }:
{ pkgs, ... }:
let
  commonPackages = with pkgs; [
    # utils
    aria2
    bat
    btop
    file
    fzf
    neofetch
    nvtopPackages.full
    ripgrep
    tree
    unzip
    which
    zip

    # nix
    home-manager
    nixfmt

    #misc
    ffmpeg
    spotify
  ];
  linuxOnlyPackages = with pkgs; [
    # system tools
    ethtool
    iotop
    lm_sensors # for `sensors`
    pciutils # for `lspci`
    sysstat
    usbutils # for `lsusb`

    # audio
    pavucontrol
    playerctl
    qjackctl

    # desktop
    rofi # app launcher #TODO: move it closer to hyprland/X deps?

    # im
    discord
    telegram-desktop

    #misc
    obs-studio
  ];
  darwinOnlyPackages = with pkgs; [];
in {
  home.packages = commonPackages
  ++ (if isLinux then linuxOnlyPackages else [])
  ++ (if isDarwin then darwinOnlyPackages else []);
}
