{
  config,
  lib,
  pkgs,
  flake-inputs,
  ...
}:
{
  home.file.".profile".text = ''
    source "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"

    export BROWSER="firefox"

    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_BIN_HOME="$HOME/.local/bin"
    export XDG_LIB_HOME="$HOME/.local/lib"
    export XDG_CACHE_HOME="$HOME/.cache"

    export PATH="$PATH:$HOME/.local/bin"
    export PATH="$PATH:$HOME/.local/usr/bin"

    export VISUAL='emacsclient'
    export EDITOR='emacsclient'
    export ALTERNATE_EDITOR='vim'
    export VTERM='kitty'
  '';

  programs = {
    zsh = {
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
  };
}
