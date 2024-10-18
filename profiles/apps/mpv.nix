{ ... }:
{
  home-manager.users.nikita = {

    xdg.configFile."mpv/shaders".source = ./shaders;

    programs.mpv = {
      enable = true;
      config = {
        profile = "gpu-hq";
        ytdl-format = "bestvideo+bestaudio";
      };
      profiles = {
        gpu-hq = { };
      };
      bindings = {
        "CTRL+1" = "no-osd change-list glsl-shaders set \"~~/shaders/fsr.glsl\"; show-text \"FSR enabled\"";
        "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"FSR disabled\"";
      };
    };
  };
}
