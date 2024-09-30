{ inputs, lib, ... }:
{
  imports = (
    with inputs.self.nixosModules.profiles;
    [
      locale
      nix
      timezone
      users
    ]
  );

  security.polkit.enable = true;
}
