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
    flake-inputs.nixos-hardware.nixosModules.common-gpu-nvidia-disable

    ./hardware-configuration.nix
    ./gpu.nix
    ./games.nix
    ./networking.nix
    ./disks.nix

    ./openrazer.nix
    ./openrgb.nix
  ];

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "en_GB.UTF-8";

  home-manager.users.nikita = import "${flake-inputs.self}/home-config/hosts/pc.nix";

  #TODO: maybe there's a better place for everything below
  programs.droidcam.enable = true;

  services.usbmuxd.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  programs.ssh.startAgent = true;
}
