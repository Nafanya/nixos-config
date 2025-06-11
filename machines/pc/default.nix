{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-amd

    inputs.self.nixosModules.roles.desktop

    inputs.self.nixosModules.profiles.games.steam
    inputs.self.nixosModules.profiles.games.gamemode
    inputs.self.nixosModules.profiles.games.openrazer
    inputs.self.nixosModules.profiles.games.minecraft
    inputs.self.nixosModules.profiles.openrgb

    inputs.self.nixosModules.profiles.server.syncthing
    inputs.self.nixosModules.profiles.server.nfs

    inputs.self.nixosModules.profiles.local-llm

    {
      nixpkgs.overlays = [
        inputs.nix-minecraft.overlay

        # Remove when fixed
        # 1. https://github.com/NixOS/nixpkgs/issues/409284
        # 2. hacky fix from upstream https://github.com/ggml-org/llama.cpp/pull/14047
        (final: prev: {
          # Override the llama-cpp package
          llama-cpp = prev.llama-cpp.overrideAttrs (oldAttrs: {
            # Append to the existing postPatch.
            # The `oldAttrs.postPatch or ""` handles cases where postPatch might not exist.
            postPatch =
              (oldAttrs.postPatch or "")
              + ''
                echo "Applying custom patch to ggml/src/ggml-vulkan/CMakeLists.txt"

                # This command finds the line containing "DCMAKE_RUNTIME_OUTPUT_DIRECTORY"
                # in the specified CMake file and deletes it.
                sed -i '/DCMAKE_RUNTIME_OUTPUT_DIRECTORY/d' ggml/src/ggml-vulkan/CMakeLists.txt
              '';
          });
        })

        (final: prev: {
          rpp = prev.rpp.overrideAttrs (oldAttrs: {
            version = "6.4.1";

            src = oldAttrs.src.override {
              rev = "rocm-6.4.1";
              hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
            };
          });
        })

        # Enable gfx1201 for ROCm
        # https://github.com/NixOS/nixpkgs/pull/414610
        (final: prev: {
          rocmPackages = prev.rocmPackages // rec {
            clr =
              (prev.rocmPackages.clr.override {
                localGpuTargets = [ "gfx1201" ];
              }).overrideAttrs
                (oldAttrs: {
                  passthru = oldAttrs.passthru // {
                    gpuTargets = oldAttrs.passthru.gpuTargets ++ [ "gfx1201" ];
                  };
                });

            rocminfo = (
              prev.rocmPackages.rocminfo.override {
                clr = clr;
              }
            );

            rocblas = (
              prev.rocmPackages.rocblas.override {
                clr = clr;
              }
            );

            rocsparse = (
              prev.rocmPackages.rocsparse.override {
                clr = clr;
              }
            );

            rocsolver = (
              prev.rocmPackages.rocsolver.override {
                clr = clr;
              }
            );

            hipblas = (
              prev.rocmPackages.hipblas.override {
                clr = clr;
              }
            );

            hipblaslt = (
              prev.rocmPackages.hipblaslt.override {
                clr = clr;
              }
            );
          };
        })
      ];
    }

    ./hardware-configuration.nix
    ./gpu.nix
    ./pci-passthrough.nix
    ./networking.nix
    ./disks.nix
    ./ssh-hosts.nix
    ./virtualisation.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 25;
      };
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
  };

  system.stateVersion = "24.05";
}
