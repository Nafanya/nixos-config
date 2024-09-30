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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Wayland + sway
  programs.sway.enable = true;

  programs.firefox.enable = true;

  # Configure console keymap
  console.keyMap = "us";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBD/7H19xdHEMBJDQp2FWtgUduTx6ZW6xghZJsQEpU6O nikita.yaschenko@gmail.com"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.zsh.enable = true;

  # List services that you want to enable:

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
  };

  ##services.dnsmasq.enable = true;
  ##services.dnsmasq.extraConfig = ''
  ##  domain-needed
  ##  bogus-priv
  ##  no-resolv

  ##  server=192.168.1.1
  ##  #server=8.8.4.4
  ##  #server=1.1.1.1

  ##  listen-address=::1
  ##  listen-address=127.0.0.1
  ##  listen-address=192.168.1.250
  ##  listen-address=192.168.1.251

  ##  log-queries
  ##  log-facility=/etc/nixos/.persist/dnsmasq/ad-block.log
  ##  cache-size=10000
  ##  local-ttl=300

  ##  conf-file=/etc/nixos/.persist/dnsmasq/dnsmasq.blacklist.txt
  ##  #conf-file=/etc/nixos/.persist/dnsmasq/domains.txt
  ##  #addn-hosts=/etc/nixos/.persist/dnsmasq/hostnames.txt
  ##'';

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
