{ config, pkgs, ... }: {

  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      domain = "https://bitwarden.nikitoci.com";
      signupsAllowed = false;
      websocketEnable = true;
    };
  };

  #networking.firewall.allowedTCPPorts = [ 8000 8001 ];

  services.nginx = {

    virtualHosts."bitwarden.nikitoci.com" = {
      useACMEHost = "bitwarden.nikitoci.com";
      extraConfig = ''
        client_max_body_size 128M;
      '';
      onlySSL = true;
      locations."/" = {
        recommendedProxySettings = true;
        proxyPass = "http://localhost:8000";
        proxyWebsockets = true;
      };
    };
  };

}
