{ config, pkgs, ... }: {

  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      domain = "http://lynx.local";
      websocketEnable = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 8222 ];
}
