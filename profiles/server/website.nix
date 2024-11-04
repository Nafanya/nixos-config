{ ... }:
{
  services.nginx = {
    virtualHosts."nikitoci.com" = {
      useACMEHost = "nikitoci.com";
      onlySSL = true;
      root = "/srv/www/nikitoci.com";
      locations."/" = {
        index = "index.html";
      };
    };
  };
}
