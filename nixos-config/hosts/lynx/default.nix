{
  config,
  pkgs,
  lib,
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.nixos-hardware.nixosModules.common-pc-laptop
    flake-inputs.nixos-hardware.nixosModules.common-pc-laptop-hdd
    flake-inputs.nixos-hardware.nixosModules.common-cpu-intel

    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
