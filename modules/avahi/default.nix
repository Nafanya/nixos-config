{ config, lib, pkgs, ... }: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    virtualHosts = let
      base = locations: { inherit locations; };
      proxy = port:
        base {
          "/" = {
            proxyPass = "http://[::1]:" + toString (port) + "/";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_buffering off;
              proxy_cache_bypass 1;
              proxy_no_cache 1;
            '';
          };
        };
    in { "jellyfin.local" = proxy 8096; };

    #virtualHosts."hass.local" = {
    #  locations."/" = {
    #    proxyPass = "http://hass.local:8123";
    #    extraConfig = ''
    #      proxy_cache_bypass 1;
    #      proxy_no_cache 1;
    #      port_in_redirect on;
    #    '';
    #  };
    #};
    #virtualHosts."jellyfin.local" = {
    #  locations."/" = {
    #    proxyPass = "http://jellyfin.local:8096";
    #    extraConfig = ''
    #      proxy_cache_bypass 1;
    #      proxy_no_cache 1;
    #      port_in_redirect on;
    #    '';
    #  };
    #};
  };
}
