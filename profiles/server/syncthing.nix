{ ... }:
{
  services.syncthing = {
    enable = true;
    user = "nikita";
    configDir = "/home/nikita/.config/syncthing";
    openDefaultPorts = true;
    overrideFolders = false;
    overrideDevices = false;
    settings = {
      devices = {
        leopard = {
          id = "A23S6NC-Q22CNST-OCFFVLI-7LCMJTN-AHHMYBF-COFXAMV-QD4RSRW-3M6MFAK";
        };
        iphone = {
          id = "E3UWCTV-H7V2QEP-NVNAW7T-PYK4BJC-WXBZWFR-GWGXGOX-6KJIJZE-INODRQG";
        };
      };
      folders = {
        "Documents" = {
          path = "/mnt/data/documents";
        };
        "Obsidian" = {
          path = "/mnt/data/obsidian";
          devices = [
            "leopard"
            "iphone"
          ];
        };
      };
    };
  };

  # Don't create default ~/Sync folder
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
