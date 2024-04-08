{ inputs, pkgs, lib, ... }:
let emacsPackage = pkgs.emacs;
in {
  programs.emacs = {
    enable = true;
    package = emacsPackage;
  };

  services.emacs = {
    enable = true && pkgs.stdenv.isLinux;
    package = emacsPackage;
    client.enable = true;
  };
}
