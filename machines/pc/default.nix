{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-amd

    inputs.self.nixosModules.roles.desktop

    inputs.self.nixosModules.profiles.games.steam
    inputs.self.nixosModules.profiles.games.gamemode
    inputs.self.nixosModules.profiles.games.openrazer
    inputs.self.nixosModules.profiles.games.minecraft

    inputs.zwift.nixosModules.zwift

    inputs.self.nixosModules.profiles.server.syncthing
    inputs.self.nixosModules.profiles.server.nfs

    inputs.self.nixosModules.profiles.local-llm

    inputs.self.nixosModules.profiles.rust

    {
      nixpkgs.overlays = [
        inputs.nix-minecraft.overlay
      ];
    }

    ./hardware-configuration.nix
    ./gpu.nix
    #./pci-passthrough.nix
    ./networking.nix
    ./disks.nix
    ./ssh-hosts.nix
    ./virtualisation.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 25;
      };
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
  };

  programs.zwift.enable = true;

  system.stateVersion = "24.05";
}
