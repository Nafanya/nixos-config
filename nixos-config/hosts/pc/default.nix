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
    ./gpu.nix
    ./games.nix
    ./networking.nix
    ./smart.nix

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = lib.mkForce "24.05"; # Did yo read the comment?
}
