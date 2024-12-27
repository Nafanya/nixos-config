{ config, ... }:
{
  fileSystems."/mnt/export/videos" = {
    device = "/mnt/data/videos";
    options = [ "bind" ];
  };

  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/export 192.168.1.0/24(rw,fsid=0,no_subtree_check)
      /mnt/export/videos 192.168.1.0/24(rw,nohide,insecure,no_subtree_check)
    '';
  };
}
