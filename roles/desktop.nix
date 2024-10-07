{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./minimal.nix ] ++ [ inputs.self.nixosModules.profiles.home-manager ];

  documentation.man.generateCaches = lib.mkDefault true;
}
