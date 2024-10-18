{
  config,
  pkgs,
  flake-inputs,
  ...
}:
{
  imports = [ ./kde.nix ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit flake-inputs;
      nixos-config = config;
    };
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

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
