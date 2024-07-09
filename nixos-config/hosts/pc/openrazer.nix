{ config, pkgs, ... }:
{
  hardware.openrazer = {
    enable = true;
    batteryNotifier = {
      enable = true;
      frequency = 30 * 60; # every 30m
      percentage = 20;
    };
    users = [ "nikita" ];
  };

  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
}
