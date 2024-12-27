{ ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/433be29d-9a9f-417c-96d2-828e5d287a63";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/60A4-FDAC";
    fsType = "vfat";
  };

  fileSystems."/mnt/videos" = {
    device = "192.168.1.240:/videos";
    fsType = "nfs";
  };
}
