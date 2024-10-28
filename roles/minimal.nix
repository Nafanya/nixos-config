{ inputs, lib, ... }:
{
  imports = (
    with inputs.self.nixosModules.profiles;
    [
      locale
      nix
      shell.git
      shell.zsh
      sops
      ssh-server
      timezone
      unfree
      users
    ]
    ++ [ inputs.self.nixosModules.profiles.home-manager ]
  );

  security.polkit.enable = true;
}
