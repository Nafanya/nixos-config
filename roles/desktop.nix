{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports =
    [ ./minimal.nix ]
    ++ (with inputs.self.nixosModules.profiles; [
      fonts
      gui.kde
      sound
    ]);

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
