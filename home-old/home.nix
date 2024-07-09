{
  config,
  lib,
  pkgs,
  ...
}:
{

  imports = [
    ./modules/gtk.nix
    ./modules/i3

    ./packages.nix
  ];

  home.username = lib.mkDefault "nikita";
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isLinux then "/home/nikita" else "/Users/nikita"
  );

  programs.home-manager.enable = true;
}
