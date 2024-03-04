{ config, lib, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;

    # Enables proxy settings globally
    #recommendedProxySettings = true;

    # TODO: remove when everything works
    logError = "stderr debug";
  };

  security.acme = {
    defaults.email = "nikita.yaschenko@gmail.com";
    acceptTerms = true;
  };

}
