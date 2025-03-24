{ config, pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
      wlrobs
      obs-vkcapture
      obs-webkitgtk
    ];
  };

  environment.systemPackages = [ pkgs.cameractrls ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=3 video_nr=5,6,7 card_label="Web Camera,OBS Camera,Discord Camera" exclusive_caps=1,1,1
  '';
  security.polkit.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", KERNEL=="video[5-7]*", SUBSYSTEM=="video4linux", RUN+="${pkgs.systemd}/bin/systemd-run --user start v4l2-ffmpeg@%k.service"
  '';

  # Copy camera feed to three v4l2 devices:
  # ffmpeg -f v4l2 -input_format mjpeg -framerate 60 -video_size 1920x1080 -i /dev/video0 -c:v copy \
  #        -f tee -map 0:v "[f=v4l2]/dev/video5|[f=v4l2]/dev/video6|[f=v4l2]/dev/video7"
}
