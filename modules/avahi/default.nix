{ config, lib, pkgs, ... }: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
    extraServiceFiles = { jellyfin = ./jellyfin.service; };
  };
}
