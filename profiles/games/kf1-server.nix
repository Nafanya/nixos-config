{
  config,
  pkgs,
  lib,
  utils,
  ...
}:
let
  steam-app = "215360";
in
{
  imports = [
    ./steam-server.nix
  ];

  users.users.kf1-server = {
    isSystemUser = true;
    home = "/var/lib/kf1-server";
    createHome = true;
    homeMode = "750";
    group = "kf1-server";
  };

  users.groups.kf1-server = { };

  systemd.services.kf1-server = {
    wantedBy = [ "multi-user.target" ];

    # Install before launching
    #wants = [ "steam@${steam-app}.service" ];
    #after = [ "steam@${steam-app}.service" ];

    serviceConfig = {
      ExecStart = utils.escapeSystemdExecArgs [
        "${pkgs.steam-run}/bin/steam-run"
        "/var/lib/steam-app-${steam-app}/System/ucc-bin"
        "server"
        "KF-bioticslab.rom?game=KFmod.KFGameType?VACSecured=true?MaxPlayers=5"
      ];
      Nice = "-5";
      PrivateTmp = true;
      Restart = "always";
      User = "kf1-server";
      Group = "kf1-server";
      Type = "forking";
      WorkingDirectory = "/var/lib/steam-app-${steam-app}/System";
    };
    environment = {
      SteamAppId = "215360";
    };
  };

  networking.firewall.allowedTCPPorts = [
    28852
    8075
  ];
  networking.firewall.allowedUDPPorts = [
    7707
    7708
    7717
    20560
  ];
}
