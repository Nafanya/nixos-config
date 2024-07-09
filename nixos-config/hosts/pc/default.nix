{
  config,
  pkgs,
  lib,
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.nixos-hardware.nixosModules.common-pc
    flake-inputs.nixos-hardware.nixosModules.common-pc-ssd
    flake-inputs.nixos-hardware.nixosModules.common-cpu-intel
    flake-inputs.nixos-hardware.nixosModules.common-gpu-amd

    ./hardware-configuration.nix
    ./games.nix
    ./networking.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
