{
  pkgs,
  lib,
  config,
  ...
}:
{
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
          "NixOS Wiki" = {
            urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
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
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g";
          # builtin engines only support specifying one additional alias}
        };
      };
    };
  };

  home.sessionVariables = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux {
      MOZ_USE_XINPUT2 = "1"; # for smooth scrolling in firefox
    })
  ];
}
