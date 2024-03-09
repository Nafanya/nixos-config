{ config, pkgs, ... }: {
  hardware.openrazer = {
    enable = true;
    mouseBatteryNotifier = false;
    users = [ "nikita" ];
  };

  environment.systemPackages = with pkgs; [ openrazer-daemon polychromatic ];
}
