{ config, ... }:
{
  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  # services.radarr = {
  #   enable = true;
  #   openFirewall = true;
  # };
}
