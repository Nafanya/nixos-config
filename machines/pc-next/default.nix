{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.self.nixosModules.roles.desktop

    #./hardware-configuration.nix
    #./mounts.nix

    ../../nixos-config
    ../../nixos-config/hosts/pc
  ];

  #TODO: make true when done refactoring
  documentation.man.generateCaches = lib.mkForce false;

  system.stateVersion = "24.05";
}
