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
    ];
  };

  # TODO: seems like below enables clr.icd and clr
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/hardware/amdgpu.nix
  # featuremask is turned on here now
  hardware.amdgpu = {
    opencl.enable = true;
  };

  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  # Force radv
  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  };
}
