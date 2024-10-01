{ config, ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  users.users.nginx.extraGroups = [ config.users.groups.acme.name ];

  services.nginx = {
    enable = true;

    clientMaxBodySize = "512M";

    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    recommendedGzipSettings = true;
    recommendedBrotliSettings = true;
  };
}
