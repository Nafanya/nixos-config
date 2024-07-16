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

  networking.hostName = "lynx"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Wayland + sway
  programs.sway.enable = true;

  programs.firefox.enable = true;

  # Configure console keymap
  console.keyMap = "us";

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    tmux
    htop
    bmon
    dnsmasq
    bat
    vlc
  ];

  # List services that you want to enable:

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
