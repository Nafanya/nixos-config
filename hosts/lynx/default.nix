# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # My configs
    ./vim.nix

    ./steam.nix
  ];

  # DDC to control monitor via ddcutil
  hardware.i2c.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "lynx"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

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
    isNormalUser = true;
    description = "Nikita Iashchenko";
    extraGroups = [ "networkmanager" "wheel" "i2c" ];
    packages = with pkgs; [ zsh ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEG/p7bL2u2cNo+8eGd/Wd5XVw61066si+e7GKmXOYPU nikita.yaschenko@gmail.com"
      "ssh-ed25519 LHS4reXkb9fI7vmrKliH0uWIWx2jCA0c71ewhdJ0a0I nikita.yaschenko+win@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBD/7H19xdHEMBJDQp2FWtgUduTx6ZW6xghZJsQEpU6O nikita.yaschenko@gmail.com"
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    ddcutil
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

  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    domain-needed
    bogus-priv
    no-resolv

    server=192.168.1.1
    #server=8.8.4.4
    #server=1.1.1.1

    listen-address=::1
    listen-address=127.0.0.1
    listen-address=192.168.1.250
    listen-address=192.168.1.251

    log-queries
    log-facility=/etc/nixos/.persist/dnsmasq/ad-block.log
    cache-size=10000
    local-ttl=300

    conf-file=/etc/nixos/.persist/dnsmasq/dnsmasq.blacklist.txt
    #conf-file=/etc/nixos/.persist/dnsmasq/domains.txt
    #addn-hosts=/etc/nixos/.persist/dnsmasq/hostnames.txt
  '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  services.blueman.enable = true;

  # Home theater
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      # Components required to complete the onboarding
      "met"
      "radio_browser"
    ];
    extraPackages = python3Packages: with python3Packages; [ securetar ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
    53
    8123 # jellyfin
  ];
  networking.firewall.allowedUDPPorts = [ 53 ];
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
