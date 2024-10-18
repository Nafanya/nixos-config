{ config, pkgs, ... }:
{

  services = {
    xserver = {
      enable = true;
      xkb = {
        options = "grp:caps_toggle";
        layout = "us,ru";
      };
    };
    dbus.enable = true;

    displayManager = {
      defaultSession = "plasma";
      sddm.enable = true;
      sddm.wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  programs.kdeconnect.enable = true;

  programs.partition-manager.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages =
    with pkgs;
    [
      pavucontrol

      clinfo
      glxinfo
      vulkan-tools
      wayland-utils
    ]
    ++ (with kdePackages; [
      ksystemlog
      filelight
    ]);
}
