{ config, pkgs, ... }:
{
  imports = [
    ./emacs.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    # add here
  ];
}
