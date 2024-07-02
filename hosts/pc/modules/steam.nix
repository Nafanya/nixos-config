{ config, pkgs, ... }: {

  programs.steam = {
    enable = true;
    remotePlay = { openFirewall = true; };
    gamescopeSession.enable = true;
  };

  hardware.steam-hardware.enable = true;

  programs.gamescope.enable = true;
}
