{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    history = {
      size = 100000;
    };
    shellAliases = {
      update =
        if pkgs.stdenv.hostPlatform.isLinux then
          "sudo nixos-rebuild switch"
        else
          "darwin-rebuild switch --flake ~/nixos-config";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };
}
