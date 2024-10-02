{ config, pkgs, ... }:
{

  xdg.configFile = {
    "mpv/mpv.conf".source = ./mpv.conf;
    "mpv/fsr.glsl".source = ./fsr.glsl;
  };

  programs.mpv = {
    enable = true;
  };
}
