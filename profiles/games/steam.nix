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
      capSysNice = false;
    };
  };

  # Currently CAP_SYS_NICE doesn't work well with steam FHS
  # Using ananicy intead as temporary fix
  # See https://github.com/NixOS/nixpkgs/issues/351516#issuecomment-2607186592
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };
}
