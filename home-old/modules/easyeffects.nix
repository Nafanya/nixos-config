{ pkgs, ... }:
{
  services.easyeffects.enable = true && pkgs.stdenv.isLinux;
}
