{ config, lib, ... }: {

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx.commonHttpConfig = ''
    add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload' always;
  '';

  sops.secrets.hetzner-api-credentials.owner = "nginx";

  security.acme.certs = {
    "nikitoci.com" = {
      domain = "nikitoci.com";
      postRun = "systemctl reload nginx.service";
      group = "nginx";
      dnsProvider = "hetzner";
      credentialsFile = config.sops.secrets.hetzner-api-credentials.path;
    };
  };
}
