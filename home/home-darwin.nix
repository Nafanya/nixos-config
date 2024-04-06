{ config, lib, pkgs, ... }:
{

  home.stateVersion = "23.11";
  home.username = lib.mkDefault "nikita";
  home.homeDirectory = lib.mkDefault "/Users/nikita";

  programs.home-manager.enable = true;
}

