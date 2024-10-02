{ pkgs, flake-inputs, ... }:
{

  environment.systemPackages = with pkgs; [ mangohud ];

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
  users.users.nikita.extraGroups = [ "gamemode" ];

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
      ];
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
