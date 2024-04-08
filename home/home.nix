{ config, lib, pkgs, ... }:
let
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in {

  imports = [
    ./modules/emacs.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/zsh.nix

    ./packages.nix
  ];

  home.stateVersion = "23.11";
  home.username = lib.mkDefault "nikita";
  home.homeDirectory =
    lib.mkDefault (if isLinux then "/home/nikita" else "/Users/nikita");

  programs.home-manager.enable = true;
}
