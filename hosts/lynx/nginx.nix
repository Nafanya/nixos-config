{ config, lib, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    logError = "stderr debug";
  };

}
