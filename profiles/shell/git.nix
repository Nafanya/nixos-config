{ ... }:
{
  home-manager.users.nikita = {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        user = {
          name = "Nikita Iashchenko";
          email = "nikita.yaschenko@gmail.com";
        };

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

    programs.diff-so-fancy = {
      enable = true;
      enableGitIntegration = true;
      pagerOpts = [
        "--tabs=4"
        "-R"
      ];
    };
  };
}
