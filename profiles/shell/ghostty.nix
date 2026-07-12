{ config, pkgs, ... }:
{
  home-manager.users.nikita = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
