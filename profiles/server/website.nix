{ ... }:
{
  services.nginx = {
    virtualHosts."nikitoci.com" = {
      useACMEHost = "nikitoci.com";
      root = "/srv/www/nikitoci.com";
      locations."/" = {
        index = "index.html";
      };
    };
  };
}
