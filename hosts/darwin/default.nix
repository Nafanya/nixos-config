{ inputs, pkgs, lib, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  imports = [ <home-manager/nix-darwin> ];

  home-manager = {
    # Disable using the system configuration’s pkgs argument
    # in hm. This disables the Home Manager options nixpkgs.*.
    useGlobalPkgs = false;

    # Allows installing pkgs from
    # users.users.<name>.packages = [ ... ];
    useUserPkgs = true;

    extraSpecialArgs = { inherit inputs; };

    users.nikita = { config, pkgs, ... }: {
      home.homeDirectory = lib.mkForce "/Users/nikita";

      imports = [
        ../../../home/kitty
        ../../../home/tmux
        ../../../home/emacs
        # >>> Put new stuff here <<<
      ];
    };

    backupFileExtension = "bak";
  };

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = "auto";
    };
  };

  programs.zsh.enable = true;
}
