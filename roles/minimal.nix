{ inputs, lib, ... }:
{
  imports = (
    with inputs.self.nixosModules.profiles;
    [
      locale
      nix
      timezone
      unfree
      users
    ]
  );

  security.polkit.enable = true;
}
