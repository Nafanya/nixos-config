{ config, lib, pkgs, ... }:
let
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in {

  imports = [
    ./modules/dunst.nix
    ./modules/easyeffects.nix
    ./modules/emacs.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/i3
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/tmux
    ./modules/zsh.nix

    ./packages.nix
  ];

  home.stateVersion = "23.11";
  home.username = lib.mkDefault "nikita";
  home.homeDirectory =
    lib.mkDefault (if isLinux then "/home/nikita" else "/Users/nikita");

  programs.home-manager.enable = true;
}
