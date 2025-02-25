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

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  environment.systemPackages = [
    pkgs.cudaPackages.cudatoolkit
  ];
}
