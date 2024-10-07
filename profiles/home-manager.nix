{ config, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModule ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.nikita = {
      programs.home-manager.enable = true;

      home = {
        username = "nikita";
        homeDirectory = "/home/nikita";
        stateVersion = "23.11";
      };
    };
  };
}
