{ config, pkgs, ... }: {
  hardware.openrazer = {
    enable = true;
    mouseBatteryNotifier = false;
    users = [ "nikita" ];
  };

}
