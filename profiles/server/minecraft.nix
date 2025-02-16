{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = true;
    serverProperties = {
      "rcon.port" = 25575;
      online-mode = false;
      difficulty = 2;
      gamemode = "normal";
      level-name = "world";
      motd = "Nikitoci's Minecraft Server";
    };
  };
}
