{ config, lib, pkgs, ... }: {

  networking.firewall.allowedTCPPorts = [ 548 ];

  services.netatalk = {
    enable = true;
    settings = {
      Global = {
        "mimic model" = "TimeCapsule6,106";
        "log level" = "default:info";
      };
      Homes = {
        "basedir regex" = "/home";
        path = "netatalk";
      };
      TimeMachine = {
        path = "/home/nikita/.timemachine";
        "time machine" = "yes";
      };
    };
  };
}
