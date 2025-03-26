{
  config,
  lib,
  pkgs,
  ...
}:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
      rocmPackages.rocminfo
      rocmPackages.rocm-runtime
      libva
      libva-utils
      vdpauinfo

      # https://wiki.nixos.org/wiki/AMD_GPU#Vulkan
      amdvlk
    ];

    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  # Force radv
  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  };

  environment.systemPackages = [
    pkgs.cudaPackages.cudatoolkit
  ];
}
