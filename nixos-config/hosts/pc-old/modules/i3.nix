{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    mpv
    xscreensaver
  ];
}
