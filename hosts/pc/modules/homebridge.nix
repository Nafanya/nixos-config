{ config, lib, pkgs, ... }: {

  virtualisation.oci-containers.containers = {
    homebridge = {
      image = "homebridge/homebridge:latest";
      volumes =
        [ "${config.users.users.nikita.home}/.volumes/homebridge:/homebridge" ];
      ports = [ "8581:8581" ];
      extraOptions = [ "--network=host" ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    8581 # homebridge UI
    51154 # main bridge
    38576 # tapo plugs bridge
    37328 # govee bridge
    4001
    4002
    4003 # govee lan api
  ];
  networking.firewall.allowedUDPPorts = [
    5353 # ? or avahi?
    51154 # main brigge
    38576 # tapo plugs bridge
    37328 # govee bridge
    4001
    4002
    4003 # govee lan api
  ];
}
