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

    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      # fix (?) crackling audio
      extraConfig = {
        pipewire."92-low-latency" = {
          context.properties = {
            "default.clock.allowed-rates" = [
              44100
              48000
              96000
            ];
            "default.clock.quantum" = 32;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 32;
          };
        };
        pipewire-pulse."92-low-latency" = {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                "pulse.min.req" = "32/48000";
                "pulse.default.req" = "32/48000";
                "pulse.max.req" = "32/48000";
                "pulse.min.quantum" = "32/48000";
                "pulse.max.quantum" = "32/48000";
              };
            }
          ];
          stream.properties = {
            "node.latency" = "32/48000";
            "resample.quality" = 1;
          };
        };

      };
    };
  };

  security.rtkit.enable = true;

  services.gvfs.enable = true;
}
