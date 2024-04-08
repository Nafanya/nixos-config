{ config, pkgs, lib, ... }: {
  imports = [ ./browsers.nix ./common.nix ];

  services.easyeffects.enable = true;

  services.dunst = { enable = true; };
}
