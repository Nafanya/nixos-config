# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # My configs
    ./hass
    ./jellyfin.nix
    ./nginx.nix
    ./steam.nix
    ./vim.nix
  ];

  sops.defaultSopsFile = ./secrets.yaml;

  # Bootloader.
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Wayland + sway
  programs.sway.enable = true;

  programs.firefox.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nikita = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEG/p7bL2u2cNo+8eGd/Wd5XVw61066si+e7GKmXOYPU nikita.yaschenko@gmail.com"
      "ssh-ed25519 LHS4reXkb9fI7vmrKliH0uWIWx2jCA0c71ewhdJ0a0I nikita.yaschenko+win@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBD/7H19xdHEMBJDQp2FWtgUduTx6ZW6xghZJsQEpU6O nikita.yaschenko@gmail.com"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBD/7H19xdHEMBJDQp2FWtgUduTx6ZW6xghZJsQEpU6O nikita.yaschenko@gmail.com"
  ];
}
