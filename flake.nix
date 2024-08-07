{
  description = "Nikita's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs.url = "github:serokell/deploy-rs";

    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      nix-darwin,
      home-manager,
      deploy-rs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        refactored-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos-config
            ./nixos-config/hosts/pc
          ];

          specialArgs.flake-inputs = inputs;
        };

        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/pc

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.users.nikita = import ./home/home.nix;
            }

            sops-nix.nixosModules.sops
          ];
          specialArgs.flake-inputs = inputs;
        };
        lynx = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/lynx
            sops-nix.nixosModules.sops
          ];
          specialArgs = {
            inherit inputs;
          };
        };
        nihonzaru = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/nihonzaru
            sops-nix.nixosModules.sops
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      };
      darwinConfigurations = {
        leopard = nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            {
              nixpkgs.overlays = [ inputs.nixpkgs-firefox-darwin.overlay ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.users.nikita = import ./home/home.nix;
            }
            ./hosts/darwin
            ./hosts/darwin/leopard
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      };

      deploy.nodes = {
        lynx = {
          hostname = "192.168.1.250";
          profiles.system = {
            user = "root";
            sshUser = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.lynx;
          };
          fastConnection = true;
        };
        nihonzaru = {
          hostname = "nihonzaru";
          profiles.system = {
            user = "root";
            sshUser = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nihonzaru;
          };
          fastConnection = true;
        };
      };

      # This is highly advised, and will prevent many possible mistakes
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
