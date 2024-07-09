{ config, lib, ... }:
{

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.nginx.commonHttpConfig = ''
    add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload' always;
  '';

  # File format:
  #
  sops.secrets.hetzner-api-credentials = {
    owner = "nginx";
  };

  security.acme.certs = {
    "bitwarden.nikitoci.com" = {
      domain = "bitwarden.nikitoci.com";
      postRun = "systemctl reload nginx.service";
      group = "nginx";
      dnsProvider = "hetzner";
      environmentFile = config.sops.secrets.hetzner-api-credentials.path;
    };
  };

  services.nginx.enable = true;
  services.nginx = {
    recommendedTlsSettings = true;
  };
}
