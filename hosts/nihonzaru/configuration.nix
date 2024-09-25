{
  config,
  inputs,
  pkgs,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect

    ./modules/nginx
    ./modules/acme.nix
    ./modules/vaultwarden.nix
    ./modules/vim.nix
  ];

  sops.defaultSopsFile = ./secrets.yaml;

  programs.git.enable = true;

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking.hostName = "nihonzaru";
  networking.domain = "";

  nix.settings.experimental-features = "nix-command flakes";

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8UNqMGTX8xDs9BZSc/nuRh6NHsgovyeFMh2+OQl63Y"
  ];

  system.stateVersion = "23.11";
}
