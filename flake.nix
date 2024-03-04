{
  description = "Nikita's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }: {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/pc

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nikita = import ./home;
          }
        ];
      };
      lynx = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/lynx ];
      };
      nihonzaru = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/nihonzaru ];
      };
    };
    darwinConfigurations = {
      leopard = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [ ./hosts/leopard ];
        specialArgs = { inherit inputs; };
      };
    };
    #darwinPackages = self.darwinConfigurations.leopard.pkgs;
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
          specialArgs = { inherit nixpkgs; };
        };
      };

      lynx = { name, nodes, ... }: {
        deployment.targetHost = "lynx.local";
        deployment.targetUser = "root";

        imports = [ ./hosts/lynx ];
      };

      nihonzaru = { name, nodes, ... }: {
        deployment.targetHost = "167.235.29.144";
        deployment.targetUser = "root";

        imports = [ ./hosts/nihonzaru ];
      };
    };
  };
}
