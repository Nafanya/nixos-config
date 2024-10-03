{ config, pkgs, ... }:
{

  xdg.configFile.mpv.source = ./config;

  programs.mpv = {
    enable = true;
  };
}
