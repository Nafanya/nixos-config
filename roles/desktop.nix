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
        mpv
        obs
      ]
      ++ (with gui; [ kde ])
      ++ [
        fonts
        sound

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
