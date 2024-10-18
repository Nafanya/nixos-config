{
  config,
  lib,
  pkgs,
  ...
}:
{
  hardware.opengl.enable = true;

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
      cudatoolkit
    ];
  };

  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ]; # modesetting for amd, 1st in order
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
  };
}
