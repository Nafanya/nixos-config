{ config, pkgs, ... }:
{
  security.rtkit.enable = true;
  # Fix rtkit bug from 2011: https://github.com/heftig/rtkit/issues/13
  # As per https://wiki.archlinux.org/title/PipeWire#Missing_realtime_priority/crackling_under_load_after_suspend
  # Note: existing entry for ExecStart needs to be cleared using ""
  systemd.services.rtkit-daemon.serviceConfig.ExecStart = [
    ""
    "${pkgs.rtkit}/libexec/rtkit-daemon --no-canary"
  ];

  # AirPlay/RAOP discovery
  services.avahi.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
    };
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    raopOpenFirewall = true;

    extraConfig = {
      pipewire."95-obs-sink" = {
        "context.objects" = [
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "OBS sink";
              "media.class" = "Audio/Sink";
              "object.linger" = true;
              "audio.position" = "FL,FR";
              "monitor.channel-volumes" = true;
              "monitor.passthrough" = true;
            };
          }
        ];
      };
      pipewire."10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";

            # increase the buffer size if you get dropouts/glitches
            # args = {
            #   "raop.latency.ms" = 500;
            # };
          }
        ];
      };
      pipewire."50-netter-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 128; # 32 is default
          "default.clock.min-quantum" = 16;
          "default.clock.max-quantum" = 768;
        };
      };
    };
  };
}
