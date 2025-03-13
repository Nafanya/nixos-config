{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ steamcmd ];

  hardware.xone.enable = true;
  hardware.steam-hardware.enable = true;

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      extraPackages = with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        gamemode
      ];
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
