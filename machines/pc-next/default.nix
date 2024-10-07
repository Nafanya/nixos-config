{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    #    inputs.home-manager.nixosModules.home-manager
    #    inputs.sops-nix.nixosModules.sops

    ### NEW
    #inputs.self.nixosModules.roles.minimal

    #./hardware-configuration.nix
    #./mounts.nix

    ../../nixos-config
    ../../nixos-config/hosts/pc
  ];

  system.stateVersion = "24.05";
}