{
  pkgs,
  lib,
  config,
  ...
}:
{
  home-manager.users.nikita = {
    programs.firefox = {
      enable = true;
      #TODO: fix this and other conditional for linux/darwin
      package = if pkgs.stdenv.isLinux then pkgs.firefox else pkgs.firefox-bin;
      profiles.nikita = {
        containersForce = true;
        #TODO: add extensions
        containers = {
          personal = {
            id = 0;
            name = "Personal";
            color = "pink";
            icon = "fingerprint";
          };
          work = {
            id = 1;
            name = "Work";
            color = "orange";
            icon = "briefcase";
          };
          banking = {
            id = 2;
            name = "Banking";
            color = "green";
            icon = "dollar";
          };
          shopping = {
            id = 3;
            name = "Shopping";
            color = "turquoise";
            icon = "cart";
          };
        };
        search = {
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Wiki (old)" = {
              urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nwo" ];
            };
            "NixOS Wiki" = {
              urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nw" ];
            };
            "NixOS Options" = {
              urls = [ { template = "https://search.nixos.org/options?query={searchTerms}"; } ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };
            "Home Manager Options" = {
              urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];
              definedAliases = [ "@hmo" ];
            };
            "Arch Linux Wiki" = {
              urls = [ { template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; } ];
              definedAliases = [ "@aw" ];
            };
            bing.metaData.hidden = true;
            google.metaData.alias = "@g";
          };
        };
      };
    };

    home.sessionVariables = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux {
        MOZ_USE_XINPUT2 = "1"; # for smooth scrolling in firefox
      })
    ];
  };
}
