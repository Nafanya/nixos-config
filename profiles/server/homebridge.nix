{ config, ... }:
{

  #TODO: hardening

  services.nginx = {
    virtualHosts."homebridge.local.nikitoci.com" = {
      useACMEHost = "local.nikitoci.com";
      onlySSL = true;

      locations = {
        "/" = {
          proxyPass = "http://127.0.0.1:8581";
          recommendedProxySettings = true;
          extraConfig = ''
            proxy_buffering off;
          '';
        };
      };
    };
  };

  virtualisation.oci-containers.containers = {
    homebridge = {
      image = "homebridge/homebridge:latest";
      volumes = [ "${config.users.users.nikita.home}/.volumes/homebridge:/homebridge" ];
      ports = [
        "8581:8581"
        "51220:51220"
      ];
      extraOptions = [ "--network=host" ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    8581 # homebridge UI
    51220 # main bridge
    38576 # tapo plugs bridge
    37328 # govee bridge
    4001
    4002
    4003 # govee lan api
  ];
  networking.firewall.allowedUDPPorts = [
    5353 # ? or avahi?
    51220 # main brigge
    38576 # tapo plugs bridge
    37328 # govee bridge
    4001
    4002
    4003 # govee lan api
  ];
}
