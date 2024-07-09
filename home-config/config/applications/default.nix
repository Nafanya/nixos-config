{ config, pkgs, ... }:
{
  imports = [
    ./emacs.nix
    ./firefox.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    # add here
  ];
}
