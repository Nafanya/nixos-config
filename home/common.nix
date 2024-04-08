{ config, lib, pkgs, ... }: {

  imports = [
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/zsh.nix
  ];

  home.stateVersion = "23.11";
  home.username = lib.mkDefault "nikita";
  home.homeDirectory = lib.mkDefault "/home/nikita";

  programs.home-manager.enable = true;
}
