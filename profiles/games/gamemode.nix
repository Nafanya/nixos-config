{ pkgs, ... }:
{
  home-manager.users.nikita.home.packages = with pkgs; [
    mangohud
    lact
    furmark
  ];

  #TODO: extract LACT to separate profile
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
  boot.kernelParams = [
    # Enable overclocking -- needed by LACT
    "amdgpu.ppfeaturemask=0xFFF7FFFF"
  ];

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
  users.users.nikita.extraGroups = [ "gamemode" ];
}
