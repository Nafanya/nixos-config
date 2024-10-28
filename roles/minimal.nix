{ inputs, lib, ... }:
{
  imports = (
    with inputs.self.nixosModules.profiles;
    [
      locale
      neovim
      nix
      shell.git
      shell.kitty
      shell.tmux
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
