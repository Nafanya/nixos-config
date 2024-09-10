{
  config,
  pkgs,
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.home-manager.nixosModules.home-manager
    flake-inputs.sops-nix.nixosModules.sops

    ./kde.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

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

  time.timeZone = "Europe/London";

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      nikita = {
        isNormalUser = true;
        description = "nikitos";
        extraGroups = [ "wheel" ];
      };

      natali = {
        isNormalUser = true;
        description = "natali";
      };
    };
  };

  documentation.man.generateCaches = true;

  environment = {
    systemPackages = with pkgs; [ pavucontrol ];
  };

  programs = {
    dconf.enable = true;
    git.enable = true;
    htop.enable = true;
    neovim = {
      enable = true;
      vimAlias = true;
    };
    nano.enable = false;
    zsh.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      powerline-fonts
      powerline-symbols
      source-code-pro
      (nerdfonts.override {
        fonts = [
          "SpaceMono"
          "JetBrainsMono"
          "DejaVuSansMono"
          "SourceCodePro"
        ];
      })
    ];
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
