{ config, pkgs, lib, ... }: {
  imports = [ ./browsers.nix ./common.nix ];

  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };
  };

  services.easyeffects.enable = true;

  services.dunst = { enable = true; };
}
