{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/var/lib/minecraft-servers";

    servers.friends-test = {
      enable = true;
      package = pkgs.paperServers.paper-1_21_4;

      serverProperties = {
        "rcon.port" = 25575;
        online-mode = false;
        difficulty = 2;
        gamemode = "normal";
        level-name = "world";
        motd = "Nikitoci's TEST Minecraft Server";
      };

      symlinks = {
        "plugins/authme.jar" = pkgs.fetchurl {
          url = "https://ci.codemc.io/job/AuthMe/job/AuthMeReloaded/lastSuccessfulBuild/artifact/target/authme-5.7.0-SNAPSHOT.jar";
          sha512 = "8ac27b92df63198846b5b2117362a9f930f529761415bf7145383bac98925a6d7a880254d5b3913e65992e5abab6f4d1d679241bdbb56001a1df17cdb30f3a52";
        };
      };
    };
  };
}
