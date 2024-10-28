{ ... }:
{
  home-manager.users.nikita = {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = "Nikita Iashchenko";
      userEmail = "nikita.yaschenko@gmail.com";

      extraConfig = {
        submodule.recurse = "true";
      };
    };
  };
}
