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
}
