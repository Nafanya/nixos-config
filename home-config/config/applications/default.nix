{ config, pkgs, ... }:
{
  imports = [
    ./emacs.nix
    ./firefox.nix
    ./kitty.nix
    ./neovim.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    aria2
    bat
    btop
    file
    fzf
    neofetch
    ripgrep
    rclone
    tree
    unzip
    wget
    which
    zip

    # nix
    home-manager

    #misc
    ffmpeg
    spotify
    instaloader

    # system tools
    ethtool
    iotop
    lm_sensors # for `sensors`
    pciutils # for `lspci`
    sysstat
    usbutils # for `lsusb`
    nvtopPackages.full
    smartmontools

    # im
    discord
    telegram-desktop

    #misc
    obs-studio

    # audio
    pavucontrol
    playerctl
    qjackctl

    vlc
  ];
}
