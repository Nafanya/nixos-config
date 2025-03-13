{ config, pkgs, ... }:
{

  services = {
    xserver = {
      enable = true;
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
      kdePackages.xdg-desktop-portal-kde
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
