{ inputs, pkgs, lib, ... }: {

  #TODO: maybe better to use brew or overlay version?
  # Currently have sporadic flickers with this emacs29
  services.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };

}
