{ config, pkgs, ... }: {

  programs.steam = {
    enable = true;
    remotePlay = { openFirewall = true; };
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
    ];
  };

  hardware.steam-hardware.enable = true;

  programs.gamescope.enable = true;
}
