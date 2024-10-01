{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../hosts/lynx/secrets.yaml;
  #sops.defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
}
