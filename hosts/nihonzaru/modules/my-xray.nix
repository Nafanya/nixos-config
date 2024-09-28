{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

{
  options = {

    services.nikitoci-xray = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to run xray server.

          Either `settingsFile` or `settings` must be specified.
        '';
      };

      package = mkPackageOption pkgs "xray" { };

      settingsFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = "/etc/xray/config.json";
        description = ''
          The absolute path to the configuration file.

          Either `settingsFile` or `settings` must be specified.

          See <https://www.v2fly.org/en_US/config/overview.html>.
        '';
      };

      settings = mkOption {
        type = types.nullOr (types.attrsOf types.unspecified);
        default = null;
        example = {
          inbounds = [
            {
              port = 1080;
              listen = "127.0.0.1";
              protocol = "http";
            }
          ];
          outbounds = [ { protocol = "freedom"; } ];
        };
        description = ''
          The configuration object.

          Either `settingsFile` or `settings` must be specified.

          See <https://www.v2fly.org/en_US/config/overview.html>.
        '';
      };
    };

  };

  config =
    let
      cfg = config.services.nikitoci-xray;
      user = config.users.users.xray.name;
      group = config.users.groups.xray.name;
      settingsFile =
        if cfg.settingsFile != null then
          cfg.settingsFile
        else
          pkgs.writeTextFile {
            name = "xray.json";
            text = builtins.toJSON cfg.settings;
            checkPhase = ''
              ${cfg.package}/bin/xray -test -config $out
            '';
          };

    in
    mkIf cfg.enable {
      assertions = [
        {
          assertion = (cfg.settingsFile == null) != (cfg.settings == null);
          message = "Either but not both `settingsFile` and `settings` should be specified for xray.";
        }
      ];

      users.users.xray = {
        inherit group;
        isSystemUser = true;
      };
      users.groups.xray = { };

      systemd.services.nikitoci-xray = {
        description = "xray Daemon";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          User = user;
          Group = group;
          ExecStart = "${cfg.package}/bin/xray -config ${settingsFile}";
          PrivateTmp = "true";
          PrivateDevices = "true";
          ProtectHome = "true";
          ProtectSystem = "strict";
          CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
          AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
          NoNewPrivileges = true;
          StateDirectory = "xray";
          StateDirectoryMode = "0700";
          Restart = "always";
        };
      };
    };
}
