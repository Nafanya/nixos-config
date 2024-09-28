{ config, pkgs, ... }:
let
  listenPort = 8443; # if changing, update in config as well
in
{
  sops.secrets."xray-config.json" = {
    format = "binary";
    sopsFile = ../secrets/xray-config-json;
    owner = config.users.users.xray.name;
    group = config.users.users.xray.group;
  };

  networking.firewall.allowedTCPPorts = [ listenPort ];

  services.nikitoci-xray = {
    enable = true;
    settingsFile = config.sops.secrets."xray-config.json".path;
  };
}
