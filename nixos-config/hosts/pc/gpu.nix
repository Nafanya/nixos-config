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
      libva
      libva-utils
      vdpauinfo
    ];
  };

  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
}
