{
  config,
  pkgs,
  lib,
  flake-inputs,
  ...
}:
{
  home-manager.users.nikita = import "${flake-inputs.self}/home-config/hosts/pc.nix";
}
