{ config, pkgs, ... }:
{
  hardware.openrazer = {
    enable = true;
    batteryNotifier = {
      enable = true;
      frequency = 30 * 60; # every 30m
      percentage = 20;
    };
    users = [ config.users.users.nikita.name ];
  };

  home-manager.users.nikita.home.packages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
}
