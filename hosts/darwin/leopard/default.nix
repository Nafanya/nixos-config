{ inputs, pkgs, lib, ... }: {

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

  services.nix-daemon.enable = lib.mkForce true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
