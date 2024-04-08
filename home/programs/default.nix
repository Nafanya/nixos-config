{ config, pkgs, lib, ... }: {
  imports = [ ./browsers.nix ./common.nix ];

  programs.neovim = {
    defaultEditor = true;
    enable = true;
    vimAlias = true;
    plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
  };

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

  programs.zsh = {
    enable = true;
    history = { size = 100000; };
    shellAliases = { update = "sudo nixos-rebuild switch"; };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };
}
