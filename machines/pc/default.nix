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
    inputs.self.nixosModules.profiles.openrgb

    inputs.self.nixosModules.profiles.server.syncthing
    inputs.self.nixosModules.profiles.server.nfs

    {
      nixpkgs.overlays = [
        inputs.nix-minecraft.overlay

        (self: super: {
          linux-firmware = super.linux-firmware.overrideAttrs (oldAttrs: {
            version = "4308879ea4fae7b02bdc802593d9ae3a48d38424";
            src = self.fetchzip {
              url = "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/linux-firmware-${self.linux-firmware.version}.tar.gz";
              hash = "sha256-vVlKvskfMf/hzCrDBISritGfhjyBwNOhBBM5Bf7yjGY=";
            };
          });
        })

      ];
    }

    ./hardware-configuration.nix
    ./gpu.nix
    ./pci-passthrough.nix
    ./networking.nix
    ./disks.nix
    ./ssh-hosts.nix
    ./virtualisation.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
  };

  system.stateVersion = "24.05";
}
