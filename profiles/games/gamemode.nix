{ pkgs, ... }:
{
  home-manager.users.nikita.home.packages = with pkgs; [
    mangohud
    lact
    amdgpu_top
    mangojuice
    vkbasalt
    vkbasalt-cli
    heroic
  ];

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
    "amdgpu.ppfeaturemask=0xFFFFFFFF"
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
