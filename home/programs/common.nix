{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    # utils
    aria2
    bat
    btop
    file
    fzf
    iotop
    neofetch
    nvtop
    ripgrep
    tree
    unzip
    which
    zip

    # nix
    nixfmt
    home-manager

    # system tools
    ethtool
    lm_sensors # for `sensors` command
    pciutils # lspci
    sysstat
    usbutils # lsusb

    # audio
    pavucontrol
    playerctl
    qjackctl

    rofi # app launcher for hyprland #TODO: move it to hyprland deps

    # im
    telegram-desktop
    discord

    # misc
    spotify-player
    spotify
    obs-studio

    ffmpeg
  ];
}
