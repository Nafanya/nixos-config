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
      dnsResolver = "1.1.1.1:53"; # Cloudflare
      dnsProvider = "hetzner";
      environmentFile = config.sops.secrets."creds/hetzner.env".path;
    };

    certs = {
      "nikitoci.com" = { };
      "local.nikitoci.com" = {
        extraDomainNames = [ "*.local.nikitoci.com" ];
      };
    };
  };
}
