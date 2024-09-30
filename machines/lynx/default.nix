{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../hosts/lynx/hardware-configuration.nix
    ../../hosts/lynx/hass
    ../../hosts/lynx/homebridge.nix
    ../../hosts/lynx/jellyfin.nix
    ../../hosts/lynx/nginx.nix
    ../../hosts/lynx/steam.nix
    ../../hosts/lynx/vim.nix

    #### NEW defs ####
    inputs.sops-nix.nixosModules.sops

    inputs.self.nixosModules.roles.minimal
  ];

  sops.defaultSopsFile = ../../hosts/lynx/secrets.yaml;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  programs.sway.enable = true;

  programs.firefox.enable = true;

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

  # List services that you want to enable:

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
  };

  services.openssh.enable = true;

  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  system.stateVersion = "22.11";
}
