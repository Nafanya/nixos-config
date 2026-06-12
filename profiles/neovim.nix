{ pkgs, ... }:
{
  home-manager.users.nikita = {
    programs.neovim = {
      defaultEditor = true;
      enable = true;
      vimAlias = true;
      viAlias = true;
      withPython3 = false;
      withRuby = false;
    };
  };
}
