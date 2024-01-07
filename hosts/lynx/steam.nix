{ config, pkgs, ... }:

{
  users.users.steam = {
    isNormalUser = true;
    description = "Steam runner";
    packages = with pkgs; [ steam ];
  };

  #programs.steam = {
  #  enable = true;
  #  dedicatedServer.openFirewall = true;
  #};
}
