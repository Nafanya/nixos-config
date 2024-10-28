{ ... }:
{
  home-manager.users.nikita = {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = "Nikita Iashchenko";
      userEmail = "nikita.yaschenko@gmail.com";

      diff-so-fancy = {
        enable = true;
        pagerOpts = [
          "--tabs=4"
          "-R"
        ];
      };
      extraConfig = {
        submodule.recurse = "true";

        github.user = "nafanya";
      };
    };
  };
}
