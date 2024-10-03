{
  config,
  inputs,
  pkgs,
  ...
}:
let
  domain = "cloud.local.nikitoci.com";
in
{
  sops.secrets."nextcloud-admin-pass" = {
    format = "binary";
    owner = config.users.users.nextcloud.name;
    sopsFile = "${inputs.self}/secrets/nextcloud-admin-pass";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = domain;
    database.createLocally = true;
    https = true;
    config = {
      adminuser = "nikita";
      adminpassFile = config.sops.secrets."nextcloud-admin-pass".path;
    };
  };

  services.nginx = {
    virtualHosts."${domain}" = {
      useACMEHost = "local.nikitoci.com";
      onlySSL = true;
    };
  };
}
