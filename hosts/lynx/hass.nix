{ config, lib, pkgs, ... }: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      # Components required to complete the onboarding
      "met"
      "radio_browser"
      "homekit"
    ];
    extraPackages = python3Packages: with python3Packages; [ securetar ];
  };

  services.home-assistant.config = {
    # Includes dependencies for a basic setup
    # https://www.home-assistant.io/integrations/default_config/
    default_config = { };
    http = {
      trusted_proxies = [ "::1" "127.0.0.1" ];
      use_x_forwarded_for = true;
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
}
