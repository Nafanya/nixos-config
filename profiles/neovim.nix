{ pkgs, ... }:
{
  home-manager.users.nikita = {
    programs.neovim = {
      defaultEditor = true;
      enable = true;
      vimAlias = true;
      viAlias = true;
    };
  };
}
