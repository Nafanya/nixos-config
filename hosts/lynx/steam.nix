{ config, pkgs, ... }:

{
  users.users.steam = {
    isNormalUser = true;
    description = "Steam runner";
    packages = with pkgs; [ steam steamcmd ];
  };

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };

  systemd.services.valheim-server = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Start Valheim server for friends.";
    serviceConfig = {
      # see systemd man pages for more information on the various options for "Type": "notify"
      # specifies that this is a service that waits for notification from its predecessor (declared in
      # `after=`) before starting
      Type = "notify";
      # username that systemd will look for; if it exists, it will start a service associated with that user
      User = "steam";
      # the command to execute when the service starts up
      # TODO: extract options from script
      ExecStart = "/home/steam/games/valheim/my-server.sh";
      KillSignal = SIGINT;
      Restart = "always";
      RestartSec = 30;
    };
  };
}
