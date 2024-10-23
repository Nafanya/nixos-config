{ config, pkgs, ... }:
{
  imports = [
    ./emacs.nix
    ./firefox.nix
    ./kitty.nix
    ./neovim.nix
    ./obs.nix
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

    # mtp
    #> jmtpfs -- didn't work well on KDE
    simple-mtpfs

    # im
    discord
    telegram-desktop

    # audio
    pavucontrol
    playerctl
    qjackctl

    vlc
  ];
}
