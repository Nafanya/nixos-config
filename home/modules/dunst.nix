{ pkgs, ... }: {
  services.dunst = { enable = true && pkgs.stdenv.isLinux; };
}
