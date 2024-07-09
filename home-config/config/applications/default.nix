{ config, pkgs, ... }:
{
  imports = [
    ./emacs.nix
    ./firefox.nix
    ./kitty.nix
    ./neovim.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    # add here
  ];
}
