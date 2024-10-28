{ config, pkgs, ... }:
{
  users = {
    users = {
      nikita = {
        isNormalUser = true;
        description = "Nikita Iashchenko";
        extraGroups = [ "wheel" ];

        shell = pkgs.zsh;

        # Why forcing uid? Because if whole system is
        # reinstalled, users are not guaranteed to map
        # to their previous `uid`s and file permissions
        # would ceratinly mess up.
        #
        # This mapping is stored in /var/lib/nixos but
        # if it's not backed up, mapping is lost.
        uid = 1000;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0rNQhiU4hXq45bbQk6H0RqGZ1cMTuMc5a3yGpfnTkP nikita.yaschenko@gmail.com"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBD/7H19xdHEMBJDQp2FWtgUduTx6ZW6xghZJsQEpU6O nikita.yaschenko@gmail.com"
        ];
      };
    };
  };
}
