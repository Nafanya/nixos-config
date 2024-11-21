{ ... }:
{
  services.syncthing = {
    enable = true;
    user = "nikita";
    configDir = "/home/nikita/.config/syncthing";
    openDefaultPorts = true;
    folders = {
      "Documents" = {
        path = "/mnt/data/documents";
      };
      "Obsidian" = {
        path = "/mnt/data/obsidian";
      };
    };
  };

  # Don't create default ~/Sync folder
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
