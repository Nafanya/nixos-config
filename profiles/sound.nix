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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        "51-disable-radeon-hdmi" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "device.name" = "alsa_card.pci-0000_03_00.1";
                }
              ];
              actions = {
                update-props = {
                  "device.disabled" = true;
                };
              };
            }
          ];
        };
      };
    };
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
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
    };
  };
}
