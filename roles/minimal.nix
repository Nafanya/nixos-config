{ inputs, lib, ... }:
{
  imports = (
    with inputs.self.nixosModules.profiles;
    [
      locale
      nix
      sops
      ssh-server
      timezone
      unfree
      users
    ]
  );

  security.polkit.enable = true;
}
