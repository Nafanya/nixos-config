{
  inputs,
  config,
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

  system.stateVersion = "24.05";
}
