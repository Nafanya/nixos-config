{ inputs, pkgs, lib, ... }: {

  nixpkgs.hostPlatform = lib.mkForce "x86_64-darwin";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    caskArgs = { no_quarantine = true; };
    brews = [ ];
    casks = [ "telegram" ];
  };

  environment.systemPackages = with pkgs; [
    (python311.withPackages (ps: with ps; [ pip requests setuptools ]))
    git-lfs
    wget
    deploy-rs
    tmux
    rsync
    ncdu
    nmap
    ripgrep
    sqlite
    gnupg
    bitwarden-cli
    yt-dlp
    ffmpeg
    mosh
    spotify
    slack
  ];
}
