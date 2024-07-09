{
  config,
  pkgs,
  home,
  ...
}:
{
  home.packages = with pkgs; [ spotify-tui ];

  disabledModules = [ "services/spotifyd.nix" ];

  imports = [
    # My "fork" of hm.services.spotifyd module
    ./spotifyd.nix
  ];

  services.spotifyd = {
    enable = true;
  };
}
