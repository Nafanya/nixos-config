{
  config,
  lib,
  pkgs,
  ...
}:
{

  services.zfs.autoScrub.enable = lib.mkDefault true;
  specialisation.experimental = {
    configuration = {
      services.zfs.autoScrub.enable = lib.mkForce false;
    };
  };

  environment.systemPackages = with pkgs; [
    smartmontools
    kdePackages.plasma-disks
  ];

  services.smartd.enable = true;

  hardware.sensor.hddtemp = {
    enable = true;
    drives = [
      "/dev/sda"
      "/dev/sdb"
    ];
  };
}
