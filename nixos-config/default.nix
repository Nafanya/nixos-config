{
  config,
  pkgs,
  flake-inputs,
  ...
}:
{
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

  services.gvfs.enable = true;
}
