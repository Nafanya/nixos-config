{ config, pkgs, lib, ... }: {
  imports = [ ./browsers.nix ./common.nix ];

  #TODO: move to submodules
  programs.git = {
    enable = true;
    userName = "Nikita Iashchenko";
    userEmail = "nikita.yaschenko@gmail.com";
    diff-so-fancy = {
      enable = true;
      pagerOpts = [ "--tabs=4" "-R" ];
    };
  };

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

  # kitty -- a cross-platform, GPU-accelerated terminal emulator
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_family = "monospace";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "14.0";

      repaint_delay = "8";
      input_delay = "0";
      sync_to_monitor = "no";
    };
  };

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
