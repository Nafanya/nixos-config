{ config, lib, pkgs, ... }: {

  imports = [ ./zones.nix ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [ "met" "radio_browser" "homekit" ];
    extraPackages = python3Packages: with python3Packages; [ securetar ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };
      http = {
        trusted_proxies = [ "::1" "127.0.0.1" ];
        use_x_forwarded_for = true;
      };

      homeassistant = {
        name = "Home";
        latitude = "!secret home_latitude";
        longitude = "!secret home_longitude";
        elevation = "!secret home_elevation";
        unit_system = "metric";
        time_zone = "Europe/London";
        country = "GB";
      };

    };
  };

  services.nginx = {
    virtualHosts."hass.local" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8123";
        proxyWebsockets = true;
        recommendedProxySettings = true;
        extraConfig = ''
          proxy_buffering off;
        '';
      };
    };
  };

  sops.secrets."home-assistant-secrets.yaml" = {
    owner = "hass";
    path = "/var/lib/hass/secrets.yaml";
    restartUnits = [ "home-assistant.service" ];
  };
}
