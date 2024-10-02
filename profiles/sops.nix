{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
}
