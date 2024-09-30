{ inputs, lib, ... }:
{
  imports = (
    with inputs.self.nixosModules.profiles;
    [
      locale
      timezone
    ]
  );

  security.polkit.enable = true;
}
