{ config, lib, pkgs, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in {

  imports = [
    ./modules/emacs.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/zsh.nix

    (import ./packages.nix { inherit isLinux isDarwin; })
  ];

  home.stateVersion = "23.11";
  home.username = lib.mkDefault "nikita";
  home.homeDirectory =
    lib.mkDefault (if isLinux then "/home/nikita" else "/Users/nikita");

  programs.home-manager.enable = true;
}
