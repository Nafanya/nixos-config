{ config, pkgs, ... }: {
  xdg.configFile = {
    "i3/config".source = ./config;
    "i3status/config".source = ./i3status.conf;
  };

  #TODO: check if dpi settings required here
  # set cursor size and dpi for 2560x1440 monitor
  ##xresources.properties = {
  ##  "Xcursor.size" = 16;
  ##  "Xft.dpi" = 107;
  ##};
}
