{ config, pkgs, ... }:
{

  xdg.configFile = {
    "i3/config".source = ./config;
    "i3/assignments.conf".source = ./assignments.conf;
    "i3status/config".source = ./i3status.conf;
  };
}
