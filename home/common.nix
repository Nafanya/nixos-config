{ config, lib, pkgs, ... }: {
  home.stateVersion = "23.11";
  home.username = lib.mkDefault "nikita";
  home.homeDirectory = lib.mkDefault "/home/nikita";

  programs.home-manager.enable = true;
}
