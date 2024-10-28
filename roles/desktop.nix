{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports =
    [ ./minimal.nix ]
    ++ (
      with inputs.self.nixosModules.profiles;
      with apps;
      [
        firefox
        mpv
        obs

        misc-apps
      ]
      ++ (with gui; [ kde ])
      ++ [
        fonts
        sound
        easyeffects

        shell.emacs
      ]
    );

  programs = {
    dconf.enable = true;
    git.enable = true;
    htop.enable = true;
    neovim = {
      enable = true;
      vimAlias = true;
    };
    nano.enable = false;
    zsh.enable = true;
  };
}
