{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ steamcmd ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      #      extraPackages = with pkgs; [
      #        xorg.libXcursor
      #        xorg.libXi
      #        xorg.libXinerama
      #        xorg.libXScrnSaver
      #        libpng
      #        libpulseaudio
      #        libvorbis
      #        stdenv.cc.cc.lib
      #        libkrb5
      #        keyutils
      #      ];
    };
  };

  # networking.firewall.allowedTCPPorts = [
  #   28852
  #   8075
  # ];
  # networking.firewall.allowedUDPPorts = [
  #   7707
  #   7708
  #   7717
  #   20560
  # ];
}
