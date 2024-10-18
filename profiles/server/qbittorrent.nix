{ pkgs, ... }:
{
  systemd.services.qbittorrent = {
    after = [ "network.target" ];
    description = "QBitTorrent Web";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.qbittorrent-nox ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8173
      '';
      User = "nikita";
      Group = "users";
      MemoryMax = "8G";
      Restart = "always";
    };
  };
}
