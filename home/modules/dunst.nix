{ pkgs, ... }: { services.dunst = { enable = false && pkgs.stdenv.isLinux; }; }
