{ config, pkgs, ... }:
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      domain = "https://bitwarden.nikitoci.com";
      signupsAllowed = false;
      websocketEnable = true;
    };
  };

  services.nginx = {
    virtualHosts."bitwarden.nikitoci.com" = {
      useACMEHost = "nikitoci.com";
      onlySSL = true;
      extraConfig = ''
        client_max_body_size 128M;
        add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload' always;
      '';
      locations."/" = {
        recommendedProxySettings = true;
        proxyPass = "http://localhost:8000";
        proxyWebsockets = true;
      };
    };
  };
}
