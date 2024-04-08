{ config, lib, pkgs, ... }: {

  imports = [ ./common.nix ];

  home.homeDirectory = lib.mkForce "/Users/nikita";
}
