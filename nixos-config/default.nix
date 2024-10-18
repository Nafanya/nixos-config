{
  config,
  pkgs,
  flake-inputs,
  ...
}:
{
  imports = [ ./kde.nix ];

  users = {
    users = {
      natali = {
        isNormalUser = true;
        description = "natali";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [ pavucontrol ];
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        options = "grp:caps_toggle";
        layout = "us,ru";
      };
    };
    dbus.enable = true;
  };

  services.gvfs.enable = true;
}
