{
  description = "Nikita's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, sops-nix, nix-darwin, home-manager, ... }: {
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

          sops-nix.nixosModules.sops
        ];
        specialArgs = { inherit inputs; };
      };
      lynx = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/lynx sops-nix.nixosModules.sops ];
        specialArgs = { inherit inputs; };
      };
      nihonzaru = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/nihonzaru sops-nix.nixosModules.sops ];
        specialArgs = { inherit inputs; };
      };
    };
    darwinConfigurations = {
      leopard = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/darwin
          ./hosts/darwin/leopard
        ];
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

        imports = [ ./hosts/lynx sops-nix.nixosModules.sops ];
      };

      nihonzaru = { name, nodes, ... }: {
        deployment.targetHost = "167.235.29.144";
        deployment.targetUser = "root";

        imports = [ ./hosts/nihonzaru sops-nix.nixosModules.sops ];
      };
    };
  };
}
