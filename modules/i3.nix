{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager = { defaultSession = "none+i3"; };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dunst # notifcation daemon
        feh # set wallpaper
        i3blocks
        i3lock
        i3status
        rofi # app launcher, instead of dmenu
      ];
      extraSessionCommands = ''
        xrandr --output DP-2 --mode 2560x1440 --rate 144.00
      '';
    };
    xkb = {
      options = "grp:caps_toggle";
      layout = "us,ru";
    };
  };

  environment.systemPackages = [ pkgs.mpv pkgs.xscreensaver ];
}
