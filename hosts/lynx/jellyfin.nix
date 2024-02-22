{ config, lib, pkgs, ... }: {

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.nginx = {
    virtualHosts."jellyfin.local" = {
      locations = {
        # based on https://jellyfin.org/docs/general/networking/nginx

        "= /" = { return = "302 http://$host/web/"; };
        "/" = {
          proxyPass = "http://127.0.0.1:8096";
          extraConfig = ''
            proxy_buffering off;
          '';
        };
        "= /web/" = { proxyPass = "http://127.0.0.1:8096/web/index.html"; };
        "/socket" = {
          proxyPass = "http://127.0.0.1:8096";
          proxyWebsockets = true;
        };
      };
    };
  };
}
