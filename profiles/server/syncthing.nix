{ ... }:
{
  services.syncthing = {
    enable = true;
    user = "nikita";
    dataDir = "/mnt/data/sync";
    configDir = "/home/nikita/.config/syncthing";
    openDefaultPorts = true;
  };
}
