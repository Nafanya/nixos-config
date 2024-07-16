{
  config,
  lib,
  pkgs,
  ...
}:
{
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
