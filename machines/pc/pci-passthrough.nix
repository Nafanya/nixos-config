{
  pkgs,
  lib,
  config,
  ...
}:
{
  boot = {
    kernelModules = [
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
    ];
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];
    blacklistedKernelModules = [
      "nvidia"
      "nouveau"
    ];
    kernelParams = [
      "intel_iommu=on"

      # Tesla P4
      "vfio-pci.ids=10de:1bb3"
    ];
  };

  hardware.graphics.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  services.tailscale.enable = true;
}
