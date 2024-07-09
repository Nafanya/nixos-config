{
  config,
  lib,
  pkgs,
  ...
}:
{

  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    glib # for gio
    android-file-transfer
  ];
}
