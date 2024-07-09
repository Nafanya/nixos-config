{
  config,
  pkgs,
  lib,
  ...
}:
{

  users.users.nikita.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJnSWkY3hvd27BbsNGDRkeL2/XDY1d96Szsz79P0lXCH nikita.yaschenko@gmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINTeQWq1hmUPwDBvMVeWD9xa/c9IBvo2q+uxNXWySC2e nikita.yaschenko@gmail.com"
  ];

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "en_GB.UTF-8";

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      powerline-fonts
      powerline-symbols
      source-code-pro
      (nerdfonts.override {
        fonts = [
          "SpaceMono"
          "JetBrainsMono"
          "DejaVuSansMono"
          "SourceCodePro"
        ];
      })
    ];
  };

  networking.firewall.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  programs.ssh.startAgent = true;

  environment.systemPackages = with pkgs; [
    wget
    screenkey
    #TODO: move to home
    #xorg.xhost
    #(mplayer.override { v4lSupport = true; })
    #(ffmpeg.override {
    #  withUnfree = true;
    #  withNvenc = true;
    #  withNvdec = true;
    #})
    davinci-resolve
    kdenlive
  ];

  security.rtkit.enable = true;
  services = {
    dbus.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
