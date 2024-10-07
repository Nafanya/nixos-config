{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./minimal.nix ];

  documentation.man.generateCaches = lib.mkDefault true;
}
