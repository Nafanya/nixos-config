{ config, pkgs, ... }:
{
  home-manager.users.nikita = {
    home.packages = with pkgs; [
      aria2
      btop
      file
      fzf # TODO: use hm option?
      rclone
      tree
      unzip
      wget
      which
      zip

      wl-clipboard

      # nix
      home-manager
      sops
      nvd # TODO: move to "nix dev shell"
      deploy-rs
      nix-output-monitor

      #misc
      ffmpeg
      spotify
      instaloader
      yt-dlp
      obsidian

      # system tools
      ethtool
      iotop
      lm_sensors # for `sensors`
      pciutils # for `lspci`
      sysstat
      usbutils # for `lsusb`
      nvtopPackages.amd
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

      # video editor
      kdePackages.kdenlive
      davinci-resolve

      # video player
      vlc
      # streamlink # fails to build 2026-07-08
    ];
  };
}
