{ pkgs, ... }:
{
  services.xserver = {
    displayManager = {
      defaultSession = "plasma";
      sddm.enable = true;
      sddm.wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
  ];
}
