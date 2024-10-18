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

    ../../nixos-config/hosts/pc
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  system.stateVersion = "24.05";
}
