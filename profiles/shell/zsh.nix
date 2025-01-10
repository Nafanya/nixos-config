{ ... }:
{
  home-manager.users.nikita = {
    programs.bat.enable = true;

    programs.ripgrep.enable = true;

    programs.zsh = {
      enable = true;

      history = {
        size = 100000;
        save = 100000;
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "agnoster";
      };
    };
  };
}
