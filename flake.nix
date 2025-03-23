{
  description = "Nikita's NixOS Flake";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs.url = "github:serokell/deploy-rs";

    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    lact-pr.url = "github:cything/nixpkgs?ref=lact";
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      nix-darwin,
      home-manager,
      deploy-rs,
      nix-minecraft,
      lact-pr,
      ...
    }@inputs:
    let
      # Recursively scans a directory `dir` and finds *.nix files
      # which are "profiles", "roles" or "modules".
      findModules =
        dir:
        builtins.concatLists (
          builtins.attrValues (
            builtins.mapAttrs (
              name: type:
              if type == "regular" then
                [
                  {
                    name = builtins.elemAt (builtins.match "(.*)\\.nix" name) 0;
                    value = dir + "/${name}";
                  }
                ]
              else if (builtins.readDir (dir + "/${name}")) ? "default.nix" then
                [
                  {
                    inherit name;
                    value = dir + "/${name}";
                  }
                ]
              else
                [
                  {
                    inherit name;
                    value = builtins.listToAttrs (findModules (dir + "/${name}"));
                  }
                ]
            ) (builtins.readDir dir)
          )
        );
    in
    rec {
      nixosModules.profiles = builtins.listToAttrs (findModules ./profiles);
      nixosModules.roles = builtins.listToAttrs (findModules ./roles);
      nixosModules.modules = builtins.listToAttrs (findModules ./modules);

      nixosConfigurations =
        with nixpkgs.lib;
        let
          hosts = debug.traceVal (builtins.attrNames (builtins.readDir ./machines));
          mkHost =
            name:
            let
              system = builtins.readFile (./machines + "/${name}/system.txt");
            in
            nixosSystem {
              inherit system;
              modules = [
                (import (./machines + "/${name}"))
                { networking.hostName = mkDefault name; }
              ];
              specialArgs = {
                inherit inputs;
                flake-inputs = inputs;
              };
            };
        in
        genAttrs hosts mkHost;
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
          hostname = "lynx-root";
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
