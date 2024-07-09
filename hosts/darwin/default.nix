{
  inputs,
  pkgs,
  lib,
  home-manager,
  ...
}:
{

  # This is "common" stuff for all darwin hosts

  programs.zsh.enable = true;

  # nix-darwin settings below

  users.users.nikita = {
    name = "nikita";
    home = "/Users/nikita";
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-darwin";
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    #    package = pkgs.nixUnstable;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = "auto";
    };
  };

  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
