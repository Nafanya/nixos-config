{
  config,
  inputs,
  pkgs,
  ...
}:
let
  listenPort = 8443; # if changing, update in config as well
in
{
  imports = [ inputs.self.nixosModules.modules.xray-nikitoci ];

  sops.secrets."xray-config.json" = {
    format = "binary";
    sopsFile = "${inputs.self}/secrets/xray-config-json";
    owner = config.users.users.xray.name;
    group = config.users.groups.xray.name;
  };

  networking.firewall.allowedTCPPorts = [ listenPort ];

  services.xray-nikitoci = {
    enable = true;
    settingsFile = config.sops.secrets."xray-config.json".path;
  };
}
