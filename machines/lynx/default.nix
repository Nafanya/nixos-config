{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../hosts/lynx/hass
    ../../hosts/lynx/homebridge.nix
    ../../hosts/lynx/jellyfin.nix
    ../../hosts/lynx/nginx.nix
    ../../hosts/lynx/vim.nix

    #### NEW defs ####
    inputs.sops-nix.nixosModules.sops

    inputs.self.nixosModules.roles.minimal

    ./hardware-configuration.nix
    ./mounts.nix
  ];

  sops.defaultSopsFile = ../../hosts/lynx/secrets.yaml;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  console.keyMap = "us";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBD/7H19xdHEMBJDQp2FWtgUduTx6ZW6xghZJsQEpU6O nikita.yaschenko@gmail.com"
  ];

  environment.systemPackages = with pkgs; [
    wget
    neovim
    tmux
    htop
    bmon
    git
    dnsmasq
    bat
    vlc
  ];

  programs.zsh.enable = true;

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
  };

  system.stateVersion = "22.11";
}
