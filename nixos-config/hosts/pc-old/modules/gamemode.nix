{ config, pkgs, ... }:
{

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
}
