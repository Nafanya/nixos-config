{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.self.nixosModules.modules.xray-nikitoci ];

  networking = {
    hostName = "pc";
    hostId = "96b954d2";
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    firewall.enable = true;
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = [ ];

    #TODO: share with other machines
    hosts = {
      "192.168.1.250" = [
        "jellyfin.local.nikitoci.com"
        "homebridge.local.nikitoci.com"
        "hass.local.nikitoci.com"
        "cloud.local.nikitoci.com"
      ];
    };

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp0s20f0u11u1.useDHCP = lib.mkDefault true;
  };

  #users.users.xray = {
  #  isSystemUser = true;
  #  group = "xray";
  #};
  #users.groups.xray = { };

  sops.secrets."xray-client.json" = {
    format = "binary";
    sopsFile = "${inputs.self}/secrets/xray-client-config";
    owner = config.users.users.xray.name;
    group = config.users.groups.xray.name;
  };

  services.xray-nikitoci = {
    enable = true;
    settingsFile = config.sops.secrets."xray-client.json".path;
  };

}
