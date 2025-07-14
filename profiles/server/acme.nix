{ config, inputs, ... }:
{
  sops.secrets."creds/hetzner.env" = {
    owner = "nginx";
    sopsFile = "${inputs.self}/secrets/creds/hetzner.env";
    format = "dotenv";
  };

  security.acme = {
    acceptTerms = true;

    defaults = {
      email = "nikita.yaschenko@gmail.com";
      dnsResolver = "185.12.64.1"; # Hetzner
      dnsProvider = "hetzner";
      environmentFile = config.sops.secrets."creds/hetzner.env".path;
      postRun = "systemctl reload nginx.service";
    };

    certs = {
      "nikitoci.com" = {
        extraDomainNames = [ "bitwarden.nikitoci.com" ];
      };
      "local.nikitoci.com" = {
        extraDomainNames = [ "*.local.nikitoci.com" ];
      };
    };
  };
}
