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
    ./networking.nix
  ];

  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  programs.ssh.startAgent = true;

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
  };
}
