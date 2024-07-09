{ config, pkgs, ... }:
{
  imports = [
    ./emacs.nix
    ./firefox.nix
    ./kitty.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    # add here
  ];
}
