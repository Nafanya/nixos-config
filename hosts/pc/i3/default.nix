{ config, pkgs, ... }: {

  xdg.configFile = {
    "i3/config".source = ./config;
    "i3/assignments.conf".source = ./assignments.conf;
    "polybar/config".source = ./polybar/config;
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    #TODO: use systemd for logs / startup / restart
    script = ''
      polybar-msg cmd quit
      polybar top 2>&1 | tee -a /tmp/polybar-top.log & disown
    '';
  };
}
