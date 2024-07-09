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
    ./modules/i3.nix

    ./modules/virtualisation.nix
    ./modules/homebridge.nix

    ./modules/steam.nix
    ./modules/openrgb.nix
    ./modules/openrazer.nix
    ./modules/gamemode.nix
    ./modules/mtp.nix

    ./modules/samba.nix

    ./modules/avahi
  ];

  networking.hostName = "pc";

  programs.droidcam.enable = true;

  services.usbmuxd.enable = true;

  services.logind = {
    powerKey = "suspend";
  };
}
