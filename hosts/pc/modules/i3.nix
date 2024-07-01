{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "plasma";
      sddm.enable = true;
      sddm.wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    xkb = {
      options = "grp:caps_toggle";
      layout = "us,ru";
    };
  };

  #TODO: move to separate KDE file
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    mpv
    xscreensaver
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
  ];
}
