{ config, pkgs, ... }: {

  imports = [ ./programs ./i3 ];

  home = {
    username = "nikita";
    homeDirectory = "/home/nikita";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
