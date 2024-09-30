{ inputs, config, ... }:
{
  imports = [
    ../../hosts/lynx
    inputs.sops-nix.nixosModules.sops
  ];

  system.stateVersion = "22.11";
}
