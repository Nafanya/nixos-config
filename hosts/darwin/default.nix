{ inputs, pkgs, lib, home-manager, ... }: {

  # This is "common" stuff for all darwin hosts

  # Common hm stuff goes here
  #inputs.home-manager.darwinModules.home-manager = {
  #  useGlobalPkgs = true;
  #  useUserPkgs = true;

  #  extraSpecialArgs = { inherit inputs; };

  #  users.nikita = { config, pkgs, ... }: {
  #    home.homeDirectory = lib.mkForce "/Users/nikita";

  #    imports = [
  #      ../../../home/kitty
  #      ../../../home/tmux
  #      ../../../home/emacs
  #      # >>> Put new stuff here <<<
  #    ];
  #  };

  #  backupFileExtension = "bak";
  #};

  programs.zsh.enable = true;

  # nix-darwin settings below

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-darwin";
    config = { allowUnfree = true; };
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
