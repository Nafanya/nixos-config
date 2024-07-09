{ config, pkgs, ... }:
{

  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      domain = "https://bitwarden.lynx.local";
      websocketEnable = true;
    };
  };

  networking.firewall.allowedTCPPorts = [
    8000
    8001
  ];

  services.nginx = {
    virtualHosts."bitwarden.lynx.local" = {
      onlySSL = true;
      enableACME = true;
      #listen = [{
      #  addr = "0.0.0.0";
      #  port = 443;
      #  ssl = true;
      #}];
      locations."/" = {
        recommendedProxySettings = true;
        proxyPass = "http://localhost:8000";
        proxyWebsockets = true;
      };
    };
  };
}
