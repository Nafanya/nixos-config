{ config, pkgs, ... }:
{
  imports = [ ./zsh-config.nix ];

  home.packages = with pkgs; [
    bat
    ripgrep
  ];

  programs = {
    ssh.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
      userName = "Nikita Iashchenko";

      extraConfig = {
        submodule.recurse = "true";
      };
    };
  };
}
