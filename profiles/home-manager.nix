{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.nikita = {
      programs.home-manager.enable = true;

      home = {
        username = "nikita";
        homeDirectory = "/home/nikita";
        # Pinned independently of system.stateVersion: tying them together
        # makes home-manager behave differently per host and silently
        # changes home-manager defaults if the system value is ever bumped.
        stateVersion = "24.05";
      };
    };
  };
}
