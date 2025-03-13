{ config, pkgs, ... }:
{
  home-manager.users.nikita = {
    home.packages = with pkgs; [
      aria2
      btop
      file
      fzf # TODO: use hm option?
      neofetch
      rclone
      tree
      unzip
      wget
      which
      zip

      # nix
      home-manager
      sops
      nvd # TODO: move to "nix dev shell"
      deploy-rs

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
      helvum

      # video editor
      kdePackages.kdenlive

      # video player
      vlc
      streamlink
    ];
  };
}
