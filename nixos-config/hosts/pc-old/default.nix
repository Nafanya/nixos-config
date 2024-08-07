# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  flake-inputs,
  ...
}:

{
  imports = [
    ./modules/system.nix

    ./modules/virtualisation.nix
    ./modules/homebridge.nix

    ./modules/mtp.nix

    ./modules/samba.nix

    ./modules/avahi
  ];
}
