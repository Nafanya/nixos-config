{ config, pkgs, ... }:

{
  users.users.steam = {
    isNormalUser = true;
    description = "Steam runner";
    packages = with pkgs; [ steam steamcmd ];
  };

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };
}
