{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.spotifyd;

in {
  options.services.spotifyd = {
    enable = mkEnableOption "SpotifyD connect (customised)";

    package = mkOption {
      type = types.package;
      default = pkgs.spotifyd;
      defaultText = literalExpression "pkgs.spotifyd";
      example =
        literalExpression "(pkgs.spotifyd.override { withKeyring = true; })";
      description = ''
        The `spotifyd` package to use.
        Can be used to specify extensions.
      '';
    };

    configFile = mkOption {
      type = types.str;
      default = "${config.xdg.configHome}/spotifyd/spotifyd.conf";
      defaultText = "$XDG_CONFIG_HOME/spotifyd";
      description = "Path to the configuration file read by spotifyd.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "services.spotifyd" pkgs
        lib.platforms.linux)
    ];

    home.packages = [ cfg.package ];

    systemd.user.services.spotifyd = {
      Unit = {
        Description = "spotify daemon (customised)";
        Documentation = "https://github.com/Spotifyd/spotifyd";
      };

      Install.WantedBy = [ "default.target" ];

      Service = {
        ExecStart =
          "${cfg.package}/bin/spotifyd --no-daemon --config-path ${cfg.configFile}";
        Restart = "always";
        RestartSec = 12;
      };
    };
  };
}
