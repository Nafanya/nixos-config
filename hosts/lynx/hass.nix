{ config, lib, pkgs, ... }: {

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      # Components required to complete the onboarding
      "met"
      "radio_browser"
    ];
    extraPackages = python3Packages: with python3Packages; [ securetar ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };
      http = {
        server_host = "::1";
        trusted_proxies = [ "::1" ];
        use_x_forwarded_for = true;
      };
    };
  };

  services.nginx = {
    virtualHosts."hass.local" = {
      locations."/" = {
        proxyPass = "http://[::1]:8123";
        extraConfig = ''
          proxy_buffering off;
        '';
      };
    };
  };
}
