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

  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  environment.sessionVariables = {
    # Seems to fix constant GPU throttling
    # See https://gitlab.freedesktop.org/mesa/mesa/-/issues/11744#note_2536404
    radv_force_pstate_peak_gfx11_dgpu = "false";
  };

  environment.systemPackages = [
    pkgs.cudaPackages.cudatoolkit
  ];
}
