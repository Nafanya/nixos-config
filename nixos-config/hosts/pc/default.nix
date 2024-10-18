{
  config,
  pkgs,
  lib,
  flake-inputs,
  ...
}:
{
  imports = [
    ./disks.nix

    ./openrazer.nix
    ./openrgb.nix
  ];

  home-manager.users.nikita = import "${flake-inputs.self}/home-config/hosts/pc.nix";
}
