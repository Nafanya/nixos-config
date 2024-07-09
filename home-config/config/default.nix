{ flake-inputs, lib, ... }:
{
  imports = [ ];

  options._dotfiles = lib.mkOption {
    type = lib.types.str;
    default = "${flake-inputs.self}/home-config/dotfiles";
    description = "Path to the dotfiles in this repository";
  };

  config.home.stateVersion = "23.11";
}
