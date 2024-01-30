{ config, pkgs, ... }: {

  xdg.configFile = {
    "i3/config".source = ./config;
    "i3/assignments.conf".source = ./assignments.conf;
    "polybar/config.ini".source = ./polybar/config.ini;
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    script = ''
      polybar top &
    '';
  };
}
