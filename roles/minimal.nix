{ inputs, lib, ... }:
{
  imports = (
    with inputs.self.nixosModules.profiles;
    [
      locale
      timezone
      users
    ]
  );

  security.polkit.enable = true;
}
