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

        column.ui = "auto";
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };
        push = {
          default = "simple";
          autoSetupRemote = true;
          followTags = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };
      };
    };
  };
}
